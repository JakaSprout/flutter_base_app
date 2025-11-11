/// Extensions for String operations.
extension StringExtensions on String {
  /// Check if string is null or empty.
  bool get isNullOrEmpty => isEmpty;

  /// Check if string is not null and not empty.
  bool get isNotNullOrEmpty => !isEmpty;

  /// Check if string is a valid email.
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  /// Check if string is a valid URL.
  bool get isValidUrl {
    try {
      final uri = Uri.parse(this);
      return uri.hasScheme && (uri.hasAuthority || uri.path.isNotEmpty);
    } catch (_) {
      return false;
    }
  }

  /// Capitalize first letter of string.
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Convert string to title case.
  String get toTitleCase {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Remove all whitespace from string.
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  /// Truncate string to specified length with ellipsis.
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$ellipsis';
  }

  /// Mask sensitive string (e.g., email, phone).
  String mask({
    int visibleStart = 2,
    int visibleEnd = 2,
    String maskChar = '*',
  }) {
    if (length <= visibleStart + visibleEnd) return this;
    final masked = maskChar * (length - visibleStart - visibleEnd);
    return '${substring(0, visibleStart)}$masked'
        '${substring(length - visibleEnd)}';
  }
}

/// Extensions for nullable String operations.
extension NullableStringExtensions on String? {
  /// Check if string is null or empty.
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Check if string is not null and not empty.
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;

  /// Return empty string if null.
  String get orEmpty => this ?? '';

  /// Return default value if null or empty.
  String orDefault(String defaultValue) => isNullOrEmpty ? defaultValue : this!;
}
