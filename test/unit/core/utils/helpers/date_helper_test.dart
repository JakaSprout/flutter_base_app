import 'package:app_mobile_afms/core/utils/helpers/date_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DateHelper', () {
    group('formatDate', () {
      test('should format date with default format', () {
        final date = DateTime(2024, 1, 15);
        final formatted = DateHelper.formatDate(date);
        expect(formatted, equals('2024-01-15'));
      });

      test('should format date with custom format', () {
        final date = DateTime(2024, 1, 15);
        final formatted = DateHelper.formatDate(date, format: 'dd/MM/yyyy');
        expect(formatted, equals('15/01/2024'));
      });
    });

    group('formatTime', () {
      test('should format time with default format', () {
        final date = DateTime(2024, 1, 15, 14, 30, 45);
        final formatted = DateHelper.formatTime(date);
        expect(formatted, equals('14:30:45'));
      });

      test('should format time with custom format', () {
        final date = DateTime(2024, 1, 15, 14, 30, 45);
        final formatted = DateHelper.formatTime(date, format: 'HH:mm');
        expect(formatted, equals('14:30'));
      });
    });

    group('formatDateTime', () {
      test('should format datetime with default format', () {
        final date = DateTime(2024, 1, 15, 14, 30, 45);
        final formatted = DateHelper.formatDateTime(date);
        expect(formatted, equals('2024-01-15 14:30:45'));
      });
    });

    group('parseDate', () {
      test('should parse date from string', () {
        final parsed = DateHelper.parseDate('2024-01-15');
        expect(parsed, isNotNull);
        expect(parsed?.year, equals(2024));
        expect(parsed?.month, equals(1));
        expect(parsed?.day, equals(15));
      });

      test('should return null for invalid date string', () {
        final parsed = DateHelper.parseDate('invalid');
        expect(parsed, isNull);
      });
    });

    group('parseDateTime', () {
      test('should parse datetime from string', () {
        final parsed = DateHelper.parseDateTime('2024-01-15 14:30:45');
        expect(parsed, isNotNull);
        expect(parsed?.year, equals(2024));
        expect(parsed?.month, equals(1));
        expect(parsed?.day, equals(15));
        expect(parsed?.hour, equals(14));
        expect(parsed?.minute, equals(30));
        expect(parsed?.second, equals(45));
      });

      test('should return null for invalid datetime string', () {
        final parsed = DateHelper.parseDateTime('invalid');
        expect(parsed, isNull);
      });
    });

    group('toRelativeTime', () {
      test('should return "Just now" for very recent time', () {
        final now = DateTime.now();
        final relative = DateHelper.toRelativeTime(now);
        expect(relative, equals('Just now'));
      });

      test('should return minutes ago', () {
        final past = DateTime.now().subtract(const Duration(minutes: 5));
        final relative = DateHelper.toRelativeTime(past);
        expect(relative, contains('minute'));
      });

      test('should return hours ago', () {
        final past = DateTime.now().subtract(const Duration(hours: 2));
        final relative = DateHelper.toRelativeTime(past);
        expect(relative, contains('hour'));
      });

      test('should return days ago', () {
        final past = DateTime.now().subtract(const Duration(days: 3));
        final relative = DateHelper.toRelativeTime(past);
        expect(relative, contains('day'));
      });
    });

    group('toReadableDate', () {
      test('should format to readable date', () {
        final date = DateTime(2024, 1, 15);
        final readable = DateHelper.toReadableDate(date);
        expect(readable, contains('Jan'));
        expect(readable, contains('15'));
        expect(readable, contains('2024'));
      });
    });

    group('toShortDate', () {
      test('should format to short date', () {
        final date = DateTime(2024, 1, 15);
        final short = DateHelper.toShortDate(date);
        expect(short, equals('01/15/2024'));
      });
    });

    group('toIsoString', () {
      test('should convert to ISO string', () {
        final date = DateTime(2024, 1, 15, 14, 30, 45);
        final iso = DateHelper.toIsoString(date);
        expect(iso, contains('2024'));
        expect(iso, contains('01'));
        expect(iso, contains('15'));
      });
    });

    group('parseIsoString', () {
      test('should parse ISO string', () {
        const iso = '2024-01-15T14:30:45.000Z';
        final parsed = DateHelper.parseIsoString(iso);
        expect(parsed, isNotNull);
        expect(parsed?.year, equals(2024));
      });

      test('should return null for invalid ISO string', () {
        final parsed = DateHelper.parseIsoString('invalid');
        expect(parsed, isNull);
      });
    });

    group('startOfDay', () {
      test('should return start of day', () {
        final date = DateTime(2024, 1, 15, 14, 30, 45);
        final start = DateHelper.startOfDay(date);
        expect(start.hour, equals(0));
        expect(start.minute, equals(0));
        expect(start.second, equals(0));
      });
    });

    group('endOfDay', () {
      test('should return end of day', () {
        final date = DateTime(2024, 1, 15, 14, 30, 45);
        final end = DateHelper.endOfDay(date);
        expect(end.hour, equals(23));
        expect(end.minute, equals(59));
        expect(end.second, equals(59));
      });
    });

    group('startOfWeek', () {
      test('should return start of week (Monday)', () {
        final date = DateTime(2024, 1, 17); // Wednesday
        final start = DateHelper.startOfWeek(date);
        expect(start.weekday, equals(1)); // Monday
      });
    });

    group('endOfWeek', () {
      test('should return end of week (Sunday)', () {
        final date = DateTime(2024, 1, 17); // Wednesday
        final end = DateHelper.endOfWeek(date);
        expect(end.weekday, equals(7)); // Sunday
      });
    });

    group('startOfMonth', () {
      test('should return start of month', () {
        final date = DateTime(2024, 1, 15);
        final start = DateHelper.startOfMonth(date);
        expect(start.day, equals(1));
      });
    });

    group('endOfMonth', () {
      test('should return end of month', () {
        final date = DateTime(2024, 1, 15);
        final end = DateHelper.endOfMonth(date);
        expect(end.day, equals(31)); // January has 31 days
      });
    });

    group('isSameDay', () {
      test('should return true for same day', () {
        final date1 = DateTime(2024, 1, 15, 10);
        final date2 = DateTime(2024, 1, 15, 20);
        expect(DateHelper.isSameDay(date1, date2), isTrue);
      });

      test('should return false for different days', () {
        final date1 = DateTime(2024, 1, 15);
        final date2 = DateTime(2024, 1, 16);
        expect(DateHelper.isSameDay(date1, date2), isFalse);
      });
    });

    group('isSameWeek', () {
      test('should return true for same week', () {
        final date1 = DateTime(2024, 1, 15); // Monday
        final date2 = DateTime(2024, 1, 17); // Wednesday
        expect(DateHelper.isSameWeek(date1, date2), isTrue);
      });
    });

    group('isSameMonth', () {
      test('should return true for same month', () {
        final date1 = DateTime(2024, 1, 15);
        final date2 = DateTime(2024, 1, 20);
        expect(DateHelper.isSameMonth(date1, date2), isTrue);
      });

      test('should return false for different months', () {
        final date1 = DateTime(2024, 1, 15);
        final date2 = DateTime(2024, 2, 15);
        expect(DateHelper.isSameMonth(date1, date2), isFalse);
      });
    });

    group('isSameYear', () {
      test('should return true for same year', () {
        final date1 = DateTime(2024, 1, 15);
        final date2 = DateTime(2024, 12, 31);
        expect(DateHelper.isSameYear(date1, date2), isTrue);
      });

      test('should return false for different years', () {
        final date1 = DateTime(2024, 1, 15);
        final date2 = DateTime(2025, 1, 15);
        expect(DateHelper.isSameYear(date1, date2), isFalse);
      });
    });
  });
}

