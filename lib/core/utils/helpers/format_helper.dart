import 'package:intl/intl.dart';

/// Helper functions for data formatting.
class FormatHelper {
  // Private constructor to prevent instantiation
  FormatHelper._();

  /// Format number with thousand separator.
  static String formatNumber(num number, {int decimals = 0}) {
    final pattern = decimals > 0 ? '#,##0.${'0' * decimals}' : '#,##0';
    final formatter = NumberFormat(pattern);
    return formatter.format(number);
  }

  /// Format currency.
  static String formatCurrency(
    num amount, {
    String symbol = 'Rp',
    int decimals = 0,
    String? locale,
  }) {
    final formatter = NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimals,
      locale: locale,
    );
    return formatter.format(amount);
  }

  /// Format percentage.
  static String formatPercentage(
    num value, {
    int decimals = 2,
  }) {
    final formatter = NumberFormat('#,##0.${'0' * decimals}%');
    return formatter.format(value / 100);
  }

  /// Format file size (bytes to human readable).
  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    }
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} KB';
    }
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  /// Format duration to human readable string.
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}m ${seconds}s';
    }
    if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    }
    return '${seconds}s';
  }

  /// Format phone number with mask.
  static String formatPhoneNumber(
    String phone, {
    String mask = 'XXX-XXXX-XXXX',
  }) {
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return phone;

    final maskChars = mask.split('');
    var digitIndex = 0;
    final result = <String>[];

    for (var i = 0; i < maskChars.length; i++) {
      if (maskChars[i] == 'X' && digitIndex < digits.length) {
        result.add(digits[digitIndex]);
        digitIndex++;
      } else {
        result.add(maskChars[i]);
      }
    }

    return result.join();
  }

  /// Format credit card number with mask.
  static String formatCreditCard(String cardNumber) {
    final digits = cardNumber.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 4) return cardNumber;

    final last4 = digits.substring(digits.length - 4);
    return '**** **** **** $last4';
  }

  /// Truncate text with ellipsis.
  static String truncate(
    String text,
    int maxLength, {
    String ellipsis = '...',
  }) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}$ellipsis';
  }

  /// Capitalize first letter.
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return '${text[0].toUpperCase()}${text.substring(1)}';
  }

  /// Convert to title case.
  static String toTitleCase(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map(capitalize).join(' ');
  }

  /// Remove all whitespace.
  static String removeWhitespace(String text) {
    return text.replaceAll(RegExp(r'\s+'), '');
  }

  /// Mask sensitive string.
  static String maskString(
    String text, {
    int visibleStart = 2,
    int visibleEnd = 2,
    String maskChar = '*',
  }) {
    if (text.length <= visibleStart + visibleEnd) return text;
    final masked = maskChar * (text.length - visibleStart - visibleEnd);
    return '${text.substring(0, visibleStart)}$masked'
        '${text.substring(text.length - visibleEnd)}';
  }

  /// Format bytes to hex string.
  static String bytesToHex(List<int> bytes) {
    return bytes
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();
  }

  /// Parse hex string to bytes.
  static List<int> hexToBytes(String hex) {
    final bytes = <int>[];
    for (var i = 0; i < hex.length; i += 2) {
      bytes.add(int.parse(hex.substring(i, i + 2), radix: 16));
    }
    return bytes;
  }
}
