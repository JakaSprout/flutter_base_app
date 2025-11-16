import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/config/app_config.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:flutter_base_app/features/auth/data/models/country_code_model.dart';
import 'package:flutter_base_app/features/auth/data/models/login_response_model.dart';
import 'package:flutter_base_app/features/auth/domain/entities/login_request.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/auth_constants.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../helpers/test_helpers.dart';

void main() {
  group('AuthRemoteDataSourceMock', () {
    late AuthRemoteDataSourceMock dataSource;
    late AppConfig testConfig;

    setUp(() {
      testConfig = TestHelpers.createTestConfig();
      dataSource = AuthRemoteDataSourceMock(config: testConfig);
    });

    group('getCountryCodes', () {
      test('should return list of CountryCodeModel when successful', () async {
        // Act
        final result = await dataSource.getCountryCodes();

        // Assert
        expect(result, isA<Right<Failure, List<CountryCodeModel>>>());
        result.fold((failure) => fail('Should not return failure'), (data) {
          expect(data, isNotEmpty);
          expect(data.length, greaterThanOrEqualTo(1));
          expect(data.first, isA<CountryCodeModel>());
          // Check that Indonesia is in the list (default country)
          final indonesia = data.firstWhere(
            (code) => code.code == 'ID',
            orElse: () => throw Exception('Indonesia not found'),
          );
          expect(indonesia.dialCode, equals('+62'));
          expect(indonesia.name, equals('Indonesia'));
        });
      });

      test('should return expected country codes', () async {
        // Act
        final result = await dataSource.getCountryCodes();

        // Assert
        result.fold((failure) => fail('Should not return failure'), (data) {
          // Check for common countries
          final codes = data.map((e) => e.code).toList();
          expect(codes, contains('ID')); // Indonesia
          expect(codes, contains('MY')); // Malaysia
          expect(codes, contains('SG')); // Singapore
          expect(codes, contains('US')); // United States
        });
      });
    });

    group('loginWithPhone', () {
      test(
        'should return LoginResponseModel when login is successful',
        () async {
          // Arrange
          const request = PhoneLoginRequest(
            countryCode: '+62',
            phoneNumber: '81234567890',
            password: 'password123',
          );

          // Act
          final result = await dataSource.loginWithPhone(request);

          // Assert
          expect(result, isA<Right<Failure, LoginResponseModel>>());
          result.fold((failure) => fail('Should not return failure'), (data) {
            expect(data.accessToken, isNotEmpty);
            expect(data.refreshToken, isNotEmpty);
            expect(data.userId, equals('user_123'));
            expect(data.phoneNumber, equals('+6281234567890'));
          });
        },
      );

      test(
        'should return ValidationFailure when phone number is empty',
        () async {
          // Arrange
          const request = PhoneLoginRequest(
            countryCode: '+62',
            phoneNumber: '',
            password: 'password123',
          );

          // Act
          final result = await dataSource.loginWithPhone(request);

          // Assert
          expect(result, isA<Left<Failure, LoginResponseModel>>());
          result.fold((failure) {
            expect(failure, isA<ValidationFailure>());
            expect(
              failure.message,
              equals(AuthConstants.errorPhoneNumberAndPasswordRequired),
            );
          }, (data) => fail('Should return failure'));
        },
      );

      test('should return ValidationFailure when password is empty', () async {
        // Arrange
        const request = PhoneLoginRequest(
          countryCode: '+62',
          phoneNumber: '81234567890',
          password: '',
        );

        // Act
        final result = await dataSource.loginWithPhone(request);

        // Assert
        expect(result, isA<Left<Failure, LoginResponseModel>>());
        result.fold((failure) {
          expect(failure, isA<ValidationFailure>());
          expect(
            failure.message,
            equals(AuthConstants.errorPhoneNumberAndPasswordRequired),
          );
        }, (data) => fail('Should return failure'));
      });

      test(
        'should return ValidationFailure when phone number is too short',
        () async {
          // Arrange
          const request = PhoneLoginRequest(
            countryCode: '+62',
            phoneNumber: '123', // Too short
            password: 'password123',
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
            countryCode: '+62',
            phoneNumber: '12345678901234567890', // Too long
            password: 'password123',
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
          countryCode: '+62',
          phoneNumber: '812-3456-7890', // Contains dashes
          password: 'password123',
        );

        // Act
        final result = await dataSource.loginWithPhone(request);

        // Assert
        // Should succeed because non-digit characters are removed for validation
        expect(result, isA<Right<Failure, LoginResponseModel>>());
        result.fold((failure) => fail('Should not return failure'), (data) {
          expect(data.accessToken, isNotEmpty);
          expect(data.phoneNumber, equals('+62812-3456-7890'));
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
            expect(data.userId, equals('user_456'));
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
