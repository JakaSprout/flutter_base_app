import 'package:intl/intl.dart';

/// Helper functions for date formatting and parsing.
class DateHelper {
  // Private constructor to prevent instantiation
  DateHelper._();

  /// Default date format: yyyy-MM-dd
  static const String defaultDateFormat = 'yyyy-MM-dd';

  /// Default time format: HH:mm:ss
  static const String defaultTimeFormat = 'HH:mm:ss';

  /// Default datetime format: yyyy-MM-dd HH:mm:ss
  static const String defaultDateTimeFormat = 'yyyy-MM-dd HH:mm:ss';

  /// Format date to string.
  static String formatDate(
    DateTime date, {
    String format = defaultDateFormat,
    String? locale,
  }) {
    final formatter = DateFormat(format, locale);
    return formatter.format(date);
  }

  /// Format time to string.
  static String formatTime(
    DateTime date, {
    String format = defaultTimeFormat,
    String? locale,
  }) {
    final formatter = DateFormat(format, locale);
    return formatter.format(date);
  }

  /// Format datetime to string.
  static String formatDateTime(
    DateTime date, {
    String format = defaultDateTimeFormat,
    String? locale,
  }) {
    final formatter = DateFormat(format, locale);
    return formatter.format(date);
  }

  /// Parse date from string.
  static DateTime? parseDate(
    String dateString, {
    String format = defaultDateFormat,
  }) {
    try {
      final formatter = DateFormat(format);
      return formatter.parse(dateString);
    } catch (_) {
      return null;
    }
  }

  /// Parse datetime from string.
  static DateTime? parseDateTime(
    String dateString, {
    String format = defaultDateTimeFormat,
  }) {
    try {
      final formatter = DateFormat(format);
      return formatter.parse(dateString);
    } catch (_) {
      return null;
    }
  }

  /// Format date to relative time (e.g., "2 hours ago", "yesterday").
  static String toRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      final yearText = years == 1 ? 'year' : 'years';
      return '$years $yearText ago';
    }
    if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      final monthText = months == 1 ? 'month' : 'months';
      return '$months $monthText ago';
    }
    if (difference.inDays > 0) {
      final days = difference.inDays;
      final dayText = days == 1 ? 'day' : 'days';
      return '$days $dayText ago';
    }
    if (difference.inHours > 0) {
      final hours = difference.inHours;
      final hourText = hours == 1 ? 'hour' : 'hours';
      return '$hours $hourText ago';
    }
    if (difference.inMinutes > 0) {
      final minutes = difference.inMinutes;
      final minuteText = minutes == 1 ? 'minute' : 'minutes';
      return '$minutes $minuteText ago';
    }
    return 'Just now';
  }

  /// Format date to readable format (e.g., "Jan 15, 2024").
  static String toReadableDate(DateTime date, {String? locale}) {
    return formatDate(date, format: 'MMM dd, yyyy', locale: locale);
  }

  /// Format date to short format (e.g., "01/15/2024").
  static String toShortDate(DateTime date) {
    return formatDate(date, format: 'MM/dd/yyyy');
  }

  /// Format date to ISO 8601 string.
  static String toIsoString(DateTime date) {
    return date.toIso8601String();
  }

  /// Parse ISO 8601 string to DateTime.
  static DateTime? parseIsoString(String isoString) {
    try {
      return DateTime.parse(isoString);
    } catch (_) {
      return null;
    }
  }

  /// Get start of day.
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Get end of day.
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  /// Get start of week (Monday).
  static DateTime startOfWeek(DateTime date) {
    final weekday = date.weekday;
    return startOfDay(date.subtract(Duration(days: weekday - 1)));
  }

  /// Get end of week (Sunday).
  static DateTime endOfWeek(DateTime date) {
    final weekday = date.weekday;
    return endOfDay(date.add(Duration(days: 7 - weekday)));
  }

  /// Get start of month.
  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month);
  }

  /// Get end of month.
  static DateTime endOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0, 23, 59, 59, 999);
  }

  /// Check if date is in same day.
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// Check if date is in same week.
  static bool isSameWeek(DateTime date1, DateTime date2) {
    final start1 = startOfWeek(date1);
    final start2 = startOfWeek(date2);
    return isSameDay(start1, start2);
  }

  /// Check if date is in same month.
  static bool isSameMonth(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month;
  }

  /// Check if date is in same year.
  static bool isSameYear(DateTime date1, DateTime date2) {
    return date1.year == date2.year;
  }
}
