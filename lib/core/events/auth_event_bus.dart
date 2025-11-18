import 'dart:async';

/// Authentication event types.
enum AuthEventType {
  /// User was logged out (e.g., due to 401, token expiry, etc.)
  loggedOut,

  /// Token was refreshed
  tokenRefreshed,

  /// Session expired
  sessionExpired,
}

/// Authentication event.
class AuthEvent {
  /// Creates a new instance of [AuthEvent].
  const AuthEvent({required this.type, this.message, this.data});

  /// Event type
  final AuthEventType type;

  /// Optional message
  final String? message;

  /// Optional additional data
  final Map<String, dynamic>? data;
}

/// Event bus for authentication events.
///
/// This allows decoupled communication between components,
/// especially useful for auto-logout on 401 errors.
class AuthEventBus {
  /// Private constructor for singleton.
  AuthEventBus._();

  /// Singleton instance.
  static final AuthEventBus instance = AuthEventBus._();

  /// Stream controller for auth events.
  final _eventController = StreamController<AuthEvent>.broadcast();

  /// Stream of authentication events.
  Stream<AuthEvent> get events => _eventController.stream;

  /// Emit an authentication event.
  void emit(AuthEvent event) {
    if (!_eventController.isClosed) {
      _eventController.add(event);
    }
  }

  /// Emit logged out event.
  void emitLoggedOut({String? message, Map<String, dynamic>? data}) {
    emit(
      AuthEvent(type: AuthEventType.loggedOut, message: message, data: data),
    );
  }

  /// Emit token refreshed event.
  void emitTokenRefreshed({String? message, Map<String, dynamic>? data}) {
    emit(
      AuthEvent(
        type: AuthEventType.tokenRefreshed,
        message: message,
        data: data,
      ),
    );
  }

  /// Emit session expired event.
  void emitSessionExpired({String? message, Map<String, dynamic>? data}) {
    emit(
      AuthEvent(
        type: AuthEventType.sessionExpired,
        message: message,
        data: data,
      ),
    );
  }

  /// Dispose the event bus.
  void dispose() {
    _eventController.close();
  }
}
