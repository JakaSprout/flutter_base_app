import 'package:dartz/dartz.dart';
import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/auth/domain/entities/login_request.dart';
import 'package:app_mobile_afms/features/auth/domain/entities/login_response.dart';
import 'package:app_mobile_afms/features/auth/domain/repositories/auth_repository.dart';
import 'package:app_mobile_afms/features/auth/domain/usecases/login_with_email.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      const EmailLoginRequest(email: 'test@example.com', password: 'password'),
    );
  });

  group('LoginWithEmail', () {
    late LoginWithEmail useCase;
    late MockAuthRepository mockRepository;

    setUp(() {
      mockRepository = MockAuthRepository();
      useCase = LoginWithEmail(mockRepository);
    });

    test(
      'should return LoginResponse when repository call is successful',
      () async {
        // Arrange
        const request = EmailLoginRequest(
          email: 'test@example.com',
          password: 'Password123',
        );
        const expectedResponse = LoginResponse(
          accessToken: 'access_token',
          refreshToken: 'refresh_token',
          userId: 'user_123',
          email: 'test@example.com',
        );

        when(
          () => mockRepository.loginWithEmail(any()),
        ).thenAnswer((_) async => const Right(expectedResponse));

        // Act
        final result = await useCase(request);

        // Assert
        expect(result, isA<Right<Failure, LoginResponse>>());
        result.fold((failure) => fail('Should not return failure'), (response) {
          expect(response, equals(expectedResponse));
          expect(response.accessToken, equals('access_token'));
          expect(response.refreshToken, equals('refresh_token'));
          expect(response.userId, equals('user_123'));
          expect(response.email, equals('test@example.com'));
        });
        verify(() => mockRepository.loginWithEmail(request)).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test('should return Failure when repository call fails', () async {
      // Arrange
      const request = EmailLoginRequest(
        email: 'test@example.com',
        password: 'Password123',
      );
      const failure = NetworkFailure(
        message: 'Network error',
        code: 'NETWORK_ERROR',
      );

      when(
        () => mockRepository.loginWithEmail(any()),
      ).thenAnswer((_) async => const Left(failure));

      // Act
      final result = await useCase(request);

      // Assert
      expect(result, isA<Left<Failure, LoginResponse>>());
      result.fold((error) {
        expect(error, equals(failure));
        expect(error, isA<NetworkFailure>());
      }, (response) => fail('Should not return response'));
      verify(() => mockRepository.loginWithEmail(request)).called(1);
      verifyNoMoreInteractions(mockRepository);
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
        () => mockRepository.loginWithEmail(any()),
      ).thenAnswer((_) async => const Left(failure));

      // Act
      final result = await useCase(request);

      // Assert
      expect(result, isA<Left<Failure, LoginResponse>>());
      result.fold((error) {
        expect(error, equals(failure));
        expect(error, isA<ValidationFailure>());
      }, (response) => fail('Should not return response'));
      verify(() => mockRepository.loginWithEmail(request)).called(1);
    });

    test('should return AuthFailure when credentials are wrong', () async {
      // Arrange
      const request = EmailLoginRequest(
        email: 'test@example.com',
        password: 'WrongPassword',
      );
      const failure = AuthFailure.unauthorized();

      when(
        () => mockRepository.loginWithEmail(any()),
      ).thenAnswer((_) async => const Left(failure));

      // Act
      final result = await useCase(request);

      // Assert
      expect(result, isA<Left<Failure, LoginResponse>>());
      result.fold((error) {
        expect(error, equals(failure));
        expect(error, isA<AuthFailure>());
      }, (response) => fail('Should not return response'));
      verify(() => mockRepository.loginWithEmail(request)).called(1);
    });
  });
}
