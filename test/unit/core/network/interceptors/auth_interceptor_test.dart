import 'package:dio/dio.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/core/network/interceptors/auth_interceptor.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mock_interceptor_handlers.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  group('AuthInterceptor', () {
    late MockFlutterSecureStorage mockSecureStorage;
    late AuthInterceptor interceptor;

    setUp(() {
      mockSecureStorage = MockFlutterSecureStorage();
      interceptor = AuthInterceptor(secureStorage: mockSecureStorage);
    });

    tearDown(() {
      // Reset mocks to ensure test isolation
      reset(mockSecureStorage);
    });

    test(
      'onRequest should add auth token to headers when token exists',
      () async {
        // Arrange
        const token = 'test-token-123';
        when(
          () => mockSecureStorage.read(key: AppConstants.storageAuthToken),
        ).thenAnswer((_) async => token);

        final options = RequestOptions(path: '/test');
        final handler = RequestInterceptorHandler();

        // Act
        await interceptor.onRequest(options, handler);

        // Assert
        expect(options.headers['Authorization'], equals('Bearer $token'));
        verify(
          () => mockSecureStorage.read(key: AppConstants.storageAuthToken),
        ).called(1);
        verifyNoMoreInteractions(mockSecureStorage);
      },
    );

    test('onRequest should not add auth token when token is null', () async {
      // Arrange
      when(
        () => mockSecureStorage.read(key: AppConstants.storageAuthToken),
      ).thenAnswer((_) async => null);

      final options = RequestOptions(path: '/test');
      final handler = RequestInterceptorHandler();

      // Act
      await interceptor.onRequest(options, handler);

      // Assert
      expect(options.headers['Authorization'], isNull);
      verify(
        () => mockSecureStorage.read(key: AppConstants.storageAuthToken),
      ).called(1);
      verifyNoMoreInteractions(mockSecureStorage);
    });

    test('onRequest should not add auth token when token is empty', () async {
      // Arrange
      when(
        () => mockSecureStorage.read(key: AppConstants.storageAuthToken),
      ).thenAnswer((_) async => '');

      final options = RequestOptions(path: '/test');
      final handler = RequestInterceptorHandler();

      // Act
      await interceptor.onRequest(options, handler);

      // Assert
      expect(options.headers['Authorization'], isNull);
      verify(
        () => mockSecureStorage.read(key: AppConstants.storageAuthToken),
      ).called(1);
      verifyNoMoreInteractions(mockSecureStorage);
    });

    test('onError should handle 401 Unauthorized', () {
      // Arrange
      final err = DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 401,
        ),
        type: DioExceptionType.badResponse,
      );
      final handler = MockErrorInterceptorHandler();

      // Act & Assert - No exception should be thrown
      expect(() => interceptor.onError(err, handler), returnsNormally);
    });

    test('onError should not handle non-401 errors', () {
      // Arrange
      final err = DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 500,
        ),
        type: DioExceptionType.badResponse,
      );
      final handler = MockErrorInterceptorHandler();

      // Act & Assert - No exception should be thrown
      expect(() => interceptor.onError(err, handler), returnsNormally);
    });
  });
}
