import 'package:flutter_base_app/core/utils/validators/input_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InputValidators', () {
    group('email', () {
      test('should return null for valid email', () {
        // Arrange
        const validEmails = [
          'test@example.com',
          'user.name@example.co.uk',
          'user+tag@example.com',
          'user123@test-domain.com',
        ];

        // Act & Assert
        for (final email in validEmails) {
          expect(InputValidators.email(email), isNull);
        }
      });

      test('should return error for null or empty email', () {
        // Act & Assert
        expect(InputValidators.email(null), isNotNull);
        expect(InputValidators.email(''), isNotNull);
        expect(InputValidators.email('   '), isNotNull);
      });

      test('should return error for invalid email format', () {
        // Arrange
        const invalidEmails = [
          'invalid',
          '@example.com',
          'user@',
          'user@example',
          'user @example.com',
          'user@example .com',
        ];

        // Act & Assert
        for (final email in invalidEmails) {
          final result = InputValidators.email(email);
          expect(result, isNotNull);
          expect(result, contains('valid email'));
        }
      });
    });

    group('required', () {
      test('should return null for non-empty value', () {
        // Act & Assert
        expect(InputValidators.required('test'), isNull);
        expect(InputValidators.required('  test  '), isNull);
      });

      test('should return error for null or empty value', () {
        // Act & Assert
        expect(InputValidators.required(null), isNotNull);
        expect(InputValidators.required(''), isNotNull);
        expect(InputValidators.required('   '), isNotNull);
      });

      test('should use custom field name in error message', () {
        // Act
        final result = InputValidators.required(null, fieldName: 'Username');

        // Assert
        expect(result, isNotNull);
        expect(result, contains('Username'));
      });
    });

    group('minLength', () {
      test('should return null for value with valid minimum length', () {
        // Act & Assert
        expect(InputValidators.minLength('test', 4), isNull);
        expect(InputValidators.minLength('test123', 4), isNull);
      });

      test('should return error for value below minimum length', () {
        // Act
        final result = InputValidators.minLength('tes', 4);

        // Assert
        expect(result, isNotNull);
        expect(result, contains('at least 4 characters'));
      });

      test('should return error for null or empty value', () {
        // Act & Assert
        expect(InputValidators.minLength(null, 4), isNotNull);
        expect(InputValidators.minLength('', 4), isNotNull);
      });

      test('should use custom field name in error message', () {
        // Act
        final result = InputValidators.minLength(
          'ab',
          4,
          fieldName: 'Password',
        );

        // Assert
        expect(result, isNotNull);
        expect(result, contains('Password'));
      });
    });

    group('maxLength', () {
      test('should return null for value within maximum length', () {
        // Act & Assert
        expect(InputValidators.maxLength('test', 10), isNull);
        expect(InputValidators.maxLength('test123', 10), isNull);
      });

      test('should return null for empty value (optional field)', () {
        // Act & Assert
        // maxLength returns null for empty values as they are optional
        expect(InputValidators.maxLength(null, 10), isNull);
        expect(InputValidators.maxLength('', 10), isNull);
      });

      test('should return error for value exceeding maximum length', () {
        // Act
        final result = InputValidators.maxLength('test123456789', 10);

        // Assert
        expect(result, isNotNull);
        expect(result, contains('not exceed 10 characters'));
      });

      test('should use custom field name in error message', () {
        // Act
        final result = InputValidators.maxLength(
          'very long text',
          10,
          fieldName: 'Description',
        );

        // Assert
        expect(result, isNotNull);
        expect(result, contains('Description'));
      });
    });

    group('lengthRange', () {
      test('should return null for value within range', () {
        // Act & Assert
        expect(InputValidators.lengthRange('test', 4, 10), isNull);
        expect(InputValidators.lengthRange('test123', 4, 10), isNull);
      });

      test('should return error for value below minimum length', () {
        // Act
        final result = InputValidators.lengthRange('tes', 4, 10);

        // Assert
        expect(result, isNotNull);
        expect(result, contains('between 4 and 10 characters'));
      });

      test('should return error for value exceeding maximum length', () {
        // Act
        final result = InputValidators.lengthRange('test123456789', 4, 10);

        // Assert
        expect(result, isNotNull);
        expect(result, contains('between 4 and 10 characters'));
      });

      test('should return error for null or empty value', () {
        // Act & Assert
        expect(InputValidators.lengthRange(null, 4, 10), isNotNull);
        expect(InputValidators.lengthRange('', 4, 10), isNotNull);
      });
    });

    group('phone', () {
      test('should return null for valid phone number', () {
        // Arrange
        const validPhones = [
          '081234567890',
          '+6281234567890',
          '0812-3456-7890',
          '(0812) 3456-7890',
          '0812 3456 7890',
        ];

        // Act & Assert
        for (final phone in validPhones) {
          expect(InputValidators.phone(phone), isNull);
        }
      });

      test('should return error for null or empty phone', () {
        // Act & Assert
        expect(InputValidators.phone(null), isNotNull);
        expect(InputValidators.phone(''), isNotNull);
      });

      test('should return error for phone with too few digits', () {
        // Act
        final result = InputValidators.phone('123');

        // Assert
        expect(result, isNotNull);
        expect(result, contains('valid phone number'));
      });

      test('should return error for phone with too many digits', () {
        // Act
        final result = InputValidators.phone('1234567890123456'); // 16 digits

        // Assert
        expect(result, isNotNull);
        expect(result, contains('valid phone number'));
      });
    });

    group('url', () {
      test('should return null for valid URL', () {
        // Arrange
        const validUrls = [
          'https://example.com',
          'http://example.com',
          'https://www.example.com/path',
          'https://example.com:8080/path?query=value',
        ];

        // Act & Assert
        for (final url in validUrls) {
          expect(InputValidators.url(url), isNull);
        }
      });

      test('should return error for null or empty URL', () {
        // Act & Assert
        expect(InputValidators.url(null), isNotNull);
        expect(InputValidators.url(''), isNotNull);
      });

      test('should return error for invalid URL format', () {
        // Arrange
        const invalidUrls = [
          'invalid',
          'example.com', // Missing scheme
          'not a url',
        ];

        // Act & Assert
        for (final url in invalidUrls) {
          final result = InputValidators.url(url);
          expect(result, isNotNull);
          expect(result, contains('valid URL'));
        }
      });
    });

    group('password', () {
      test('should return null for valid password', () {
        // Arrange
        const validPasswords = ['Password123', 'MyP@ssw0rd', 'Test1234'];

        // Act & Assert
        for (final password in validPasswords) {
          expect(InputValidators.password(password), isNull);
        }
      });

      test('should return error for null or empty password', () {
        // Act & Assert
        expect(InputValidators.password(null), isNotNull);
        expect(InputValidators.password(''), isNotNull);
      });

      test('should return error for password below minimum length', () {
        // Act
        final result = InputValidators.password('Pass1');

        // Assert
        expect(result, isNotNull);
        expect(result, contains('at least 8 characters'));
      });

      test('should return error for password without uppercase', () {
        // Act
        final result = InputValidators.password('password123');

        // Assert
        expect(result, isNotNull);
        expect(result, contains('uppercase letter'));
      });

      test('should return error for password without lowercase', () {
        // Act
        final result = InputValidators.password('PASSWORD123');

        // Assert
        expect(result, isNotNull);
        expect(result, contains('lowercase letter'));
      });

      test('should return error for password without number', () {
        // Act
        final result = InputValidators.password('Password');

        // Assert
        expect(result, isNotNull);
        expect(result, contains('number'));
      });

      test('should use custom minimum length', () {
        // Act
        final result = InputValidators.password('Pass1', minLength: 10);

        // Assert
        expect(result, isNotNull);
        expect(result, contains('at least 10 characters'));
      });
    });

    group('passwordConfirmation', () {
      test('should return null when passwords match', () {
        // Act & Assert
        expect(
          InputValidators.passwordConfirmation('Password123', 'Password123'),
          isNull,
        );
      });

      test('should return error when passwords do not match', () {
        // Act
        final result = InputValidators.passwordConfirmation(
          'Password123',
          'Password456',
        );

        // Assert
        expect(result, isNotNull);
        expect(result, contains('do not match'));
      });

      test('should return error for null or empty confirmation', () {
        // Act & Assert
        expect(
          InputValidators.passwordConfirmation(null, 'Password123'),
          isNotNull,
        );
        expect(
          InputValidators.passwordConfirmation('', 'Password123'),
          isNotNull,
        );
      });
    });

    group('numeric', () {
      test('should return null for valid numeric value', () {
        // Arrange
        const validNumbers = ['123', '123.45', '0', '0.5', '-123', '-123.45'];

        // Act & Assert
        for (final number in validNumbers) {
          expect(InputValidators.numeric(number), isNull);
        }
      });

      test('should return error for null or empty value', () {
        // Act & Assert
        expect(InputValidators.numeric(null), isNotNull);
        expect(InputValidators.numeric(''), isNotNull);
      });

      test('should return error for non-numeric value', () {
        // Arrange
        const invalidNumbers = ['abc', '12abc', 'abc123', '12.34.56'];

        // Act & Assert
        for (final number in invalidNumbers) {
          final result = InputValidators.numeric(number);
          expect(result, isNotNull);
          expect(result, contains('valid number'));
        }
      });

      test('should use custom field name in error message', () {
        // Act
        final result = InputValidators.numeric('abc', fieldName: 'Price');

        // Assert
        expect(result, isNotNull);
        expect(result, contains('Price'));
      });
    });

    group('integer', () {
      test('should return null for valid integer value', () {
        // Arrange
        const validIntegers = ['123', '0', '-123', '999999'];

        // Act & Assert
        for (final integer in validIntegers) {
          expect(InputValidators.integer(integer), isNull);
        }
      });

      test('should return error for null or empty value', () {
        // Act & Assert
        expect(InputValidators.integer(null), isNotNull);
        expect(InputValidators.integer(''), isNotNull);
      });

      test('should return error for non-integer value', () {
        // Arrange
        const invalidIntegers = ['123.45', 'abc', '12abc', '12.34'];

        // Act & Assert
        for (final integer in invalidIntegers) {
          final result = InputValidators.integer(integer);
          expect(result, isNotNull);
          expect(result, contains('valid integer'));
        }
      });
    });

    group('positiveNumber', () {
      test('should return null for valid positive number', () {
        // Arrange
        const validNumbers = ['123', '123.45', '0.1', '999.99'];

        // Act & Assert
        for (final number in validNumbers) {
          expect(InputValidators.positiveNumber(number), isNull);
        }
      });

      test('should return error for null or empty value', () {
        // Act & Assert
        expect(InputValidators.positiveNumber(null), isNotNull);
        expect(InputValidators.positiveNumber(''), isNotNull);
      });

      test('should return error for zero', () {
        // Act
        final result = InputValidators.positiveNumber('0');

        // Assert
        expect(result, isNotNull);
        expect(result, contains('greater than 0'));
      });

      test('should return error for negative number', () {
        // Act
        final result = InputValidators.positiveNumber('-123');

        // Assert
        expect(result, isNotNull);
        expect(result, contains('greater than 0'));
      });

      test('should return error for non-numeric value', () {
        // Act
        final result = InputValidators.positiveNumber('abc');

        // Assert
        expect(result, isNotNull);
        expect(result, contains('valid number'));
      });
    });

    group('date', () {
      test('should return null for valid date format', () {
        // Arrange
        const validDates = [
          '2024-01-01',
          '2024-12-31',
          '2024-01-01T00:00:00Z',
          '2024-01-01 00:00:00',
        ];

        // Act & Assert
        for (final date in validDates) {
          expect(InputValidators.date(date), isNull);
        }
      });

      test('should return error for null or empty date', () {
        // Act & Assert
        expect(InputValidators.date(null), isNotNull);
        expect(InputValidators.date(''), isNotNull);
      });

      test('should return error for invalid date format', () {
        // Arrange
        const invalidDates = ['invalid', 'not-a-date', 'abc123'];

        // Act & Assert
        for (final date in invalidDates) {
          final result = InputValidators.date(date);
          expect(result, isNotNull);
          expect(result, contains('valid date'));
        }
      });

      test(
        'should use custom field name in error message for required field',
        () {
          // Act - Test with null to trigger required field error
          final result = InputValidators.date(null, fieldName: 'Birth Date');

          // Assert
          expect(result, isNotNull);
          expect(result, contains('Birth Date'));
          expect(result, contains('required'));
        },
      );
    });

    group('combine', () {
      test('should return null when all validators pass', () {
        // Arrange
        final validators = [
          InputValidators.required,
          (String? value) => InputValidators.minLength(value, 4),
          InputValidators.email,
        ];

        // Act
        final result = InputValidators.combine(validators, 'test@example.com');

        // Assert
        expect(result, isNull);
      });

      test('should return first error when any validator fails', () {
        // Arrange
        final validators = [
          InputValidators.required,
          (String? value) => InputValidators.minLength(value, 4),
          InputValidators.email,
        ];

        // Act
        final result = InputValidators.combine(validators, null);

        // Assert
        expect(result, isNotNull);
        expect(result, contains('required'));
      });

      test('should stop at first failing validator', () {
        // Arrange
        final validators = [
          InputValidators.required,
          (String? value) => InputValidators.minLength(value, 10),
          InputValidators.email,
        ];

        // Act
        final result = InputValidators.combine(validators, 'test');

        // Assert
        expect(result, isNotNull);
        expect(result, contains('at least 10 characters'));
        // Should not check email validator since minLength already failed
      });
    });
  });
}
