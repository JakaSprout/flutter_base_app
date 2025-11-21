import 'package:app_mobile_afms/core/utils/extensions/string_extensions.dart';

/// Input validators for form validation.
class InputValidators {
  // Private constructor to prevent instantiation
  InputValidators._();

  /// Validate email format.
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.isValidEmail) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validate required field.
  static String? required(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validate minimum length.
  static String? minLength(
    String? value,
    int minLength, {
    String fieldName = 'Field',
  }) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (value.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }
    return null;
  }

  /// Validate maximum length.
  static String? maxLength(
    String? value,
    int maxLength, {
    String fieldName = 'Field',
  }) {
    if (value == null || value.isEmpty) {
      return null; // Optional field
    }
    if (value.length > maxLength) {
      return '$fieldName must not exceed $maxLength characters';
    }
    return null;
  }

  /// Validate length range.
  static String? lengthRange(
    String? value,
    int minLength,
    int maxLength, {
    String fieldName = 'Field',
  }) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (value.length < minLength || value.length > maxLength) {
      return '$fieldName must be between $minLength and $maxLength characters';
    }
    return null;
  }

  /// Validate phone number format.
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    // Remove all non-digit characters for validation
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length < 10 || digitsOnly.length > 15) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  /// Validate URL format.
  static String? url(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL is required';
    }
    if (!value.isValidUrl) {
      return 'Please enter a valid URL';
    }
    return null;
  }

  /// Validate password strength.
  static String? password(String? value, {int minLength = 8}) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }
    // Check for at least one uppercase letter
    if (!value.contains(RegExp('[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    // Check for at least one lowercase letter
    if (!value.contains(RegExp('[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    // Check for at least one digit
    if (!value.contains(RegExp('[0-9]'))) {
      return 'Password must contain at least one number';
    }
    return null;
  }

  /// Validate password confirmation.
  static String? passwordConfirmation(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Password confirmation is required';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Validate numeric value.
  static String? numeric(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (double.tryParse(value) == null) {
      return '$fieldName must be a valid number';
    }
    return null;
  }

  /// Validate integer value.
  static String? integer(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (int.tryParse(value) == null) {
      return '$fieldName must be a valid integer';
    }
    return null;
  }

  /// Validate positive number.
  static String? positiveNumber(String? value, {String fieldName = 'Field'}) {
    final numericError = numeric(value, fieldName: fieldName);
    if (numericError != null) return numericError;
    final num = double.parse(value!);
    if (num <= 0) {
      return '$fieldName must be greater than 0';
    }
    return null;
  }

  /// Validate date format.
  static String? date(String? value, {String fieldName = 'Date'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    try {
      DateTime.parse(value);
      return null;
    } catch (_) {
      return 'Please enter a valid date';
    }
  }

  /// Combine multiple validators.
  static String? combine(
    List<String? Function(String?)> validators,
    String? value,
  ) {
    for (final validator in validators) {
      final error = validator(value);
      if (error != null) return error;
    }
    return null;
  }
}
