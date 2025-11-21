import 'dart:async';

import 'package:app_mobile_afms/core/events/auth_event_bus.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:app_mobile_afms/features/auth/domain/services/auth_service.dart';
import 'package:app_mobile_afms/features/auth/presentation/constants/auth_constants.dart';
import 'package:app_mobile_afms/features/auth/presentation/providers/auth_provider.dart';
import 'package:app_mobile_afms/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token_refresh_provider.g.dart';

/// Provider for automatic token refresh.
///
/// This provider monitors token expiration and automatically refreshes
/// tokens before they expire.
@riverpod
class TokenRefreshMonitor extends _$TokenRefreshMonitor {
  Timer? _refreshTimer;
  StreamSubscription<AuthEvent>? _eventSubscription;

  @override
  FutureOr<void> build() {
    // Start monitoring
    _startMonitoring();
    ref.onDispose(_stopMonitoring);
  }

  /// Start monitoring token expiration.
  void _startMonitoring() {
    // Check token expiration periodically
    _checkAndRefreshToken();

    // Listen to auth events
    _eventSubscription = AuthEventBus.instance.events.listen((event) {
      if (event.type == AuthEventType.loggedOut ||
          event.type == AuthEventType.sessionExpired) {
        _stopMonitoring();
      } else if (event.type == AuthEventType.tokenRefreshed) {
        // Restart monitoring after token refresh
        _checkAndRefreshToken();
      }
    });
  }

  /// Stop monitoring.
  void _stopMonitoring() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
    _eventSubscription?.cancel();
    _eventSubscription = null;
  }

  /// Check token expiration and refresh if needed.
  Future<void> _checkAndRefreshToken() async {
    try {
      final authService = ref.read(authServiceProvider);
      final isAuthenticated = await authService.isAuthenticated();

      if (!isAuthenticated) {
        _stopMonitoring();
        return;
      }

      // Check if token will expire soon
      final willExpireSoon = await authService.willTokenExpireSoon(
        threshold: AuthConstants.tokenExpirationThreshold,
      );

      if (willExpireSoon) {
        await _refreshToken();
      } else {
        // Schedule next check
        _scheduleNextCheck(authService);
      }
    } catch (e, stackTrace) {
      AppLogger.warning('Error checking token expiration: $e', e, stackTrace);
      // Schedule retry
      _scheduleNextCheck(null);
    }
  }

  /// Schedule next token expiration check.
  void _scheduleNextCheck(AuthService? authService) {
    _refreshTimer?.cancel();

    // Check every minute
    _refreshTimer = Timer(const Duration(minutes: 1), _checkAndRefreshToken);
  }

  /// Refresh the access token.
  Future<void> _refreshToken() async {
    try {
      final authService = ref.read(authServiceProvider);
      final refreshTokenValue = await authService.getRefreshToken();

      if (refreshTokenValue == null || refreshTokenValue.isEmpty) {
        AppLogger.warning('No refresh token available');
        AuthEventBus.instance.emitLoggedOut(
          message: 'Refresh token not available',
        );
        return;
      }

      // Refresh token
      final loginResponse = await ref.read(
        tokenRefreshProvider(refreshTokenValue).future,
      );

      // Save new tokens
      await authService.saveTokens(loginResponse);

      // Invalidate auth state
      ref.invalidate(authStateProvider);

      // Emit token refreshed event
      AuthEventBus.instance.emitTokenRefreshed(
        message: 'Token refreshed successfully',
      );

      AppLogger.info('Token refreshed successfully');

      // Schedule next check
      _scheduleNextCheck(authService);
    } catch (e, stackTrace) {
      AppLogger.error('Token refresh failed: $e', e, stackTrace);
      // If refresh fails, emit logged out event
      AuthEventBus.instance.emitLoggedOut(
        message: 'Token refresh failed: $e',
        data: {'error': e.toString()},
      );
    }
  }
}
