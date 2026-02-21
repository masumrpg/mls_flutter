class AppConstants {
  static const String appName = 'Flutter BLoC App';
  static const String apiBaseUrl = 'https://api.example.com';

  // Storage keys
  static const String keyAuthToken = 'auth_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';

  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration cacheTimeout = Duration(hours: 1);
}
