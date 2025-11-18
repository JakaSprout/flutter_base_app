/// API configuration constants.
///
/// Centralized configuration for API version, paths, and endpoints.
/// This makes it easier to maintain and update API URLs.
class ApiConstants {
  // Private constructor to prevent instantiation
  ApiConstants._();

  // API Version
  /// Current API version
  static const String apiVersion = 'v1';

  // API Base Paths
  /// Base path for API endpoints
  static const String apiBasePath = '/api';

  /// Auth endpoints base path
  static const String authBasePath = '$apiBasePath/$apiVersion/auth';

  /// Request Lab endpoints base path
  static const String requestLabBasePath =
      '$apiBasePath/$apiVersion/request-lab';

  /// Employee endpoints base path
  static const String employeeBasePath = '$apiBasePath/$apiVersion/employees';

  /// Customer endpoints base path
  static const String customerBasePath = '$apiBasePath/$apiVersion/customers';

  /// Farm endpoints base path
  static const String farmBasePath = '$apiBasePath/$apiVersion/farms';

  /// Sync endpoints base path
  static const String syncBasePath = '$apiBasePath/sync';

  // Auth Endpoints
  /// Login with email endpoint
  static const String authLoginEmail = '$authBasePath/login/email';

  /// Login with phone endpoint
  static const String authLoginPhone = '$authBasePath/login/phone';

  /// Logout endpoint
  static const String authLogout = '$authBasePath/logout';

  /// Refresh token endpoint
  static const String authRefreshToken = '$authBasePath/refresh';

  // Request Lab Endpoints
  /// Create lab request endpoint
  static const String requestLabCreate = requestLabBasePath;

  /// List lab requests endpoint
  static const String requestLabList = requestLabBasePath;

  // Employee Endpoints
  /// List employees endpoint
  static const String employeeList = employeeBasePath;

  // Customer Endpoints
  /// List customers endpoint
  static const String customerList = customerBasePath;

  // Farm Endpoints
  /// List farms endpoint
  static const String farmList = farmBasePath;

  // Sync Endpoints
  /// Batch sync endpoint
  static String syncBatch(String module) => '$syncBasePath/$module/batch';

  /// SSE events endpoint
  static const String syncEvents = '$syncBasePath/events';

  /// Build full API endpoint URL.
  ///
  /// Example:
  /// ```dart
  /// buildEndpoint('/auth/login') // Returns: '/api/v1/auth/login'
  /// ```
  static String buildEndpoint(String path) {
    // Remove leading slash if present
    final cleanPath = path.startsWith('/') ? path.substring(1) : path;
    return '$apiBasePath/$apiVersion/$cleanPath';
  }

  /// Build sync endpoint URL.
  ///
  /// Example:
  /// ```dart
  /// buildSyncEndpoint('events') // Returns: '/api/sync/events'
  /// ```
  static String buildSyncEndpoint(String path) {
    // Remove leading slash if present
    final cleanPath = path.startsWith('/') ? path.substring(1) : path;
    return '$syncBasePath/$cleanPath';
  }
}
