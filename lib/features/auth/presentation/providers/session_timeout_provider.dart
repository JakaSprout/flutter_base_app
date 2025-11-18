import 'dart:async';

import 'package:flutter_base_app/core/events/auth_event_bus.dart';
import 'package:flutter_base_app/core/logging/logger.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/auth_constants.dart';
import 'package:flutter_base_app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_timeout_provider.g.dart';

/// Provider for session timeout monitoring.
///
/// This provider monitors session expiration and automatically
/// logs out users when session expires.
@riverpod
class SessionTimeoutMonitor extends _$SessionTimeoutMonitor {
  Timer? _timeoutTimer;
  StreamSubscription<AuthEvent>? _eventSubscription;

  @override
  FutureOr<void> build() {
    // Start monitoring
    _startMonitoring();
    ref.onDispose(_stopMonitoring);
  }

  /// Start monitoring session timeout.
  void _startMonitoring() {
    _checkSessionTimeout();

    // Listen to auth events
    _eventSubscription = AuthEventBus.instance.events.listen((event) {
      if (event.type == AuthEventType.loggedOut) {
        _stopMonitoring();
      } else if (event.type == AuthEventType.tokenRefreshed) {
        // Restart monitoring after token refresh
        _checkSessionTimeout();
      }
    });
  }

  /// Stop monitoring.
  void _stopMonitoring() {
    _timeoutTimer?.cancel();
    _timeoutTimer = null;
    _eventSubscription?.cancel();
    _eventSubscription = null;
  }

  /// Check session timeout.
  Future<void> _checkSessionTimeout() async {
    try {
      final authService = ref.read(authServiceProvider);
      final isAuthenticated = await authService.isAuthenticated();

      if (!isAuthenticated) {
        _stopMonitoring();
        return;
      }

      // Check if token is expired
      final isExpired = await authService.isTokenExpired();

      if (isExpired) {
        AppLogger.warning('Session expired, logging out');
        AuthEventBus.instance.emitSessionExpired(
          message: 'Session has expired',
        );
        _stopMonitoring();
      } else {
        // Get expiration time and schedule check
        final expiration = await authService.getTokenExpiration();
        if (expiration != null) {
          _scheduleTimeoutCheck(expiration);
        } else {
          // No expiration info, check every 5 minutes
          _scheduleTimeoutCheck(
            DateTime.now().add(AuthConstants.defaultSessionCheckInterval),
          );
        }
      }
    } catch (e, stackTrace) {
      AppLogger.warning('Error checking session timeout: $e', e, stackTrace);
      // Schedule retry
      _scheduleTimeoutCheck(
        DateTime.now().add(AuthConstants.sessionTimeoutRetryDelay),
      );
    }
  }

  /// Schedule timeout check.
  void _scheduleTimeoutCheck(DateTime expiration) {
    _timeoutTimer?.cancel();

    final now = DateTime.now();
    if (expiration.isBefore(now)) {
      // Already expired, check immediately
      _checkSessionTimeout();
      return;
    }

    final duration = expiration.difference(now);
    _timeoutTimer = Timer(duration, _checkSessionTimeout);
  }
}
