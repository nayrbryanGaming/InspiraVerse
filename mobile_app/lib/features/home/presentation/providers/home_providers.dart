import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/quote_model.dart';
import '../../../../core/services/quote_service.dart';

final searchControllerProvider = StateProvider<String>((ref) => '');

final filteredQuotesProvider = FutureProvider.family<List<QuoteModel>, String>((ref, category) async {
  final searchQuery = ref.watch(searchControllerProvider).toLowerCase();
  final allQuotes = await QuoteService.getQuotes(category: category);
  
  if (searchQuery.isEmpty) {
    return allQuotes;
  }
  
  return allQuotes.where((quote) {
    return quote.text.toLowerCase().contains(searchQuery) ||
           quote.author.toLowerCase().contains(searchQuery);
  }).toList();
});
