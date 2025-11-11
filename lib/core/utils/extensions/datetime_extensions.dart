/// Extensions for DateTime operations.
extension DateTimeExtensions on DateTime {
  /// Check if date is today.
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if date is yesterday.
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Check if date is tomorrow.
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Check if date is in the past.
  bool get isPast => isBefore(DateTime.now());

  /// Check if date is in the future.
  bool get isFuture => isAfter(DateTime.now());

  /// Get start of day (00:00:00).
  DateTime get startOfDay => DateTime(year, month, day);

  /// Get end of day (23:59:59.999).
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  /// Get start of week (Monday).
  DateTime get startOfWeek {
    final weekday = this.weekday;
    return subtract(Duration(days: weekday - 1)).startOfDay;
  }

  /// Get end of week (Sunday).
  DateTime get endOfWeek {
    final weekday = this.weekday;
    return add(Duration(days: 7 - weekday)).endOfDay;
  }

  /// Get start of month.
  DateTime get startOfMonth => DateTime(year, month);

  /// Get end of month.
  DateTime get endOfMonth => DateTime(year, month + 1, 0, 23, 59, 59, 999);

  /// Get start of year.
  DateTime get startOfYear => DateTime(year);

  /// Get end of year.
  DateTime get endOfYear => DateTime(year, 12, 31, 23, 59, 59, 999);

  /// Get age in years.
  int get age {
    final now = DateTime.now();
    var years = now.year - year;
    if (now.month < month || (now.month == month && now.day < day)) {
      years--;
    }
    return years;
  }

  /// Get difference in days from now.
  int get daysDifference {
    return DateTime.now().difference(this).inDays;
  }

  /// Format date to ISO string.
  String toIsoString() => toIso8601String();

  /// Format date to readable string.
  String toReadableString() {
    if (isToday) {
      return 'Today';
    }
    if (isYesterday) {
      return 'Yesterday';
    }
    if (isTomorrow) {
      return 'Tomorrow';
    }
    return '$day/$month/$year';
  }
}

/// Extensions for nullable DateTime operations.
extension NullableDateTimeExtensions on DateTime? {
  /// Check if date is null or in the past.
  bool get isNullOrPast => this == null || this!.isPast;

  /// Check if date is not null and in the future.
  bool get isNotNullAndFuture => this != null && this!.isFuture;
}
