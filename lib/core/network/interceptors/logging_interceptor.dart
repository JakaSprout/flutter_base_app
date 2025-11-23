import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:dio/dio.dart';

/// Logging interceptor for Dio requests and responses.
class LoggingInterceptor extends Interceptor {
  /// Creates a new instance of [LoggingInterceptor].
  LoggingInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.debug(
      'REQUEST[${options.method}] => PATH: ${options.path}',
    );
    AppLogger.debug('Headers: ${options.headers}');
    if (options.data != null) {
      AppLogger.debug('Body: ${options.data}');
    }
    if (options.queryParameters.isNotEmpty) {
      AppLogger.debug('QueryParams: ${options.queryParameters}');
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    AppLogger.info(
      'RESPONSE[${response.statusCode}] => PATH: '
      '${response.requestOptions.path}',
    );
    AppLogger.debug('Data: ${response.data}');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.error(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
      err,
      err.stackTrace,
    );
    AppLogger.debug('Error Message: ${err.message}');
    if (err.response?.data != null) {
      AppLogger.debug('Error Data: ${err.response?.data}');
    }

    super.onError(err, handler);
  }
}
