import 'package:flutter_base_app/core/utils/extensions/datetime_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DateTimeExtensions', () {
    group('isToday', () {
      test('should return true for today', () {
        final now = DateTime.now();
        expect(now.isToday, isTrue);
      });

      test('should return false for yesterday', () {
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        expect(yesterday.isToday, isFalse);
      });

      test('should return false for tomorrow', () {
        final tomorrow = DateTime.now().add(const Duration(days: 1));
        expect(tomorrow.isToday, isFalse);
      });
    });

    group('isYesterday', () {
      test('should return true for yesterday', () {
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        expect(yesterday.isYesterday, isTrue);
      });

      test('should return false for today', () {
        final now = DateTime.now();
        expect(now.isYesterday, isFalse);
      });
    });

    group('isTomorrow', () {
      test('should return true for tomorrow', () {
        final tomorrow = DateTime.now().add(const Duration(days: 1));
        expect(tomorrow.isTomorrow, isTrue);
      });

      test('should return false for today', () {
        final now = DateTime.now();
        expect(now.isTomorrow, isFalse);
      });
    });

    group('isPast', () {
      test('should return true for past date', () {
        final past = DateTime.now().subtract(const Duration(days: 1));
        expect(past.isPast, isTrue);
      });

      test('should return false for future date', () {
        final future = DateTime.now().add(const Duration(days: 1));
        expect(future.isPast, isFalse);
      });
    });

    group('isFuture', () {
      test('should return true for future date', () {
        final future = DateTime.now().add(const Duration(days: 1));
        expect(future.isFuture, isTrue);
      });

      test('should return false for past date', () {
        final past = DateTime.now().subtract(const Duration(days: 1));
        expect(past.isFuture, isFalse);
      });
    });

    group('startOfDay', () {
      test('should return start of day', () {
        final date = DateTime(2024, 1, 15, 14, 30, 45);
        final start = date.startOfDay;
        expect(start.year, equals(2024));
        expect(start.month, equals(1));
        expect(start.day, equals(15));
        expect(start.hour, equals(0));
        expect(start.minute, equals(0));
        expect(start.second, equals(0));
      });
    });

    group('endOfDay', () {
      test('should return end of day', () {
        final date = DateTime(2024, 1, 15, 14, 30, 45);
        final end = date.endOfDay;
        expect(end.year, equals(2024));
        expect(end.month, equals(1));
        expect(end.day, equals(15));
        expect(end.hour, equals(23));
        expect(end.minute, equals(59));
        expect(end.second, equals(59));
        expect(end.millisecond, equals(999));
      });
    });

    group('startOfWeek', () {
      test('should return start of week (Monday)', () {
        // Assuming Monday is weekday 1
        final date = DateTime(2024, 1, 17); // Wednesday
        final start = date.startOfWeek;
        expect(start.weekday, equals(1)); // Monday
      });
    });

    group('endOfWeek', () {
      test('should return end of week (Sunday)', () {
        final date = DateTime(2024, 1, 17); // Wednesday
        final end = date.endOfWeek;
        expect(end.weekday, equals(7)); // Sunday
      });
    });

    group('startOfMonth', () {
      test('should return start of month', () {
        final date = DateTime(2024, 1, 15);
        final start = date.startOfMonth;
        expect(start.year, equals(2024));
        expect(start.month, equals(1));
        expect(start.day, equals(1));
      });
    });

    group('endOfMonth', () {
      test('should return end of month', () {
        final date = DateTime(2024, 1, 15);
        final end = date.endOfMonth;
        expect(end.year, equals(2024));
        expect(end.month, equals(1));
        expect(end.day, equals(31)); // January has 31 days
      });
    });

    group('startOfYear', () {
      test('should return start of year', () {
        final date = DateTime(2024, 6, 15);
        final start = date.startOfYear;
        expect(start.year, equals(2024));
        expect(start.month, equals(1));
        expect(start.day, equals(1));
      });
    });

    group('endOfYear', () {
      test('should return end of year', () {
        final date = DateTime(2024, 6, 15);
        final end = date.endOfYear;
        expect(end.year, equals(2024));
        expect(end.month, equals(12));
        expect(end.day, equals(31));
      });
    });

    group('age', () {
      test('should calculate age correctly', () {
        final birthDate = DateTime(2000, 1, 1);
        final age = birthDate.age;
        // Age should be approximately current year - 2000
        expect(age, greaterThanOrEqualTo(24));
        expect(age, lessThanOrEqualTo(25));
      });
    });

    group('daysDifference', () {
      test('should calculate days difference from now', () {
        final past = DateTime.now().subtract(const Duration(days: 5));
        expect(past.daysDifference, equals(5));
      });
    });

    group('toIsoString', () {
      test('should convert to ISO string', () {
        final date = DateTime(2024, 1, 15, 14, 30, 45);
        final iso = date.toIsoString();
        expect(iso, contains('2024'));
        expect(iso, contains('01'));
        expect(iso, contains('15'));
      });
    });

    group('toReadableString', () {
      test('should return "Today" for today', () {
        final now = DateTime.now();
        expect(now.toReadableString(), equals('Today'));
      });

      test('should return "Yesterday" for yesterday', () {
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        expect(yesterday.toReadableString(), equals('Yesterday'));
      });

      test('should return "Tomorrow" for tomorrow', () {
        final tomorrow = DateTime.now().add(const Duration(days: 1));
        expect(tomorrow.toReadableString(), equals('Tomorrow'));
      });

      test('should return formatted date for other dates', () {
        final date = DateTime(2024, 1, 15);
        final readable = date.toReadableString();
        expect(readable, contains('15'));
        expect(readable, contains('1'));
        expect(readable, contains('2024'));
      });
    });
  });

  group('NullableDateTimeExtensions', () {
    group('isNullOrPast', () {
      test('should return true for null', () {
        DateTime? date;
        expect(date.isNullOrPast, isTrue);
      });

      test('should return true for past date', () {
        final past = DateTime.now().subtract(const Duration(days: 1));
        expect(past.isNullOrPast, isTrue);
      });

      test('should return false for future date', () {
        final future = DateTime.now().add(const Duration(days: 1));
        expect(future.isNullOrPast, isFalse);
      });
    });

    group('isNotNullAndFuture', () {
      test('should return false for null', () {
        DateTime? date;
        expect(date.isNotNullAndFuture, isFalse);
      });

      test('should return true for future date', () {
        final future = DateTime.now().add(const Duration(days: 1));
        expect(future.isNotNullAndFuture, isTrue);
      });

      test('should return false for past date', () {
        final past = DateTime.now().subtract(const Duration(days: 1));
        expect(past.isNotNullAndFuture, isFalse);
      });
    });
  });
}

