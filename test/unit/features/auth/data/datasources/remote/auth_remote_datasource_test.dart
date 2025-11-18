import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/config/app_config.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/auth/data/datasources/remote/auth_remote_datasource_mock.dart';
import 'package:flutter_base_app/features/auth/data/models/login_response_model.dart';
import 'package:flutter_base_app/features/auth/domain/entities/login_request.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/auth_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../helpers/test_helpers.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  group('AuthRemoteDataSourceMock', () {
    late AuthRemoteDataSourceMock dataSource;
    late AppConfig testConfig;
    late MockFlutterSecureStorage mockSecureStorage;

    setUp(() {
      testConfig = TestHelpers.createTestConfig();
      mockSecureStorage = MockFlutterSecureStorage();
      // Mock secure storage to return null by default (no session)
      when(
        () => mockSecureStorage.read(key: any(named: 'key')),
      ).thenAnswer((_) async => null);
      dataSource = AuthRemoteDataSourceMock(
        config: testConfig,
        secureStorage: mockSecureStorage,
      );
    });

    group('loginWithPhone', () {
      test(
        'should return LoginResponseModel when login is successful',
        () async {
          // Arrange
          const request = PhoneLoginRequest(phoneNumber: '81234567890');

          // Act
          final result = await dataSource.loginWithPhone(request);

          // Assert
          expect(result, isA<Right<Failure, LoginResponseModel>>());
          result.fold((failure) => fail('Should not return failure'), (data) {
            expect(data.accessToken, isNotEmpty);
            expect(data.refreshToken, isNotEmpty);
            expect(data.sessionId, isNotEmpty);
            expect(data.tokenType, equals('Bearer'));
            expect(data.user, isNotNull);
            expect(data.user?['id'], equals('user_123'));
            expect(data.phoneNumber, equals('81234567890'));
          });
        },
      );

      test(
        'should return ValidationFailure when phone number is empty',
        () async {
          // Arrange
          const request = PhoneLoginRequest(phoneNumber: '');

          // Act
          final result = await dataSource.loginWithPhone(request);

          // Assert
          expect(result, isA<Left<Failure, LoginResponseModel>>());
          result.fold((failure) {
            expect(failure, isA<ValidationFailure>());
            expect(
              failure.message,
              equals(AuthConstants.errorPhoneNumberRequired),
            );
          }, (data) => fail('Should return failure'));
        },
      );

      test(
        'should return ValidationFailure when phone number is too short',
        () async {
          // Arrange
          const request = PhoneLoginRequest(
            phoneNumber: '123', // Too short
          );

          // Act
          final result = await dataSource.loginWithPhone(request);

          // Assert
          expect(result, isA<Left<Failure, LoginResponseModel>>());
          result.fold((failure) {
            expect(failure, isA<ValidationFailure>());
            expect(
              failure.message,
              equals(AuthConstants.errorPhoneNumberLength),
            );
          }, (data) => fail('Should return failure'));
        },
      );

      test(
        'should return ValidationFailure when phone number is too long',
        () async {
          // Arrange
          const request = PhoneLoginRequest(
            phoneNumber: '12345678901234567890', // Too long
          );

          // Act
          final result = await dataSource.loginWithPhone(request);

          // Assert
          expect(result, isA<Left<Failure, LoginResponseModel>>());
          result.fold((failure) {
            expect(failure, isA<ValidationFailure>());
            expect(
              failure.message,
              equals(AuthConstants.errorPhoneNumberLength),
            );
          }, (data) => fail('Should return failure'));
        },
      );

      test('should handle phone number with non-digit characters', () async {
        // Arrange
        const request = PhoneLoginRequest(
          phoneNumber: '0812-3456-7890', // Contains dashes
        );

        // Act
        final result = await dataSource.loginWithPhone(request);

        // Assert
        // Should succeed because non-digit characters are removed for validation
        // Phone number in response will be cleaned (no dashes)
        expect(result, isA<Right<Failure, LoginResponseModel>>());
        result.fold((failure) => fail('Should not return failure'), (data) {
          expect(data.accessToken, isNotEmpty);
          expect(data.sessionId, isNotEmpty);
          // Phone number is cleaned in request payload (non-digits removed)
          expect(data.phoneNumber, equals('081234567890'));
        });
      });
    });

    group('loginWithEmail', () {
      test(
        'should return LoginResponseModel when login is successful',
        () async {
          // Arrange
          const request = EmailLoginRequest(
            email: 'test@example.com',
            password: 'password123',
          );

          // Act
          final result = await dataSource.loginWithEmail(request);

          // Assert
          expect(result, isA<Right<Failure, LoginResponseModel>>());
          result.fold((failure) => fail('Should not return failure'), (data) {
            expect(data.accessToken, isNotEmpty);
            expect(data.refreshToken, isNotEmpty);
            expect(data.sessionId, isNotEmpty);
            expect(data.tokenType, equals('Bearer'));
            expect(data.user, isNotNull);
            expect(data.user?['id'], equals('user_456'));
            expect(data.email, equals('test@example.com'));
          });
        },
      );

      test('should return ValidationFailure when email is empty', () async {
        // Arrange
        const request = EmailLoginRequest(email: '', password: 'password123');

        // Act
        final result = await dataSource.loginWithEmail(request);

        // Assert
        expect(result, isA<Left<Failure, LoginResponseModel>>());
        result.fold((failure) {
          expect(failure, isA<ValidationFailure>());
          expect(
            failure.message,
            equals(AuthConstants.errorEmailAndPasswordRequired),
          );
        }, (data) => fail('Should return failure'));
      });

      test('should return ValidationFailure when password is empty', () async {
        // Arrange
        const request = EmailLoginRequest(
          email: 'test@example.com',
          password: '',
        );

        // Act
        final result = await dataSource.loginWithEmail(request);

        // Assert
        expect(result, isA<Left<Failure, LoginResponseModel>>());
        result.fold((failure) {
          expect(failure, isA<ValidationFailure>());
          expect(
            failure.message,
            equals(AuthConstants.errorEmailAndPasswordRequired),
          );
        }, (data) => fail('Should return failure'));
      });

      test(
        'should return ValidationFailure when email format is invalid',
        () async {
          // Arrange
          const request = EmailLoginRequest(
            email: 'invalid-email', // Missing @
            password: 'password123',
          );

          // Act
          final result = await dataSource.loginWithEmail(request);

          // Assert
          expect(result, isA<Left<Failure, LoginResponseModel>>());
          result.fold((failure) {
            expect(failure, isA<ValidationFailure>());
            expect(
              failure.message,
              equals(AuthConstants.errorInvalidEmailFormat),
            );
          }, (data) => fail('Should return failure'));
        },
      );

      test('should accept valid email formats', () async {
        // Arrange
        const request = EmailLoginRequest(
          email: 'user.name+tag@example.co.uk',
          password: 'password123',
        );

        // Act
        final result = await dataSource.loginWithEmail(request);

        // Assert
        expect(result, isA<Right<Failure, LoginResponseModel>>());
        result.fold((failure) => fail('Should not return failure'), (data) {
          expect(data.email, equals('user.name+tag@example.co.uk'));
        });
      });
    });
  });
}
