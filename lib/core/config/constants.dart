/// Application-wide constants.
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // API Configuration
  /// Default API timeout in seconds
  static const int apiTimeoutSeconds = 30;

  /// Default API retry attempts
  static const int apiRetryAttempts = 3;

  /// Default API retry delay in milliseconds
  static const int apiRetryDelayMs = 1000;

  // Database Configuration
  /// Database name
  static const String databaseName = 'flutter_base_app.db';

  /// Database version
  static const int databaseVersion = 1;

  // Storage Keys
  /// Secure storage key for auth token
  static const String storageAuthToken = 'auth_token';

  /// Secure storage key for refresh token
  static const String storageRefreshToken = 'refresh_token';

  /// Secure storage key for user data
  static const String storageUserData = 'user_data';

  /// Secure storage key for theme mode preference
  static const String storageThemeMode = 'theme_mode';

  // Network Configuration
  /// Maximum number of concurrent network requests
  static const int maxConcurrentRequests = 5;

  /// Connection timeout in seconds
  static const int connectionTimeoutSeconds = 10;

  /// Receive timeout in seconds
  static const int receiveTimeoutSeconds = 30;

  // Sync Configuration
  /// Maximum sync queue size
  static const int maxSyncQueueSize = 100;

  /// Sync retry attempts
  static const int syncRetryAttempts = 3;

  /// Sync retry delay in milliseconds
  static const int syncRetryDelayMs = 2000;

  /// Batch sync size (number of items per batch)
  static const int batchSyncSize = 50;

  /// SSE reconnect delay in seconds
  static const int sseReconnectDelaySeconds = 3;

  /// SSE max reconnect attempts
  static const int sseMaxReconnectAttempts = 10;

  // Pagination
  /// Default page size
  static const int defaultPageSize = 20;

  /// Maximum page size
  static const int maxPageSize = 100;
}
