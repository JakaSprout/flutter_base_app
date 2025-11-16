import 'package:flutter_base_app/core/utils/extensions/string_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StringExtensions', () {
    group('isNullOrEmpty', () {
      test('should return true for empty string', () {
        expect(''.isNullOrEmpty, isTrue);
      });

      test('should return false for non-empty string', () {
        expect('hello'.isNullOrEmpty, isFalse);
      });
    });

    group('isNotNullOrEmpty', () {
      test('should return false for empty string', () {
        expect(''.isNotNullOrEmpty, isFalse);
      });

      test('should return true for non-empty string', () {
        expect('hello'.isNotNullOrEmpty, isTrue);
      });
    });

    group('isValidEmail', () {
      test('should return true for valid email', () {
        expect('test@example.com'.isValidEmail, isTrue);
        expect('user.name@domain.co.uk'.isValidEmail, isTrue);
        expect('user+tag@example.com'.isValidEmail, isTrue);
      });

      test('should return false for invalid email', () {
        expect('invalid'.isValidEmail, isFalse);
        expect('@example.com'.isValidEmail, isFalse);
        expect('user@'.isValidEmail, isFalse);
        expect('user@domain'.isValidEmail, isFalse);
      });
    });

    group('isValidUrl', () {
      test('should return true for valid URL', () {
        expect('https://example.com'.isValidUrl, isTrue);
        expect('http://example.com'.isValidUrl, isTrue);
        expect('https://example.com/path'.isValidUrl, isTrue);
        expect('https://example.com:8080/path?query=value'.isValidUrl, isTrue);
      });

      test('should return false for invalid URL', () {
        expect('not a url'.isValidUrl, isFalse);
        expect('example.com'.isValidUrl, isFalse);
        expect('://example.com'.isValidUrl, isFalse);
      });
    });

    group('capitalize', () {
      test('should capitalize first letter', () {
        expect('hello'.capitalize, equals('Hello'));
        expect('HELLO'.capitalize, equals('HELLO'));
        expect('hELLO'.capitalize, equals('HELLO'));
      });

      test('should return empty string for empty input', () {
        expect(''.capitalize, equals(''));
      });
    });

    group('toTitleCase', () {
      test('should convert to title case', () {
        expect('hello world'.toTitleCase, equals('Hello World'));
        expect('HELLO WORLD'.toTitleCase, equals('HELLO WORLD'));
        expect('hello WORLD'.toTitleCase, equals('Hello WORLD'));
      });

      test('should return empty string for empty input', () {
        expect(''.toTitleCase, equals(''));
      });
    });

    group('removeWhitespace', () {
      test('should remove all whitespace', () {
        expect('hello world'.removeWhitespace, equals('helloworld'));
        expect('  hello   world  '.removeWhitespace, equals('helloworld'));
        expect('hello\nworld\t'.removeWhitespace, equals('helloworld'));
      });
    });

    group('truncate', () {
      test('should truncate long string', () {
        expect('hello world'.truncate(5), equals('hello...'));
        expect('hello'.truncate(10), equals('hello'));
      });

      test('should use custom ellipsis', () {
        expect('hello world'.truncate(5, ellipsis: '..'), equals('hello..'));
      });
    });

    group('mask', () {
      test('should mask string with default settings', () {
        expect('1234567890'.mask(), equals('12******90'));
      });

      test('should mask with custom visible start and end', () {
        expect('1234567890'.mask(visibleStart: 3, visibleEnd: 3), equals('123****890'));
      });

      test('should mask with custom mask character', () {
        expect('1234567890'.mask(maskChar: 'X'), equals('12XXXXXX90'));
      });

      test('should return original string if too short', () {
        expect('123'.mask(), equals('123'));
      });
    });
  });

  group('NullableStringExtensions', () {
    group('isNullOrEmpty', () {
      test('should return true for null', () {
        String? str;
        expect(str.isNullOrEmpty, isTrue);
      });

      test('should return true for empty string', () {
        expect(''.isNullOrEmpty, isTrue);
      });

      test('should return false for non-empty string', () {
        expect('hello'.isNullOrEmpty, isFalse);
      });
    });

    group('isNotNullOrEmpty', () {
      test('should return false for null', () {
        String? str;
        expect(str.isNotNullOrEmpty, isFalse);
      });

      test('should return false for empty string', () {
        expect(''.isNotNullOrEmpty, isFalse);
      });

      test('should return true for non-empty string', () {
        expect('hello'.isNotNullOrEmpty, isTrue);
      });
    });

    group('orEmpty', () {
      test('should return empty string for null', () {
        String? str;
        expect(str.orEmpty, equals(''));
      });

      test('should return original string for non-null', () {
        expect('hello'.orEmpty, equals('hello'));
      });
    });

    group('orDefault', () {
      test('should return default for null', () {
        String? str;
        expect(str.orDefault('default'), equals('default'));
      });

      test('should return default for empty string', () {
        expect(''.orDefault('default'), equals('default'));
      });

      test('should return original string for non-empty', () {
        expect('hello'.orDefault('default'), equals('hello'));
      });
    });
  });
}

