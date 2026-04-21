import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../../models/quote_model.dart';
import 'local_storage_service.dart';

class QuoteService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseFunctions _functions = FirebaseFunctions.instance;

  static Future<List<QuoteModel>> getQuotes({String? category}) async {
    try {
      final categoryFilter = (category == null || category == 'All') ? null : category;
      
      final query = _firestore.collection('quotes');
      final finalQuery = categoryFilter != null 
          ? query.where('category', isEqualTo: categoryFilter)
          : query.orderBy('popularity_score', descending: true);

      // Robust timeout with a shorter cache source preference for speed
      final querySnapshot = await finalQuery
          .limit(50)
          .get(const GetOptions(source: Source.serverAndCache))
          .timeout(const Duration(seconds: 10)); // Increased for production reliability

      if (querySnapshot.docs.isEmpty) {
        return _getFallbackQuotes(category);
      }

      final quotes = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return QuoteModel.fromMap({...data, 'quote_id': doc.id});
      }).toList();
      
      await LocalStorageService.cacheQuotes(quotes);
      
      return quotes;
    } catch (e) {
      debugPrint('QuoteService Error [getQuotes]: $e');
      return _getFallbackQuotes(category);
    }
  }

  static Future<QuoteModel?> getDailyQuote() async {
    try {
      final now = DateTime.now();
      final dateStr = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
      
      final doc = await _firestore
          .collection('daily_quotes')
          .doc(dateStr)
          .get()
          .timeout(const Duration(seconds: 5));

      if (doc.exists) {
        final data = doc.data();
        if (data != null && data['quote_id'] != null) {
          final quoteDoc = await _firestore
              .collection('quotes')
              .doc(data['quote_id'])
              .get();
          if (quoteDoc.exists && quoteDoc.data() != null) {
            return QuoteModel.fromMap({...quoteDoc.data()!, 'quote_id': quoteDoc.id});
          }
        }
      }
      
      // If we reach here, we try to get one from the initial list or cache
      final fallback = _getFallbackQuotes(null);
      return fallback.isNotEmpty ? fallback.first : QuoteModel.initialList.first;
    } catch (e) {
      debugPrint('QuoteService Error [getDailyQuote]: $e');
      return QuoteModel.initialList.first;
    }
  }

  static Future<List<QuoteModel>> getFavorites() async {
    try {
      final HttpsCallable callable = _functions.httpsCallable('getFavorites');
      final response = await callable.call();
      
      if (response.data is List) {
        return (response.data as List)
            .map((q) => QuoteModel.fromMap(Map<String, dynamic>.from(q)))
            .toList();
      }
      return [];
    } catch (e) {
      // Fallback to local storage or empty list
      return [];
    }
  }

  static Future<bool> toggleFavorite(String quoteId, bool add) async {
    try {
      final HttpsCallable callable = _functions.httpsCallable('toggleFavorite');
      await callable.call({
        'quoteId': quoteId,
        'action': add ? 'add' : 'remove',
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> logShare(String quoteId) async {
    try {
      final HttpsCallable callable = _functions.httpsCallable('logShare');
      await callable.call({'quoteId': quoteId});
    } catch (e) {
      // Silent fail for analytics
    }
  }

  static List<QuoteModel> _getFallbackQuotes(String? category) {
    final cached = LocalStorageService.getCachedQuotes();
    final listToFilter = cached.isNotEmpty ? cached : QuoteModel.initialList;
    
    if (category == null || category == 'All') {
      return listToFilter;
    }
    return listToFilter.where((q) => q.category == category).toList();
  }
}
