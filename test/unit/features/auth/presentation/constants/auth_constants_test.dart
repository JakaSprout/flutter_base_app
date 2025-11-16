import 'package:flutter_base_app/features/auth/presentation/constants/auth_constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthConstants', () {
    test('should have correct screen titles', () {
      // Assert
      expect(AuthConstants.titlePhoneLogin, equals('Input WhatsApp Number'));
      expect(AuthConstants.titleEmailLogin, equals('Input Active Email'));
    });

    test('should have correct input hints', () {
      // Assert
      expect(AuthConstants.hintPhoneNumber, equals('8123-4567-8901'));
      expect(AuthConstants.hintEmail, equals('Input email address'));
      expect(AuthConstants.hintPassword, equals('Password'));
    });

    test('should have correct validation messages', () {
      // Assert
      expect(
        AuthConstants.errorTermsNotAccepted,
        contains('terms and conditions'),
      );
      expect(
        AuthConstants.errorCountryCodeNotSelected,
        contains('country code'),
      );
      expect(AuthConstants.errorFieldsEmpty, contains('fill in all fields'));
      expect(AuthConstants.errorPhoneNumberLength, contains('8 and 15 digits'));
    });

    test('should have correct terms and conditions text', () {
      // Assert
      expect(AuthConstants.termsAgreementPrefix, contains("STP's"));
      expect(AuthConstants.termsAndConditions, equals('Terms & Conditions'));
      expect(AuthConstants.termsSeparator, equals(' and '));
      expect(AuthConstants.privacyPolicy, equals('Privacy Policy'));
    });

    test('should have correct button labels', () {
      // Assert
      expect(AuthConstants.buttonLogin, equals('Login'));
      expect(AuthConstants.buttonLoginWithEmail, equals('Login with Email'));
      expect(
        AuthConstants.buttonLoginWithPhone,
        equals('Login with Phone Number'),
      );
    });

    test('should have correct separators', () {
      // Assert
      expect(AuthConstants.separatorOr, equals('Or'));
    });

    test('should have correct default values', () {
      // Assert
      expect(AuthConstants.defaultCountryCode, equals('ID'));
    });

    test('should have correct phone validation limits', () {
      // Assert
      expect(AuthConstants.phoneMinDigits, equals(8));
      expect(AuthConstants.phoneMaxDigits, equals(15));
    });

    test('should have correct data source error messages', () {
      // Assert
      expect(
        AuthConstants.errorPhoneNumberAndPasswordRequired,
        contains('Phone number and password'),
      );
      expect(
        AuthConstants.errorEmailAndPasswordRequired,
        contains('Email and password'),
      );
      expect(
        AuthConstants.errorInvalidEmailFormat,
        contains('Invalid email format'),
      );
      expect(
        AuthConstants.errorFailedToGetCountryCodes,
        contains('Failed to get country codes'),
      );
      expect(AuthConstants.errorLoginFailed, contains('Login failed'));
    });
  });
}
