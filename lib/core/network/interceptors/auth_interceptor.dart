import 'package:dio/dio.dart';
import 'package:flutter_base_app/core/config/constants.dart';
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
    // Get auth token from secure storage
    final token = await _secureStorage.read(key: AppConstants.storageAuthToken);

    // Add token to headers if available
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      AppLogger.debug('Added auth token to request: ${options.path}');
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle 401 Unauthorized - token might be expired
    if (err.response?.statusCode == 401) {
      AppLogger.warning('Unauthorized request: ${err.requestOptions.path}');
      // TODO(team): Implement token refresh logic here
      // await _refreshToken();
    }

    super.onError(err, handler);
  }
}
