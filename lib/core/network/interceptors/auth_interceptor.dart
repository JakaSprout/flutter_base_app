import 'package:dio/dio.dart';
import 'package:flutter_base_app/core/config/api_constants.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/core/events/auth_event_bus.dart';
import 'package:flutter_base_app/core/logging/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Authentication interceptor for Dio that adds auth token to requests.
class AuthInterceptor extends Interceptor {
  /// Creates a new instance of [AuthInterceptor].
  AuthInterceptor({required FlutterSecureStorage secureStorage})
    : _secureStorage = secureStorage;

  final FlutterSecureStorage _secureStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Get session ID from secure storage
    // According to API docs, authentication uses x-session-id header
    final sessionId = await _secureStorage.read(
      key: AppConstants.storageAuthToken,
    );

    // Add session ID to headers if available
    if (sessionId != null && sessionId.isNotEmpty) {
      options.headers['x-session-id'] = sessionId;
      AppLogger.debug('Added session ID to request: ${options.path}');
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle 401 Unauthorized - token might be expired
    if (err.response?.statusCode == 401 && _shouldEmitLogout(err)) {
      AppLogger.warning(
        'Unauthorized request (401): ${err.requestOptions.path}',
        err,
        err.stackTrace,
      );
      // Emit logged out event for auto-logout
      AuthEventBus.instance.emitLoggedOut(
        message: 'Session expired or unauthorized',
        data: {'path': err.requestOptions.path, 'statusCode': 401},
      );
    }

    super.onError(err, handler);
  }

  bool _shouldEmitLogout(DioException err) {
    final path = err.requestOptions.path;

    // Skip auto logout for auth endpoints (login, refresh, logout) to avoid
    // unwanted redirects when credentials are invalid or session already gone.
    final authPathsToIgnore = <String>[
      ApiConstants.authLoginEmail,
      ApiConstants.authLoginPhone,
      ApiConstants.authRefreshToken,
      ApiConstants.authLogout,
    ];

    return authPathsToIgnore.every(
      (ignoredPath) => !path.contains(ignoredPath),
    );
  }
}
