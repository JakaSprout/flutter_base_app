import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Failure', () {
    group('base class', () {
      test('should create failure with message and code', () {
        // Arrange & Act
        const failure = NetworkFailure(
          message: 'Test error',
          code: 'TEST_ERROR',
        );

        // Assert
        expect(failure.message, equals('Test error'));
        expect(failure.code, equals('TEST_ERROR'));
      });

      test('should create failure with message only', () {
        // Arrange & Act
        const failure = NetworkFailure(message: 'Test error');

        // Assert
        expect(failure.message, equals('Test error'));
        expect(failure.code, isNull);
      });

      test('should have correct equality', () {
        // Arrange
        const failure1 = NetworkFailure(
          message: 'Test error',
          code: 'TEST_ERROR',
        );
        const failure2 = NetworkFailure(
          message: 'Test error',
          code: 'TEST_ERROR',
        );
        const failure3 = NetworkFailure(
          message: 'Different error',
          code: 'TEST_ERROR',
        );

        // Assert
        expect(failure1, equals(failure2));
        expect(failure1, isNot(equals(failure3)));
      });

      test('should have correct hashCode', () {
        // Arrange
        const failure1 = NetworkFailure(
          message: 'Test error',
          code: 'TEST_ERROR',
        );
        const failure2 = NetworkFailure(
          message: 'Test error',
          code: 'TEST_ERROR',
        );

        // Assert
        expect(failure1.hashCode, equals(failure2.hashCode));
      });

      test('should have correct toString', () {
        // Arrange
        const failure = NetworkFailure(
          message: 'Test error',
          code: 'TEST_ERROR',
        );

        // Act
        final string = failure.toString();

        // Assert
        expect(string, contains('Test error'));
        expect(string, contains('TEST_ERROR'));
      });
    });
  });

  group('NetworkFailure', () {
    test('should create network failure with custom message', () {
      // Arrange & Act
      const failure = NetworkFailure(
        message: 'Network error',
        code: 'NETWORK_ERROR',
      );

      // Assert
      expect(failure, isA<NetworkFailure>());
      expect(failure.message, equals('Network error'));
      expect(failure.code, equals('NETWORK_ERROR'));
    });

    test('should create timeout failure', () {
      // Arrange & Act
      const failure = NetworkFailure.timeout();

      // Assert
      expect(failure, isA<NetworkFailure>());
      expect(failure.message, contains('timeout'));
      expect(failure.code, equals('TIMEOUT'));
    });

    test('should create no connection failure', () {
      // Arrange & Act
      const failure = NetworkFailure.noConnection();

      // Assert
      expect(failure, isA<NetworkFailure>());
      expect(failure.message, contains('internet connection'));
      expect(failure.code, equals('NO_CONNECTION'));
    });

    test('should create server error failure without message', () {
      // Arrange & Act
      const failure = NetworkFailure.serverError();

      // Assert
      expect(failure, isA<NetworkFailure>());
      expect(failure.message, contains('Server error'));
      expect(failure.code, equals('SERVER_ERROR'));
    });

    test('should create server error failure with custom message', () {
      // Arrange & Act
      const failure = NetworkFailure.serverError('Custom server error');

      // Assert
      expect(failure, isA<NetworkFailure>());
      expect(failure.message, equals('Custom server error'));
      expect(failure.code, equals('SERVER_ERROR'));
    });
  });

  group('CacheFailure', () {
    test('should create cache failure with custom message', () {
      // Arrange & Act
      const failure = CacheFailure(
        message: 'Cache error',
        code: 'CACHE_ERROR',
      );

      // Assert
      expect(failure, isA<CacheFailure>());
      expect(failure.message, equals('Cache error'));
      expect(failure.code, equals('CACHE_ERROR'));
    });

    test('should create cache not found failure', () {
      // Arrange & Act
      const failure = CacheFailure.notFound();

      // Assert
      expect(failure, isA<CacheFailure>());
      expect(failure.message, contains('Cache not found'));
      expect(failure.code, equals('CACHE_NOT_FOUND'));
    });

    test('should create cache write error without message', () {
      // Arrange & Act
      const failure = CacheFailure.writeError();

      // Assert
      expect(failure, isA<CacheFailure>());
      expect(failure.message, contains('Failed to write to cache'));
      expect(failure.code, equals('CACHE_WRITE_ERROR'));
    });

    test('should create cache write error with custom message', () {
      // Arrange & Act
      const failure = CacheFailure.writeError('Custom write error');

      // Assert
      expect(failure, isA<CacheFailure>());
      expect(failure.message, equals('Custom write error'));
      expect(failure.code, equals('CACHE_WRITE_ERROR'));
    });
  });

  group('ValidationFailure', () {
    test('should create validation failure with message and code', () {
      // Arrange & Act
      const failure = ValidationFailure(
        message: 'Validation error',
        code: 'VALIDATION_ERROR',
      );

      // Assert
      expect(failure, isA<ValidationFailure>());
      expect(failure.message, equals('Validation error'));
      expect(failure.code, equals('VALIDATION_ERROR'));
    });

    test('should create validation failure with message only', () {
      // Arrange & Act
      const failure = ValidationFailure(message: 'Validation error');

      // Assert
      expect(failure.message, equals('Validation error'));
      expect(failure.code, isNull);
    });
  });

  group('AuthFailure', () {
    test('should create auth failure with custom message', () {
      // Arrange & Act
      const failure = AuthFailure(
        message: 'Auth error',
        code: 'AUTH_ERROR',
      );

      // Assert
      expect(failure, isA<AuthFailure>());
      expect(failure.message, equals('Auth error'));
      expect(failure.code, equals('AUTH_ERROR'));
    });

    test('should create unauthorized failure', () {
      // Arrange & Act
      const failure = AuthFailure.unauthorized();

      // Assert
      expect(failure, isA<AuthFailure>());
      expect(failure.message, contains('Unauthorized'));
      expect(failure.code, equals('UNAUTHORIZED'));
    });

    test('should create token expired failure', () {
      // Arrange & Act
      const failure = AuthFailure.tokenExpired();

      // Assert
      expect(failure, isA<AuthFailure>());
      expect(failure.message, contains('Session expired'));
      expect(failure.code, equals('TOKEN_EXPIRED'));
    });
  });

  group('UnknownFailure', () {
    test('should create unknown failure with custom message', () {
      // Arrange & Act
      const failure = UnknownFailure(
        message: 'Unknown error',
        code: 'UNKNOWN_ERROR',
      );

      // Assert
      expect(failure, isA<UnknownFailure>());
      expect(failure.message, equals('Unknown error'));
      expect(failure.code, equals('UNKNOWN_ERROR'));
    });

    test('should create unknown error failure without message', () {
      // Arrange & Act
      const failure = UnknownFailure.unknown();

      // Assert
      expect(failure, isA<UnknownFailure>());
      expect(failure.message, contains('unknown error occurred'));
      expect(failure.code, equals('UNKNOWN'));
    });

    test('should create unknown error failure with custom message', () {
      // Arrange & Act
      const failure = UnknownFailure.unknown('Custom unknown error');

      // Assert
      expect(failure, isA<UnknownFailure>());
      expect(failure.message, equals('Custom unknown error'));
      expect(failure.code, equals('UNKNOWN'));
    });
  });
}

