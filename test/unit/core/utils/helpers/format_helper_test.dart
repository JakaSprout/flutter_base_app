import 'package:flutter_base_app/core/utils/helpers/format_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FormatHelper', () {
    group('formatNumber', () {
      test('should format number with thousand separator', () {
        expect(FormatHelper.formatNumber(1000), equals('1,000'));
        expect(FormatHelper.formatNumber(1000000), equals('1,000,000'));
      });

      test('should format number with decimals', () {
        expect(FormatHelper.formatNumber(1000.5, decimals: 2), equals('1,000.50'));
        expect(FormatHelper.formatNumber(1234.567, decimals: 2), equals('1,234.57'));
      });
    });

    group('formatCurrency', () {
      test('should format currency with default symbol', () {
        expect(FormatHelper.formatCurrency(1000), contains('Rp'));
        expect(FormatHelper.formatCurrency(1000), contains('1,000'));
      });

      test('should format currency with custom symbol', () {
        final formatted = FormatHelper.formatCurrency(1000, symbol: r'$');
        expect(formatted, contains(r'$'));
      });

      test('should format currency with decimals', () {
        final formatted = FormatHelper.formatCurrency(1000.5, decimals: 2);
        expect(formatted, contains('1,000.50'));
      });
    });

    group('formatPercentage', () {
      test('should format percentage', () {
        expect(FormatHelper.formatPercentage(50), contains('50'));
        expect(FormatHelper.formatPercentage(50), contains('%'));
      });

      test('should format percentage with decimals', () {
        final formatted = FormatHelper.formatPercentage(50.5);
        expect(formatted, contains('50.50'));
      });
    });

    group('formatFileSize', () {
      test('should format bytes', () {
        expect(FormatHelper.formatFileSize(500), equals('500 B'));
      });

      test('should format kilobytes', () {
        expect(FormatHelper.formatFileSize(2048), equals('2.00 KB'));
      });

      test('should format megabytes', () {
        expect(FormatHelper.formatFileSize(1048576 * 2), equals('2.00 MB'));
      });

      test('should format gigabytes', () {
        expect(FormatHelper.formatFileSize(1073741824), equals('1.00 GB'));
      });
    });

    group('formatDuration', () {
      test('should format duration with hours', () {
        const duration = Duration(hours: 2, minutes: 30, seconds: 45);
        final formatted = FormatHelper.formatDuration(duration);
        expect(formatted, contains('2h'));
        expect(formatted, contains('30m'));
        expect(formatted, contains('45s'));
      });

      test('should format duration with minutes only', () {
        const duration = Duration(minutes: 5, seconds: 30);
        final formatted = FormatHelper.formatDuration(duration);
        expect(formatted, contains('5m'));
        expect(formatted, contains('30s'));
        expect(formatted, isNot(contains('h')));
      });

      test('should format duration with seconds only', () {
        const duration = Duration(seconds: 30);
        final formatted = FormatHelper.formatDuration(duration);
        expect(formatted, contains('30s'));
        expect(formatted, isNot(contains('m')));
        expect(formatted, isNot(contains('h')));
      });
    });

    group('formatPhoneNumber', () {
      test('should format phone number with default mask', () {
        expect(FormatHelper.formatPhoneNumber('081234567890'), equals('081-2345-6789'));
      });

      test('should format phone number with custom mask', () {
        final formatted = FormatHelper.formatPhoneNumber(
          '081234567890',
          mask: 'XXX.XXXX.XXXX',
        );
        expect(formatted, contains('.'));
      });
    });

    group('formatCreditCard', () {
      test('should format credit card number', () {
        expect(FormatHelper.formatCreditCard('1234567890123456'), equals('**** **** **** 3456'));
      });

      test('should return original if too short', () {
        expect(FormatHelper.formatCreditCard('123'), equals('123'));
      });
    });

    group('truncate', () {
      test('should truncate long text', () {
        expect(FormatHelper.truncate('hello world', 5), equals('hello...'));
        expect(FormatHelper.truncate('hello', 10), equals('hello'));
      });

      test('should use custom ellipsis', () {
        expect(FormatHelper.truncate('hello world', 5, ellipsis: '..'), equals('hello..'));
      });
    });

    group('capitalize', () {
      test('should capitalize first letter', () {
        expect(FormatHelper.capitalize('hello'), equals('Hello'));
        expect(FormatHelper.capitalize('HELLO'), equals('HELLO'));
      });

      test('should return empty string for empty input', () {
        expect(FormatHelper.capitalize(''), equals(''));
      });
    });

    group('toTitleCase', () {
      test('should convert to title case', () {
        expect(FormatHelper.toTitleCase('hello world'), equals('Hello World'));
        expect(FormatHelper.toTitleCase('HELLO WORLD'), equals('HELLO WORLD'));
      });
    });

    group('removeWhitespace', () {
      test('should remove all whitespace', () {
        expect(FormatHelper.removeWhitespace('hello world'), equals('helloworld'));
        expect(FormatHelper.removeWhitespace('  hello   world  '), equals('helloworld'));
      });
    });

    group('maskString', () {
      test('should mask string with default settings', () {
        expect(FormatHelper.maskString('1234567890'), equals('12******90'));
      });

      test('should mask with custom visible start and end', () {
        expect(FormatHelper.maskString('1234567890', visibleStart: 3, visibleEnd: 3), equals('123****890'));
      });

      test('should mask with custom mask character', () {
        expect(FormatHelper.maskString('1234567890', maskChar: 'X'), equals('12XXXXXX90'));
      });

      test('should return original string if too short', () {
        expect(FormatHelper.maskString('123'), equals('123'));
      });
    });

    group('bytesToHex', () {
      test('should convert bytes to hex string', () {
        final bytes = [0x12, 0x34, 0xAB, 0xCD];
        final hex = FormatHelper.bytesToHex(bytes);
        expect(hex, equals('1234abcd'));
      });
    });

    group('hexToBytes', () {
      test('should convert hex string to bytes', () {
        final bytes = FormatHelper.hexToBytes('1234abcd');
        expect(bytes, equals([0x12, 0x34, 0xAB, 0xCD]));
      });
    });
  });
}

