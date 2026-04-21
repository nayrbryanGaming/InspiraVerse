class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'InspiraVerse';
  static const String appTagline = 'Daily quotes that fuel your mindset and shape your future.';
  static const String appVersion = '1.0.0+18';

  // Firestore Collections
  static const String usersCollection = 'users';
  static const String quotesCollection = 'quotes';
  static const String dailyQuotesCollection = 'daily_quotes';
  static const String userActivityCollection = 'user_activity';

  // Hive Box Names
  static const String quotesBox = 'quotes_box';
  static const String userBox = 'user_box';
  static const String settingsBox = 'settings_box';
  static const String favoritesBox = 'favorites_box';

  // Quote Categories
  static const List<String> quoteCategories = [
    'All',
    'Motivation',
    'Success',
    'Resilience',
    'Mindset',
    'Mindfulness',
    'Growth',
    'Wisdom',
    'Courage',
    'Leadership',
  ];

  static const Map<String, String> categoryEmojis = {
    'All': '✨',
    'Motivation': '🔥',
    'Success': '🏆',
    'Resilience': '💪',
    'Mindset': '🧠',
    'Mindfulness': '🧘',
    'Growth': '🌱',
    'Wisdom': '🦉',
    'Courage': '⚡',
    'Leadership': '👑',
  };

  // Notification
  static const String notificationChannelId = 'inspiraverse_daily';
  static const String notificationChannelName = 'Daily Inspiration';
  static const String notificationChannelDesc = 'Daily motivational quote notifications';

  // Preferences Keys
  static const String prefDailyNotification = 'daily_notification';
  static const String prefNotificationHour = 'notification_hour';
  static const String prefNotificationMinute = 'notification_minute';
  static const String prefThemeMode = 'theme_mode';
  static const String prefOnboardingDone = 'onboarding_done';
  static const String prefSelectedCategories = 'selected_categories';

  // Pagination
  static const int quotesPerPage = 20;
  static const int maxFavorites = 500;

  // Share Card Gradients (index pairs for gradient colors)
  static const List<List<int>> shareCardGradients = [
    [0xFF6C63FF, 0xFF8B5CF6],
    [0xFFFF6B6B, 0xFFFF8E53],
    [0xFF11998E, 0xFF38EF7D],
    [0xFF2193B0, 0xFF6DD5FA],
    [0xFF834D9B, 0xFFD04ED6],
    [0xFFFFB84D, 0xFFFF8C42],
  ];
}
