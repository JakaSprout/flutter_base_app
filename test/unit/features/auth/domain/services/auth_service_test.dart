import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/auth/domain/entities/login_response.dart';
import 'package:flutter_base_app/features/auth/domain/services/auth_service.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/auth_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  group('AuthService', () {
    late AuthService authService;
    late MockFlutterSecureStorage mockSecureStorage;

    setUp(() {
      mockSecureStorage = MockFlutterSecureStorage();
      authService = AuthService(secureStorage: mockSecureStorage);
    });

    group('isAuthenticated', () {
      test('should return true when access token exists', () async {
        // Arrange
        when(
          () => mockSecureStorage.read(key: AppConstants.storageAuthToken),
        ).thenAnswer((_) async => 'valid_token');

        // Act
        final result = await authService.isAuthenticated();

        // Assert
        expect(result, isTrue);
        verify(
          () => mockSecureStorage.read(key: AppConstants.storageAuthToken),
        ).called(1);
      });

      test('should return false when access token is null', () async {
        // Arrange
        when(
          () => mockSecureStorage.read(key: AppConstants.storageAuthToken),
        ).thenAnswer((_) async => null);

        // Act
        final result = await authService.isAuthenticated();

        // Assert
        expect(result, isFalse);
      });

      test('should return false when access token is empty', () async {
        // Arrange
        when(
          () => mockSecureStorage.read(key: AppConstants.storageAuthToken),
        ).thenAnswer((_) async => '');

        // Act
        final result = await authService.isAuthenticated();

        // Assert
        expect(result, isFalse);
      });

      test('should return false when read throws exception', () async {
        // Arrange
        when(
          () => mockSecureStorage.read(key: AppConstants.storageAuthToken),
        ).thenThrow(Exception('Storage error'));

        // Act
        final result = await authService.isAuthenticated();

        // Assert
        expect(result, isFalse);
      });
    });

    group('getAccessToken', () {
      test('should return access token when it exists', () async {
        // Arrange
        const token = 'access_token_123';
        when(
          () => mockSecureStorage.read(key: AppConstants.storageAuthToken),
        ).thenAnswer((_) async => token);

        // Act
        final result = await authService.getAccessToken();

        // Assert
        expect(result, equals(token));
        verify(
          () => mockSecureStorage.read(key: AppConstants.storageAuthToken),
        ).called(1);
      });

      test('should return null when token does not exist', () async {
        // Arrange
        when(
          () => mockSecureStorage.read(key: AppConstants.storageAuthToken),
        ).thenAnswer((_) async => null);

        // Act
        final result = await authService.getAccessToken();

        // Assert
        expect(result, isNull);
      });

      test('should return null when read throws exception', () async {
        // Arrange
        when(
          () => mockSecureStorage.read(key: AppConstants.storageAuthToken),
        ).thenThrow(Exception('Storage error'));

        // Act
        final result = await authService.getAccessToken();

        // Assert
        expect(result, isNull);
      });
    });

    group('getRefreshToken', () {
      test('should return refresh token when it exists', () async {
        // Arrange
        const token = 'refresh_token_123';
        when(
          () => mockSecureStorage.read(key: AppConstants.storageRefreshToken),
        ).thenAnswer((_) async => token);

        // Act
        final result = await authService.getRefreshToken();

        // Assert
        expect(result, equals(token));
        verify(
          () => mockSecureStorage.read(key: AppConstants.storageRefreshToken),
        ).called(1);
      });

      test('should return null when token does not exist', () async {
        // Arrange
        when(
          () => mockSecureStorage.read(key: AppConstants.storageRefreshToken),
        ).thenAnswer((_) async => null);

        // Act
        final result = await authService.getRefreshToken();

        // Assert
        expect(result, isNull);
      });
    });

    group('saveTokens', () {
      test('should save access token and refresh token', () async {
        // Arrange
        const loginResponse = LoginResponse(
          accessToken: 'access_token',
          refreshToken: 'refresh_token',
          userId: 'user_123',
        );

        when(
          () => mockSecureStorage.write(
            key: AppConstants.storageAuthToken,
            value: 'access_token',
          ),
        ).thenAnswer((_) async => {});

        when(
          () => mockSecureStorage.write(
            key: AppConstants.storageRefreshToken,
            value: 'refresh_token',
          ),
        ).thenAnswer((_) async => {});

        // Act
        await authService.saveTokens(loginResponse);

        // Assert
        verify(
          () => mockSecureStorage.write(
            key: AppConstants.storageAuthToken,
            value: 'access_token',
          ),
        ).called(1);
        verify(
          () => mockSecureStorage.write(
            key: AppConstants.storageRefreshToken,
            value: 'refresh_token',
          ),
        ).called(1);
      });

      test('should save token expiration when expiresIn is provided', () async {
        // Arrange
        const loginResponse = LoginResponse(
          accessToken: 'access_token',
          refreshToken: 'refresh_token',
          userId: 'user_123',
          expiresIn: 3600, // 1 hour
        );

        when(
          () => mockSecureStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async => {});

        // Act
        await authService.saveTokens(loginResponse);

        // Assert
        verify(
          () => mockSecureStorage.write(
            key: AppConstants.storageAuthToken,
            value: 'access_token',
          ),
        ).called(1);
        verify(
          () => mockSecureStorage.write(
            key: AppConstants.storageRefreshToken,
            value: 'refresh_token',
          ),
        ).called(1);
        verify(
          () => mockSecureStorage.write(
            key: AppConstants.storageTokenExpiresAt,
            value: any(named: 'value'),
          ),
        ).called(1);
      });

      test('should throw AuthFailure when save fails', () async {
        // Arrange
        const loginResponse = LoginResponse(
          accessToken: 'access_token',
          refreshToken: 'refresh_token',
          userId: 'user_123',
        );

        when(
          () => mockSecureStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        ).thenThrow(Exception('Storage write error'));

        // Act & Assert
        expect(
          () => authService.saveTokens(loginResponse),
          throwsA(isA<AuthFailure>()),
        );
      });
    });

    group('clearTokens', () {
      test('should delete all tokens', () async {
        // Arrange
        when(
          () => mockSecureStorage.delete(key: any(named: 'key')),
        ).thenAnswer((_) async => {});

        // Act
        await authService.clearTokens();

        // Assert
        verify(
          () => mockSecureStorage.delete(key: AppConstants.storageAuthToken),
        ).called(1);
        verify(
          () => mockSecureStorage.delete(key: AppConstants.storageRefreshToken),
        ).called(1);
        verify(
          () =>
              mockSecureStorage.delete(key: AppConstants.storageTokenExpiresAt),
        ).called(1);
      });

      test('should not throw when delete fails', () async {
        // Arrange
        when(
          () => mockSecureStorage.delete(key: any(named: 'key')),
        ).thenThrow(Exception('Delete error'));

        // Act & Assert
        await authService.clearTokens(); // Should not throw
      });
    });

    group('clearTokensAndVerify', () {
      test('should return true when tokens are successfully cleared', () async {
        // Arrange
        when(
          () => mockSecureStorage.delete(key: any(named: 'key')),
        ).thenAnswer((_) async => {});

        when(
          () => mockSecureStorage.read(key: AppConstants.storageAuthToken),
        ).thenAnswer((_) async => null);

        // Act
        final result = await authService.clearTokensAndVerify();

        // Assert
        expect(result, isTrue);
      });

      test(
        'should return false when tokens still exist after second clear',
        () async {
          // Arrange
          when(
            () => mockSecureStorage.delete(key: any(named: 'key')),
          ).thenAnswer((_) async => {});

          // First read returns token (still exists)
          when(
            () => mockSecureStorage.read(key: AppConstants.storageAuthToken),
          ).thenAnswer((_) async => 'token_still_exists');

          // Act
          final result = await authService.clearTokensAndVerify();

          // Assert
          expect(result, isFalse);
        },
      );
    });

    group('validateSession', () {
      test('should return true when token exists and not expired', () async {
        // Arrange
        when(
          () => mockSecureStorage.read(key: AppConstants.storageAuthToken),
        ).thenAnswer((_) async => 'valid_token');

        final futureExpiration = DateTime.now().add(const Duration(hours: 1));
        when(
          () => mockSecureStorage.read(key: AppConstants.storageTokenExpiresAt),
        ).thenAnswer((_) async => futureExpiration.toIso8601String());

        // Act
        final result = await authService.validateSession();

        // Assert
        expect(result, isTrue);
      });

      test('should return false when token does not exist', () async {
        // Arrange
        when(
          () => mockSecureStorage.read(key: AppConstants.storageAuthToken),
        ).thenAnswer((_) async => null);

        // Act
        final result = await authService.validateSession();

        // Assert
        expect(result, isFalse);
      });

      test('should return false when token is expired', () async {
        // Arrange
        when(
          () => mockSecureStorage.read(key: AppConstants.storageAuthToken),
        ).thenAnswer((_) async => 'expired_token');

        final pastExpiration = DateTime.now().subtract(
          const Duration(hours: 1),
        );
        when(
          () => mockSecureStorage.read(key: AppConstants.storageTokenExpiresAt),
        ).thenAnswer((_) async => pastExpiration.toIso8601String());

        // Act
        final result = await authService.validateSession();

        // Assert
        expect(result, isFalse);
      });
    });

    group('isTokenExpired', () {
      test(
        'should return false when token expiration is in the future',
        () async {
          // Arrange
          final futureExpiration = DateTime.now().add(const Duration(hours: 1));
          when(
            () =>
                mockSecureStorage.read(key: AppConstants.storageTokenExpiresAt),
          ).thenAnswer((_) async => futureExpiration.toIso8601String());

          // Act
          final result = await authService.isTokenExpired();

          // Assert
          expect(result, isFalse);
        },
      );

      test('should return true when token expiration is in the past', () async {
        // Arrange
        final pastExpiration = DateTime.now().subtract(
          const Duration(hours: 1),
        );
        when(
          () => mockSecureStorage.read(key: AppConstants.storageTokenExpiresAt),
        ).thenAnswer((_) async => pastExpiration.toIso8601String());

        // Act
        final result = await authService.isTokenExpired();

        // Assert
        expect(result, isTrue);
      });

      test(
        'should return false when expiration info is not available',
        () async {
          // Arrange
          when(
            () =>
                mockSecureStorage.read(key: AppConstants.storageTokenExpiresAt),
          ).thenAnswer((_) async => null);

          // Act
          final result = await authService.isTokenExpired();

          // Assert
          expect(result, isFalse);
        },
      );
    });

    group('getTokenExpiration', () {
      test('should return expiration DateTime when available', () async {
        // Arrange
        final expiration = DateTime.now().add(const Duration(hours: 1));
        when(
          () => mockSecureStorage.read(key: AppConstants.storageTokenExpiresAt),
        ).thenAnswer((_) async => expiration.toIso8601String());

        // Act
        final result = await authService.getTokenExpiration();

        // Assert
        expect(result, isNotNull);
        expect(result?.toIso8601String(), equals(expiration.toIso8601String()));
      });

      test(
        'should return null when expiration info is not available',
        () async {
          // Arrange
          when(
            () =>
                mockSecureStorage.read(key: AppConstants.storageTokenExpiresAt),
          ).thenAnswer((_) async => null);

          // Act
          final result = await authService.getTokenExpiration();

          // Assert
          expect(result, isNull);
        },
      );
    });

    group('willTokenExpireSoon', () {
      test(
        'should return true when token will expire within threshold',
        () async {
          // Arrange
          final expiration = DateTime.now().add(
            AuthConstants.tokenExpirationThreshold - const Duration(minutes: 1),
          );
          when(
            () =>
                mockSecureStorage.read(key: AppConstants.storageTokenExpiresAt),
          ).thenAnswer((_) async => expiration.toIso8601String());

          // Act
          final result = await authService.willTokenExpireSoon();

          // Assert
          expect(result, isTrue);
        },
      );

      test('should return false when token will not expire soon', () async {
        // Arrange
        final expiration = DateTime.now().add(
          AuthConstants.tokenExpirationThreshold + const Duration(hours: 1),
        );
        when(
          () => mockSecureStorage.read(key: AppConstants.storageTokenExpiresAt),
        ).thenAnswer((_) async => expiration.toIso8601String());

        // Act
        final result = await authService.willTokenExpireSoon();

        // Assert
        expect(result, isFalse);
      });

      test(
        'should return false when expiration info is not available',
        () async {
          // Arrange
          when(
            () =>
                mockSecureStorage.read(key: AppConstants.storageTokenExpiresAt),
          ).thenAnswer((_) async => null);

          // Act
          final result = await authService.willTokenExpireSoon();

          // Assert
          expect(result, isFalse);
        },
      );

      test('should use custom threshold when provided', () async {
        // Arrange
        const customThreshold = Duration(minutes: 10);
        final expiration = DateTime.now().add(
          customThreshold - const Duration(minutes: 1),
        );
        when(
          () => mockSecureStorage.read(key: AppConstants.storageTokenExpiresAt),
        ).thenAnswer((_) async => expiration.toIso8601String());

        // Act
        final result = await authService.willTokenExpireSoon(
          threshold: customThreshold,
        );

        // Assert
        expect(result, isTrue);
      });
    });
  });
}
