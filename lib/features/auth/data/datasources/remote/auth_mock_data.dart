import 'package:app_mobile_afms/features/auth/data/datasources/remote/auth_remote_datasource_mock.dart'
    show AuthRemoteDataSourceMock;

/// Mock data for Auth feature.
///
/// This file contains all mock data used in [AuthRemoteDataSourceMock].
/// Centralizing mock data makes it easier to maintain and update.
class AuthMockData {
  // Private constructor to prevent instantiation
  AuthMockData._();

  // Token Configuration
  /// Default token expiration time in seconds (1 hour)
  static const int defaultTokenExpirationSeconds = 3600;

  /// Default token type
  static const String defaultTokenType = 'Bearer';

  /// Mock employee ID for phone login
  static const int mockPhoneEmployeeId = 101;

  /// Mock employee ID for email login
  static const int mockEmailEmployeeId = 202;

  /// Mock employee ID for refresh token
  static const int mockRefreshEmployeeId = 303;

  /// Generate mock session ID with timestamp
  static String generateSessionId() {
    return 'mock_session_id_${DateTime.now().millisecondsSinceEpoch}';
  }

  /// Generate mock access token with timestamp
  static String generateAccessToken() {
    return 'mock_access_token_${DateTime.now().millisecondsSinceEpoch}';
  }

  /// Generate mock refresh token with timestamp
  static String generateRefreshToken() {
    return 'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}';
  }

  /// Generate mock refreshed access token with timestamp
  static String generateRefreshedAccessToken() {
    return 'mock_refreshed_token_${DateTime.now().millisecondsSinceEpoch}';
  }

  /// Create mock nested response structure for login
  ///
  /// Matches current API response returning sessionId & employeeId.
  static Map<String, dynamic> createLoginResponseData({
    required String sessionId,
    required int employeeId,
    String? accessToken,
    String? refreshToken,
    int? expiresIn,
    String? tokenType,
  }) {
    return {
      'data': {
        'success': true,
        'data': {
          'sessionId': sessionId,
          'employeeId': employeeId,
          if (accessToken != null) 'accessToken': accessToken,
          if (refreshToken != null) 'refreshToken': refreshToken,
          'expiresIn': expiresIn ?? defaultTokenExpirationSeconds,
          'tokenType': tokenType ?? defaultTokenType,
        },
        'metadata': {'timestamp': DateTime.now().toIso8601String()},
      },
    };
  }

  /// Create mock nested response structure for refresh token.
  static Map<String, dynamic> createRefreshTokenResponseData({
    required String accessToken,
    String? refreshToken,
    int? expiresIn,
    String? tokenType,
    int? employeeId,
    String? sessionId,
  }) {
    return {
      'data': {
        'accessToken': accessToken,
        if (refreshToken != null) 'refreshToken': refreshToken,
        'expiresIn': expiresIn ?? defaultTokenExpirationSeconds,
        'tokenType': tokenType ?? defaultTokenType,
        if (employeeId != null) 'employeeId': employeeId,
        if (sessionId != null) 'sessionId': sessionId,
      },
    };
  }

  /// Create mock request payload for phone login
  ///
  /// This matches the Real API request structure
  static Map<String, dynamic> createPhoneLoginRequestPayload({
    required String phoneNumber,
  }) {
    // Remove any non-digit characters except +
    final cleanedPhone = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    return {'phone': cleanedPhone};
  }

  /// Create mock request payload for email login
  ///
  /// This matches the Real API request structure
  static Map<String, dynamic> createEmailLoginRequestPayload({
    required String email,
    required String password,
  }) {
    return {'email': email, 'password': password};
  }

  /// Create mock request payload for refresh token
  ///
  /// This matches the Real API request structure
  static Map<String, dynamic> createRefreshTokenRequestPayload({
    required String refreshToken,
  }) {
    return {'refreshToken': refreshToken};
  }

  /// Create mock request payload for logout
  ///
  /// This matches the Real API request structure
  static Map<String, dynamic> createLogoutRequestPayload({
    required String sessionId,
  }) {
    return {'sessionId': sessionId};
  }

  /// Create mock headers for logout
  ///
  /// This matches the Real API header structure
  static Map<String, String> createLogoutHeaders({required String sessionId}) {
    return {'x-session-id': sessionId};
  }
}
