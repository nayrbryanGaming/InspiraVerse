import 'package:hive_flutter/hive_flutter.dart';
import '../constants/app_constants.dart';
import '../../models/quote_model.dart';

class LocalStorageService {
  static late Box _settingsBox;
  static late Box<Map> _favoritesBox;
  static late Box<Map> _quotesBox;

  static Future<void> initialize() async {
    _settingsBox = await Hive.openBox(AppConstants.settingsBox);
    _favoritesBox = await Hive.openBox<Map>(AppConstants.favoritesBox);
    _quotesBox = await Hive.openBox<Map>(AppConstants.quotesBox);
  }

  // Settings
  static bool get isOnboardingDone =>
      _settingsBox.get(AppConstants.prefOnboardingDone, defaultValue: false);

  static Future<void> setOnboardingDone(bool value) async {
    await _settingsBox.put(AppConstants.prefOnboardingDone, value);
  }

  static bool get isDailyNotificationEnabled =>
      _settingsBox.get(AppConstants.prefDailyNotification, defaultValue: true);

  static Future<void> setDailyNotification(bool value) async {
    await _settingsBox.put(AppConstants.prefDailyNotification, value);
  }

  static int get notificationHour =>
      _settingsBox.get(AppConstants.prefNotificationHour, defaultValue: 8);

  static int get notificationMinute =>
      _settingsBox.get(AppConstants.prefNotificationMinute, defaultValue: 0);

  static Future<void> setNotificationTime(int hour, int minute) async {
    await _settingsBox.put(AppConstants.prefNotificationHour, hour);
    await _settingsBox.put(AppConstants.prefNotificationMinute, minute);
  }

  static List<String> get selectedCategories {
    final stored = _settingsBox.get(AppConstants.prefSelectedCategories);
    if (stored == null) return AppConstants.quoteCategories;
    return List<String>.from(stored);
  }

  static Future<void> setSelectedCategories(List<String> categories) async {
    await _settingsBox.put(AppConstants.prefSelectedCategories, categories);
  }

  // Favorites
  static List<QuoteModel> getFavorites() {
    return _favoritesBox.values
        .map((map) => QuoteModel.fromMap(Map<String, dynamic>.from(map)))
        .toList();
  }

  static Future<void> addFavorite(QuoteModel quote) async {
    await _favoritesBox.put(quote.quoteId, quote.toMap());
  }

  static Future<void> removeFavorite(String quoteId) async {
    await _favoritesBox.delete(quoteId);
  }

  static bool isFavorite(String quoteId) {
    return _favoritesBox.containsKey(quoteId);
  }

  // Offline Quotes Cache
  static List<QuoteModel> getCachedQuotes() {
    return _quotesBox.values
        .map((map) => QuoteModel.fromMap(Map<String, dynamic>.from(map)))
        .toList();
  }

  static Future<void> cacheQuotes(List<QuoteModel> quotes) async {
    await _quotesBox.clear();
    for (final quote in quotes) {
      await _quotesBox.put(quote.quoteId, quote.toMap());
    }
  }

  static Future<void> clearAll() async {
    await _settingsBox.clear();
    await _favoritesBox.clear();
    await _quotesBox.clear();
  }
}
