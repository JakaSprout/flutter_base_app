import 'package:dio/dio.dart';

import 'package:flutter_base_app/core/error/error_mapper.dart';

/// Error interceptor for Dio that maps exceptions to failures.
class ErrorInterceptor extends Interceptor {
  /// Creates a new instance of [ErrorInterceptor].
  ErrorInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Map DioException to Failure
    final failure = ErrorMapper.mapDioException(err);

    // Create new DioException with failure message
    final newError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: failure,
      message: failure.message,
    );

    super.onError(newError, handler);
  }
}
