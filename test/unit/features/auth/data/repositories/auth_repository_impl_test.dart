import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:flutter_base_app/features/auth/data/models/login_response_model.dart';
import 'package:flutter_base_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_base_app/features/auth/domain/entities/login_request.dart';
import 'package:flutter_base_app/features/auth/domain/entities/login_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      const EmailLoginRequest(email: 'test@example.com', password: 'password'),
    );
    registerFallbackValue(const PhoneLoginRequest(phoneNumber: '81234567890'));
  });

  group('AuthRepositoryImpl', () {
    late AuthRepositoryImpl repository;
    late MockAuthRemoteDataSource mockRemoteDataSource;

    setUp(() {
      mockRemoteDataSource = MockAuthRemoteDataSource();
      repository = AuthRepositoryImpl(remoteDataSource: mockRemoteDataSource);
    });

    group('loginWithPhone', () {
      test(
        'should return LoginResponse when remote data source succeeds',
        () async {
          // Arrange
          const request = PhoneLoginRequest(phoneNumber: '81234567890');
          const loginResponseModel = LoginResponseModel(
            accessToken: 'access_token',
            refreshToken: 'refresh_token',
            expiresIn: 3600,
            tokenType: 'Bearer',
            userId: 'user_123',
            phoneNumber: '81234567890',
          );

          when(
            () => mockRemoteDataSource.loginWithPhone(any()),
          ).thenAnswer((_) async => const Right(loginResponseModel));

          // Act
          final result = await repository.loginWithPhone(request);

          // Assert
          expect(result, isA<Right<Failure, LoginResponse>>());
          result.fold((failure) => fail('Should not return failure'), (
            response,
          ) {
            expect(response.accessToken, equals('access_token'));
            expect(response.refreshToken, equals('refresh_token'));
            expect(response.userId, equals('user_123'));
            expect(response.phoneNumber, equals('81234567890'));
          });
          verify(() => mockRemoteDataSource.loginWithPhone(request)).called(1);
          verifyNoMoreInteractions(mockRemoteDataSource);
        },
      );

      test('should return Failure when remote data source fails', () async {
        // Arrange
        const request = PhoneLoginRequest(phoneNumber: '81234567890');
        const failure = NetworkFailure(
          message: 'Login failed',
          code: 'LOGIN_ERROR',
        );

        when(
          () => mockRemoteDataSource.loginWithPhone(any()),
        ).thenAnswer((_) async => const Left(failure));

        // Act
        final result = await repository.loginWithPhone(request);

        // Assert
        expect(result, isA<Left<Failure, LoginResponse>>());
        result.fold((error) {
          expect(error, equals(failure));
          expect(error, isA<NetworkFailure>());
        }, (response) => fail('Should not return response'));
        verify(() => mockRemoteDataSource.loginWithPhone(request)).called(1);
      });

      test(
        'should return ValidationFailure when phone number is invalid',
        () async {
          // Arrange
          const request = PhoneLoginRequest(
            phoneNumber: '123', // Too short
          );
          const failure = ValidationFailure(
            message: 'Invalid phone number',
            code: 'INVALID_PHONE',
          );

          when(
            () => mockRemoteDataSource.loginWithPhone(any()),
          ).thenAnswer((_) async => const Left(failure));

          // Act
          final result = await repository.loginWithPhone(request);

          // Assert
          expect(result, isA<Left<Failure, LoginResponse>>());
          result.fold((error) {
            expect(error, equals(failure));
            expect(error, isA<ValidationFailure>());
          }, (response) => fail('Should not return response'));
          verify(() => mockRemoteDataSource.loginWithPhone(request)).called(1);
        },
      );
    });

    group('loginWithEmail', () {
      test(
        'should return LoginResponse when remote data source succeeds',
        () async {
          // Arrange
          const request = EmailLoginRequest(
            email: 'test@example.com',
            password: 'Password123',
          );
          const loginResponseModel = LoginResponseModel(
            accessToken: 'access_token',
            refreshToken: 'refresh_token',
            expiresIn: 3600,
            tokenType: 'Bearer',
            userId: 'user_456',
            email: 'test@example.com',
          );

          when(
            () => mockRemoteDataSource.loginWithEmail(any()),
          ).thenAnswer((_) async => const Right(loginResponseModel));

          // Act
          final result = await repository.loginWithEmail(request);

          // Assert
          expect(result, isA<Right<Failure, LoginResponse>>());
          result.fold((failure) => fail('Should not return failure'), (
            response,
          ) {
            expect(response.accessToken, equals('access_token'));
            expect(response.refreshToken, equals('refresh_token'));
            expect(response.userId, equals('user_456'));
            expect(response.email, equals('test@example.com'));
          });
          verify(() => mockRemoteDataSource.loginWithEmail(request)).called(1);
          verifyNoMoreInteractions(mockRemoteDataSource);
        },
      );

      test('should return Failure when remote data source fails', () async {
        // Arrange
        const request = EmailLoginRequest(
          email: 'test@example.com',
          password: 'Password123',
        );
        const failure = NetworkFailure(
          message: 'Login failed',
          code: 'LOGIN_ERROR',
        );

        when(
          () => mockRemoteDataSource.loginWithEmail(any()),
        ).thenAnswer((_) async => const Left(failure));

        // Act
        final result = await repository.loginWithEmail(request);

        // Assert
        expect(result, isA<Left<Failure, LoginResponse>>());
        result.fold((error) {
          expect(error, equals(failure));
          expect(error, isA<NetworkFailure>());
        }, (response) => fail('Should not return response'));
        verify(() => mockRemoteDataSource.loginWithEmail(request)).called(1);
      });

      test('should return ValidationFailure when email is invalid', () async {
        // Arrange
        const request = EmailLoginRequest(
          email: 'invalid-email',
          password: 'Password123',
        );
        const failure = ValidationFailure(
          message: 'Invalid email format',
          code: 'INVALID_EMAIL',
        );

        when(
          () => mockRemoteDataSource.loginWithEmail(any()),
        ).thenAnswer((_) async => const Left(failure));

        // Act
        final result = await repository.loginWithEmail(request);

        // Assert
        expect(result, isA<Left<Failure, LoginResponse>>());
        result.fold((error) {
          expect(error, equals(failure));
          expect(error, isA<ValidationFailure>());
        }, (response) => fail('Should not return response'));
        verify(() => mockRemoteDataSource.loginWithEmail(request)).called(1);
      });

      test('should return AuthFailure when credentials are wrong', () async {
        // Arrange
        const request = EmailLoginRequest(
          email: 'test@example.com',
          password: 'WrongPassword',
        );
        const failure = AuthFailure.unauthorized();

        when(
          () => mockRemoteDataSource.loginWithEmail(any()),
        ).thenAnswer((_) async => const Left(failure));

        // Act
        final result = await repository.loginWithEmail(request);

        // Assert
        expect(result, isA<Left<Failure, LoginResponse>>());
        result.fold((error) {
          expect(error, equals(failure));
          expect(error, isA<AuthFailure>());
        }, (response) => fail('Should not return response'));
        verify(() => mockRemoteDataSource.loginWithEmail(request)).called(1);
      });
    });
  });
}
