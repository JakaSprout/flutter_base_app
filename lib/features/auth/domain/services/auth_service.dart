import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/core/logging/logger.dart';
import 'package:flutter_base_app/features/auth/domain/entities/login_response.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/auth_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Service for managing authentication state and tokens.
///
/// This service handles:
/// - Token storage and retrieval
/// - Session validation
/// - Logout functionality
class AuthService {
  /// Creates a new instance of [AuthService].
  AuthService({required FlutterSecureStorage secureStorage})
    : _secureStorage = secureStorage;

  final FlutterSecureStorage _secureStorage;

  /// Check if user is currently authenticated.
  ///
  /// Returns `true` if a valid access token exists in secure storage.
  Future<bool> isAuthenticated() async {
    try {
      final token = await _secureStorage.read(
        key: AppConstants.storageAuthToken,
      );
      return token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Get the current access token.
  ///
  /// Returns the access token if available, `null` otherwise.
  Future<String?> getAccessToken() async {
    try {
      return await _secureStorage.read(key: AppConstants.storageAuthToken);
    } catch (e) {
      return null;
    }
  }

  /// Get the current refresh token.
  ///
  /// Returns the refresh token if available, `null` otherwise.
  Future<String?> getRefreshToken() async {
    try {
      return await _secureStorage.read(key: AppConstants.storageRefreshToken);
    } catch (e) {
      return null;
    }
  }

  /// Save authentication tokens after successful login.
  ///
  /// Stores both access token and refresh token securely.
  /// Also stores token expiration timestamp if available.
  Future<void> saveTokens(LoginResponse loginResponse) async {
    try {
      final futures = <Future<void>>[
        _secureStorage.write(
          key: AppConstants.storageAuthToken,
          value: loginResponse.accessToken,
        ),
        _secureStorage.write(
          key: AppConstants.storageRefreshToken,
          value: loginResponse.refreshToken,
        ),
      ];

      // Store token expiration timestamp if available
      if (loginResponse.expiresIn != null) {
        final expiresAt = DateTime.now()
            .add(Duration(seconds: loginResponse.expiresIn!))
            .toIso8601String();
        futures.add(
          _secureStorage.write(
            key: AppConstants.storageTokenExpiresAt,
            value: expiresAt,
          ),
        );
      }

      await Future.wait(futures);
    } catch (e) {
      throw AuthFailure(
        message: 'Failed to save authentication tokens: $e',
        code: 'TOKEN_SAVE_ERROR',
      );
    }
  }

  /// Clear all authentication data (logout).
  ///
  /// Removes both access token and refresh token from secure storage.
  Future<void> clearTokens() async {
    try {
      await Future.wait([
        _secureStorage.delete(key: AppConstants.storageAuthToken),
        _secureStorage.delete(key: AppConstants.storageRefreshToken),
        _clearTokenExpiration(),
      ]);
    } catch (e, stackTrace) {
      // Log error but don't throw - logout should always succeed
      // even if token deletion fails
      AppLogger.warning(
        'Failed to clear tokens (non-critical): $e',
        e,
        stackTrace,
      );
    }
  }

  /// Clear tokens and verify they are actually cleared.
  ///
  /// This method clears tokens and verifies the operation succeeded.
  /// If tokens still exist after clearing, it will attempt to clear again.
  ///
  /// Returns `true` if tokens were successfully cleared, `false` otherwise.
  Future<bool> clearTokensAndVerify() async {
    // Clear tokens
    await clearTokens();

    // Verify tokens are actually cleared
    final tokenAfterClear = await getAccessToken();
    final isAuthAfterClear = await isAuthenticated();

    AppLogger.info(
      'After clearTokens: token exists='
      '${tokenAfterClear != null && tokenAfterClear.isNotEmpty}, '
      'isAuthenticated=$isAuthAfterClear',
    );

    // If tokens still exist, try clearing again
    if (tokenAfterClear != null && tokenAfterClear.isNotEmpty) {
      AppLogger.warning(
        'Token still exists after clearTokens - attempting to clear again',
      );
      await clearTokens();

      // Verify again
      final tokenAfterSecondClear = await getAccessToken();
      if (tokenAfterSecondClear != null && tokenAfterSecondClear.isNotEmpty) {
        AppLogger.error('Token still exists after second clear!');
        return false;
      }
    }

    return true;
  }

  /// Validate current session by checking token existence and expiration.
  ///
  /// Returns true if token exists and is not expired.
  Future<bool> validateSession() async {
    if (!await isAuthenticated()) {
      return false;
    }

    // Check token expiration
    return !await isTokenExpired();
  }

  /// Get token expiration DateTime from storage.
  ///
  /// Returns null if expiration info is not available or cannot be parsed.
  Future<DateTime?> _getTokenExpirationDateTime() async {
    try {
      final expiresAtStr = await _secureStorage.read(
        key: AppConstants.storageTokenExpiresAt,
      );

      if (expiresAtStr == null || expiresAtStr.isEmpty) {
        return null;
      }

      return DateTime.parse(expiresAtStr);
    } catch (e) {
      AppLogger.warning('Error parsing token expiration: $e');
      return null;
    }
  }

  /// Check if token is expired.
  ///
  /// Returns true if token expiration timestamp exists and is in the past.
  Future<bool> isTokenExpired() async {
    final expiresAt = await _getTokenExpirationDateTime();
    if (expiresAt == null) {
      // No expiration info, assume not expired
      return false;
    }

    return DateTime.now().isAfter(expiresAt);
  }

  /// Get token expiration DateTime.
  ///
  /// Returns null if expiration info is not available.
  Future<DateTime?> getTokenExpiration() async {
    return _getTokenExpirationDateTime();
  }

  /// Check if token will expire soon.
  ///
  /// Returns true if token will expire within the threshold duration.
  Future<bool> willTokenExpireSoon({Duration? threshold}) async {
    final expiration = await getTokenExpiration();
    if (expiration == null) return false;

    final thresholdDuration =
        threshold ?? AuthConstants.tokenExpirationThreshold;
    final now = DateTime.now();
    final thresholdTime = expiration.subtract(thresholdDuration);
    return now.isAfter(thresholdTime);
  }

  /// Clear token expiration timestamp.
  Future<void> _clearTokenExpiration() async {
    try {
      await _secureStorage.delete(key: AppConstants.storageTokenExpiresAt);
    } catch (e) {
      // Non-critical, just log
      AppLogger.warning('Error clearing token expiration: $e');
    }
  }
}
