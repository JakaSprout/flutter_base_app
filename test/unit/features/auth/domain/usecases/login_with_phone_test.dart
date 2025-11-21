import 'package:dartz/dartz.dart';
import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/auth/domain/entities/login_request.dart';
import 'package:app_mobile_afms/features/auth/domain/entities/login_response.dart';
import 'package:app_mobile_afms/features/auth/domain/repositories/auth_repository.dart';
import 'package:app_mobile_afms/features/auth/domain/usecases/login_with_phone.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(const PhoneLoginRequest(phoneNumber: '81234567890'));
  });

  group('LoginWithPhone', () {
    late LoginWithPhone useCase;
    late MockAuthRepository mockRepository;

    setUp(() {
      mockRepository = MockAuthRepository();
      useCase = LoginWithPhone(mockRepository);
    });

    test(
      'should return LoginResponse when repository call is successful',
      () async {
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
        final result = await useCase(request);

        // Assert
        expect(result, isA<Right<Failure, LoginResponse>>());
        result.fold((failure) => fail('Should not return failure'), (response) {
          expect(response, equals(expectedResponse));
          expect(response.accessToken, equals('access_token'));
          expect(response.refreshToken, equals('refresh_token'));
          expect(response.userId, equals('user_123'));
          expect(response.phoneNumber, equals('81234567890'));
        });
        verify(() => mockRepository.loginWithPhone(request)).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test('should return Failure when repository call fails', () async {
      // Arrange
      const request = PhoneLoginRequest(phoneNumber: '81234567890');
      const failure = NetworkFailure(
        message: 'Network error',
        code: 'NETWORK_ERROR',
      );

      when(
        () => mockRepository.loginWithPhone(any()),
      ).thenAnswer((_) async => const Left(failure));

      // Act
      final result = await useCase(request);

      // Assert
      expect(result, isA<Left<Failure, LoginResponse>>());
      result.fold((error) {
        expect(error, equals(failure));
        expect(error, isA<NetworkFailure>());
      }, (response) => fail('Should not return response'));
      verify(() => mockRepository.loginWithPhone(request)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test(
      'should return ValidationFailure when phone number is invalid',
      () async {
        // Arrange
        const request = PhoneLoginRequest(
          phoneNumber: '123', // Too short
        );
        const failure = ValidationFailure(
          message: 'Invalid phone number format',
          code: 'INVALID_PHONE',
        );

        when(
          () => mockRepository.loginWithPhone(any()),
        ).thenAnswer((_) async => const Left(failure));

        // Act
        final result = await useCase(request);

        // Assert
        expect(result, isA<Left<Failure, LoginResponse>>());
        result.fold((error) {
          expect(error, equals(failure));
          expect(error, isA<ValidationFailure>());
        }, (response) => fail('Should not return response'));
        verify(() => mockRepository.loginWithPhone(request)).called(1);
      },
    );

    test('should return AuthFailure when credentials are wrong', () async {
      // Arrange
      const request = PhoneLoginRequest(phoneNumber: '81234567890');
      const failure = AuthFailure.unauthorized();

      when(
        () => mockRepository.loginWithPhone(any()),
      ).thenAnswer((_) async => const Left(failure));

      // Act
      final result = await useCase(request);

      // Assert
      expect(result, isA<Left<Failure, LoginResponse>>());
      result.fold((error) {
        expect(error, equals(failure));
        expect(error, isA<AuthFailure>());
      }, (response) => fail('Should not return response'));
      verify(() => mockRepository.loginWithPhone(request)).called(1);
    });

    test('should handle phone numbers with leading zero', () async {
      // Arrange
      const request = PhoneLoginRequest(phoneNumber: '01234567890');
      const expectedResponse = LoginResponse(
        accessToken: 'access_token',
        refreshToken: 'refresh_token',
        userId: 'user_456',
        phoneNumber: '01234567890',
      );

      when(
        () => mockRepository.loginWithPhone(any()),
      ).thenAnswer((_) async => const Right(expectedResponse));

      // Act
      final result = await useCase(request);

      // Assert
      expect(result, isA<Right<Failure, LoginResponse>>());
      result.fold((failure) => fail('Should not return failure'), (response) {
        expect(response.phoneNumber, equals('01234567890'));
      });
      verify(() => mockRepository.loginWithPhone(request)).called(1);
    });
  });
}
