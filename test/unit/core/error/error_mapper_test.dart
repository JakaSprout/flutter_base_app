import 'package:dio/dio.dart';
import 'package:flutter_base_app/core/error/error_mapper.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/mock_factories.dart';

void main() {
  group('ErrorMapper', () {
    group('mapException', () {
      test('should map DioException to failure', () {
        // Arrange
        final dioException = createTestDioException(
          type: DioExceptionType.connectionTimeout,
        );

        // Act
        final result = ErrorMapper.mapException(dioException);

        // Assert
        expect(result, isA<NetworkFailure>());
        expect(result, isA<NetworkFailure>());
      });

      test('should map FormatException to ValidationFailure', () {
        // Arrange
        const formatException = FormatException('Invalid format');

        // Act
        final result = ErrorMapper.mapException(formatException);

        // Assert
        expect(result, isA<ValidationFailure>());
        final failure = result as ValidationFailure;
        expect(failure.message, contains('Invalid data format'));
        expect(failure.code, equals('FORMAT_ERROR'));
      });

      test('should map TypeError to ValidationFailure', () {
        // Arrange
        final typeError = TypeError();

        // Act
        final result = ErrorMapper.mapException(typeError);

        // Assert
        expect(result, isA<ValidationFailure>());
        final failure = result as ValidationFailure;
        expect(failure.message, contains('Type error'));
        expect(failure.code, equals('TYPE_ERROR'));
      });

      test('should map unknown exception to UnknownFailure', () {
        // Arrange
        final unknownException = Exception('Unknown error');

        // Act
        final result = ErrorMapper.mapException(unknownException);

        // Assert
        expect(result, isA<UnknownFailure>());
      });
    });

    group('mapDioException', () {
      group('timeout exceptions', () {
        test('should map connectionTimeout to NetworkFailure.timeout', () {
          // Arrange
          final exception = createTestDioException(
            type: DioExceptionType.connectionTimeout,
          );

          // Act
          final result = ErrorMapper.mapDioException(exception);

          // Assert
          expect(result, isA<NetworkFailure>());
          final failure = result as NetworkFailure;
          expect(failure.code, equals('TIMEOUT'));
        });

        test('should map sendTimeout to NetworkFailure.timeout', () {
          // Arrange
          final exception = createTestDioException(
            type: DioExceptionType.sendTimeout,
          );

          // Act
          final result = ErrorMapper.mapDioException(exception);

          // Assert
          expect(result, isA<NetworkFailure>());
          final failure = result as NetworkFailure;
          expect(failure.code, equals('TIMEOUT'));
        });

        test('should map receiveTimeout to NetworkFailure.timeout', () {
          // Arrange
          final exception = createTestDioException(
            type: DioExceptionType.receiveTimeout,
          );

          // Act
          final result = ErrorMapper.mapDioException(exception);

          // Assert
          expect(result, isA<NetworkFailure>());
          final failure = result as NetworkFailure;
          expect(failure.code, equals('TIMEOUT'));
        });
      });

      group('badResponse exceptions', () {
        test('should map 401 status code to AuthFailure.unauthorized', () {
          // Arrange
          final response = createTestDioResponse(statusCode: 401);
          final exception = createTestDioException(
            type: DioExceptionType.badResponse,
            response: response,
          );

          // Act
          final result = ErrorMapper.mapDioException(exception);

          // Assert
          expect(result, isA<AuthFailure>());
          final failure = result as AuthFailure;
          expect(failure.code, equals('UNAUTHORIZED'));
        });

        test('should map 403 status code to AuthFailure.forbidden', () {
          // Arrange
          final response = createTestDioResponse(statusCode: 403);
          final exception = createTestDioException(
            type: DioExceptionType.badResponse,
            response: response,
          );

          // Act
          final result = ErrorMapper.mapDioException(exception);

          // Assert
          expect(result, isA<AuthFailure>());
          final failure = result as AuthFailure;
          expect(failure.code, equals('FORBIDDEN'));
        });

        test('should map 404 status code to NetworkFailure.notFound', () {
          // Arrange
          final response = createTestDioResponse(statusCode: 404);
          final exception = createTestDioException(
            type: DioExceptionType.badResponse,
            response: response,
          );

          // Act
          final result = ErrorMapper.mapDioException(exception);

          // Assert
          expect(result, isA<NetworkFailure>());
          final failure = result as NetworkFailure;
          expect(failure.code, equals('NOT_FOUND'));
        });

        test('should map 500+ status code to NetworkFailure.serverError', () {
          // Arrange
          final response = createTestDioResponse(statusCode: 500);
          final exception = createTestDioException(
            type: DioExceptionType.badResponse,
            response: response,
          );

          // Act
          final result = ErrorMapper.mapDioException(exception);

          // Assert
          expect(result, isA<NetworkFailure>());
          final failure = result as NetworkFailure;
          expect(failure.code, equals('SERVER_ERROR'));
        });

        test('should map other 4xx status codes to NetworkFailure', () {
          // Arrange
          final response = createTestDioResponse(
            statusCode: 400,
            data: {'error': 'Bad Request'},
          );
          final exception = createTestDioException(
            type: DioExceptionType.badResponse,
            response: response,
          );

          // Act
          final result = ErrorMapper.mapDioException(exception);

          // Assert
          expect(result, isA<NetworkFailure>());
          final failure = result as NetworkFailure;
          expect(failure.code, equals('400'));
        });

        test('should use response status message when available', () {
          // Arrange
          final response = createTestDioResponse(
            statusCode: 400,
            data: {'error': 'Bad Request'},
          );
          final requestOptions = MockRequestOptions();
          final exception = DioException(
            type: DioExceptionType.badResponse,
            response: response,
            requestOptions: requestOptions,
          );

          // Act
          final result = ErrorMapper.mapDioException(exception);

          // Assert
          expect(result, isA<NetworkFailure>());
        });
      });

      test('should map cancel to NetworkFailure.cancelled', () {
        // Arrange
        final exception = createTestDioException(type: DioExceptionType.cancel);

        // Act
        final result = ErrorMapper.mapDioException(exception);

        // Assert
        expect(result, isA<NetworkFailure>());
        final failure = result as NetworkFailure;
        expect(failure.code, equals('CANCELLED'));
      });

      test('should map connectionError to NetworkFailure.noConnection', () {
        // Arrange
        final exception = createTestDioException(
          type: DioExceptionType.connectionError,
        );

        // Act
        final result = ErrorMapper.mapDioException(exception);

        // Assert
        expect(result, isA<NetworkFailure>());
        final failure = result as NetworkFailure;
        expect(failure.code, equals('NO_CONNECTION'));
      });

      test('should map badCertificate to NetworkFailure', () {
        // Arrange
        final exception = createTestDioException(
          type: DioExceptionType.badCertificate,
        );

        // Act
        final result = ErrorMapper.mapDioException(exception);

        // Assert
        expect(result, isA<NetworkFailure>());
        final failure = result as NetworkFailure;
        expect(failure.code, equals('BAD_CERTIFICATE'));
      });

      test('should map unknown to NetworkFailure with message', () {
        // Arrange
        final exception = createTestDioException(
          type: DioExceptionType.unknown,
          message: 'Unknown network error',
        );

        // Act
        final result = ErrorMapper.mapDioException(exception);

        // Assert
        expect(result, isA<NetworkFailure>());
        final failure = result as NetworkFailure;
        expect(failure.code, equals('UNKNOWN_NETWORK_ERROR'));
        expect(failure.message, contains('Unknown network error'));
      });

      test('should handle unknown exception without message', () {
        // Arrange
        final requestOptions = MockRequestOptions();
        final exception = DioException(requestOptions: requestOptions);

        // Act
        final result = ErrorMapper.mapDioException(exception);

        // Assert
        expect(result, isA<NetworkFailure>());
        final failure = result as NetworkFailure;
        expect(failure.message, contains('Network error occurred'));
      });
    });
  });
}
