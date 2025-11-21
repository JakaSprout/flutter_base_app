import 'package:dio/dio.dart';
import 'package:app_mobile_afms/core/network/interceptors/retry_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mock_interceptor_handlers.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('RetryInterceptor', () {
    late MockDio mockDio;
    late RetryInterceptor interceptor;

    setUp(() {
      mockDio = MockDio();
      interceptor = RetryInterceptor(dio: mockDio);
    });

    tearDown(() {
      // Reset mocks to ensure test isolation
      reset(mockDio);
    });

    // Note: _shouldRetry is private, so we test it indirectly through onError

    test('onError should retry on connection timeout', () async {
      // Arrange
      final err = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
      );
      final handler = MockErrorInterceptorHandler();

      when(
        () => mockDio.request<dynamic>(
          any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 200,
        ),
      );

      // Act - Interceptor should attempt retry
      await interceptor.onError(err, handler);

      // Verify retry was attempted
      // Wait a bit for async operations (retry delay + request)
      await Future<void>.delayed(const Duration(milliseconds: 300));

      // Verify that retry was attempted (mockDio.request should be called)
      verify(
        () => mockDio.request<dynamic>(
          any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        ),
      ).called(greaterThanOrEqualTo(1));
      verifyNoMoreInteractions(mockDio);
    });

    test('onError should not retry on bad response', () async {
      // Arrange
      final err = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 500,
        ),
      );
      final handler = MockErrorInterceptorHandler();

      // Act
      await interceptor.onError(err, handler);

      // Assert - Should not retry
      await Future<void>.delayed(const Duration(milliseconds: 100));
      verifyNever(
        () => mockDio.request<dynamic>(
          any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        ),
      );
      verifyNoMoreInteractions(mockDio);
    });

    test('onError should respect max retries', () async {
      // Arrange
      final interceptorWithMaxRetries = RetryInterceptor(
        dio: mockDio,
        maxRetries: 2,
      );
      final err = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
      );
      err.requestOptions.extra['retryCount'] = 2; // Already at max
      final handler = MockErrorInterceptorHandler();

      // Act
      await interceptorWithMaxRetries.onError(err, handler);

      // Assert - Should not retry when at max
      await Future<void>.delayed(const Duration(milliseconds: 100));
      verifyNever(
        () => mockDio.request<dynamic>(
          any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        ),
      );
      verifyNoMoreInteractions(mockDio);
    });
  });
}
