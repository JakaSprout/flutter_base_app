import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/config/app_config.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:flutter_base_app/features/auth/domain/entities/login_request.dart';
import 'package:flutter_base_app/features/auth/domain/entities/login_response.dart';
import 'package:flutter_base_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_base_app/features/auth/domain/usecases/login_with_email.dart';
import 'package:flutter_base_app/features/auth/domain/usecases/login_with_phone.dart';
import 'package:flutter_base_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/test_helpers.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      const EmailLoginRequest(email: 'test@example.com', password: 'password'),
    );
    registerFallbackValue(const PhoneLoginRequest(phoneNumber: '81234567890'));
  });

  group('AuthProvider', () {
    late ProviderContainer container;
    late MockAuthRemoteDataSource mockRemoteDataSource;
    late MockAuthRepository mockRepository;
    late AppConfig testConfig;

    setUp(() {
      testConfig = TestHelpers.createTestConfig();
      mockRemoteDataSource = MockAuthRemoteDataSource();
      mockRepository = MockAuthRepository();

      container = TestHelpers.createContainer(
        appConfig: testConfig,
        overrides: [
          authRemoteDataSourceProvider.overrideWithValue(mockRemoteDataSource),
          authRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    group('authRemoteDataSourceProvider', () {
      test('should return AuthRemoteDataSource', () {
        // Act
        final dataSource = container.read(authRemoteDataSourceProvider);

        // Assert
        expect(dataSource, isA<AuthRemoteDataSource>());
        expect(dataSource, equals(mockRemoteDataSource));
      });
    });

    group('authRepositoryProvider', () {
      test('should return AuthRepository', () {
        // Act
        final repository = container.read(authRepositoryProvider);

        // Assert
        expect(repository, isA<AuthRepository>());
        expect(repository, equals(mockRepository));
      });
    });

    group('loginWithPhoneProvider', () {
      test('should return LoginWithPhone use case', () {
        // Act
        final useCase = container.read(loginWithPhoneProvider);

        // Assert
        expect(useCase, isA<LoginWithPhone>());
      });
    });

    group('loginWithEmailProvider', () {
      test('should return LoginWithEmail use case', () {
        // Act
        final useCase = container.read(loginWithEmailProvider);

        // Assert
        expect(useCase, isA<LoginWithEmail>());
      });
    });

    group('phoneLoginProvider', () {
      test('should return LoginResponse when use case succeeds', () async {
        // Arrange
        const request = PhoneLoginRequest(phoneNumber: '81234567890');
        const expectedResponse = LoginResponse(
          accessToken: 'access_token',
          refreshToken: 'refresh_token',
          userId: 'user_123',
          phoneNumber: '81234567890',
        );

        when(
          () => mockRepository.loginWithPhone(any()),
        ).thenAnswer((_) async => const Right(expectedResponse));

        // Act
        final result = await container.read(phoneLoginProvider(request).future);

        // Assert
        expect(result, equals(expectedResponse));
        verify(() => mockRepository.loginWithPhone(request)).called(1);
      });

      test('should throw Failure when use case fails', () async {
        // Arrange
        const request = PhoneLoginRequest(phoneNumber: '81234567890');
        const expectedFailure = NetworkFailure.serverError('Server Error');

        when(
          () => mockRepository.loginWithPhone(any()),
        ).thenAnswer((_) async => const Left(expectedFailure));

        // Act & Assert
        expect(
          () => container.read(phoneLoginProvider(request).future),
          throwsA(isA<NetworkFailure>()),
        );
        verify(() => mockRepository.loginWithPhone(request)).called(1);
      });
    });

    group('emailLoginProvider', () {
      test('should return LoginResponse when use case succeeds', () async {
        // Arrange
        const request = EmailLoginRequest(
          email: 'test@example.com',
          password: 'password123',
        );
        const expectedResponse = LoginResponse(
          accessToken: 'access_token',
          refreshToken: 'refresh_token',
          userId: 'user_456',
          email: 'test@example.com',
        );

        when(
          () => mockRepository.loginWithEmail(any()),
        ).thenAnswer((_) async => const Right(expectedResponse));

        // Act
        final result = await container.read(emailLoginProvider(request).future);

        // Assert
        expect(result, equals(expectedResponse));
        verify(() => mockRepository.loginWithEmail(request)).called(1);
      });

      test('should throw Failure when use case fails', () async {
        // Arrange
        const request = EmailLoginRequest(
          email: 'test@example.com',
          password: 'password123',
        );
        const expectedFailure = NetworkFailure.serverError('Server Error');

        when(
          () => mockRepository.loginWithEmail(any()),
        ).thenAnswer((_) async => const Left(expectedFailure));

        // Act & Assert
        expect(
          () => container.read(emailLoginProvider(request).future),
          throwsA(isA<NetworkFailure>()),
        );
        verify(() => mockRepository.loginWithEmail(request)).called(1);
      });
    });
  });
}
