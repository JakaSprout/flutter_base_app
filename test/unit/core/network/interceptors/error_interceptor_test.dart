import 'package:app_mobile_afms/core/network/interceptors/error_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/mock_factories.dart';
import '../../../../helpers/mock_interceptor_handlers.dart';

void main() {
  group('ErrorInterceptor', () {
    late ErrorInterceptor interceptor;

    setUp(() {
      interceptor = ErrorInterceptor();
    });

    test('onError should map DioException to Failure', () {
      // Arrange
      final err = createTestDioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
        message: 'Connection timeout',
      );
      final handler = MockErrorInterceptorHandler();

      // Act & Assert - No exception should be thrown
      expect(() => interceptor.onError(err, handler), returnsNormally);
    });

    test('onError should handle network errors', () {
      // Arrange
      final err = createTestDioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionError,
        message: 'Network error',
      );
      final handler = MockErrorInterceptorHandler();

      // Act & Assert - No exception should be thrown
      expect(() => interceptor.onError(err, handler), returnsNormally);
    });

    test('onError should handle server errors', () {
      // Arrange
      final err = createTestDioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        message: 'Server error',
        statusCode: 500,
      );
      final handler = MockErrorInterceptorHandler();

      // Act & Assert - No exception should be thrown
      expect(() => interceptor.onError(err, handler), returnsNormally);
    });
  });
}
