import 'package:dio/dio.dart';
import 'package:app_mobile_afms/core/network/interceptors/logging_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/mock_interceptor_handlers.dart';

void main() {
  group('LoggingInterceptor', () {
    late LoggingInterceptor interceptor;

    setUp(() {
      interceptor = LoggingInterceptor();
    });

    test('onRequest should log request information', () {
      // Arrange
      final options = RequestOptions(
        path: '/test',
        method: 'GET',
        headers: {'Content-Type': 'application/json'},
        data: {'key': 'value'},
        queryParameters: {'param': 'value'},
      );
      final handler = RequestInterceptorHandler();

      // Act & Assert - No exception should be thrown
      expect(() => interceptor.onRequest(options, handler), returnsNormally);
    });

    test('onRequest should handle request without data', () {
      // Arrange
      final options = RequestOptions(path: '/test', method: 'GET');
      final handler = RequestInterceptorHandler();

      // Act & Assert - No exception should be thrown
      expect(() => interceptor.onRequest(options, handler), returnsNormally);
    });

    test('onResponse should log response information', () {
      // Arrange
      final response = Response<dynamic>(
        requestOptions: RequestOptions(path: '/test'),
        statusCode: 200,
        data: {'result': 'success'},
      );
      final handler = ResponseInterceptorHandler();

      // Act & Assert - No exception should be thrown
      expect(() => interceptor.onResponse(response, handler), returnsNormally);
    });

    test('onError should log error information', () {
      // Arrange
      final err = DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 500,
          data: {'error': 'Server error'},
        ),
        type: DioExceptionType.badResponse,
        message: 'Server error',
      );
      final handler = MockErrorInterceptorHandler();

      // Act & Assert - No exception should be thrown
      expect(() => interceptor.onError(err, handler), returnsNormally);
    });

    test('onError should handle error without response data', () {
      // Arrange
      final err = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
        message: 'Connection timeout',
      );
      final handler = MockErrorInterceptorHandler();

      // Act & Assert - No exception should be thrown
      expect(() => interceptor.onError(err, handler), returnsNormally);
    });
  });
}
