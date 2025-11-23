import 'dart:async';

import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:dio/dio.dart';

/// Retry interceptor for Dio that retries failed requests.
class RetryInterceptor extends Interceptor {
  /// Creates a new instance of [RetryInterceptor].
  RetryInterceptor({
    required Dio dio,
    this.maxRetries = AppConstants.apiRetryAttempts,
    this.retryDelay = const Duration(
      milliseconds: AppConstants.apiRetryDelayMs,
    ),
  }) : _dio = dio;

  final Dio _dio;

  /// Maximum number of retry attempts
  final int maxRetries;

  /// Delay between retries
  final Duration retryDelay;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Only retry on network errors or timeout
    if (_shouldRetry(err) && err.requestOptions.extra['retryCount'] == null) {
      err.requestOptions.extra['retryCount'] = 0;
    }

    final retryCount = err.requestOptions.extra['retryCount'] as int? ?? 0;

    if (retryCount < maxRetries && _shouldRetry(err)) {
      err.requestOptions.extra['retryCount'] = retryCount + 1;

      AppLogger.warning(
        'Retrying request (${retryCount + 1}/$maxRetries): '
        '${err.requestOptions.path}',
      );

      // Wait before retrying
      await Future<void>.delayed(retryDelay);

      try {
        // Retry the request using Dio instance
        final response = await _dio.request<dynamic>(
          err.requestOptions.path,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
          options: Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
          ),
        );
        handler.resolve(response);
        return;
      } catch (e) {
        // If retry fails, continue with error
        if (e is DioException) {
          super.onError(e, handler);
          return;
        }
      }
    }

    super.onError(err, handler);
  }

  /// Check if request should be retried.
  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError;
  }
}
