/// Constants for Auth feature.
///
/// Contains all text constants and default values for Auth screens
/// to avoid hardcoded strings throughout the feature.
class AuthConstants {
  // Private constructor to prevent instantiation
  AuthConstants._();

  // Screen Titles
  /// Title for phone login mode
  static const String titlePhoneLogin = 'Input WhatsApp Number';

  /// Title for email login mode
  static const String titleEmailLogin = 'Input Active Email';

  // Input Hints
  /// Phone number input hint
  static const String hintPhoneNumber = '8123-4567-8901';

  /// Email input hint
  static const String hintEmail = 'Input email address';

  /// Password input hint
  static const String hintPassword = 'Password';

  // Validation Messages
  /// Error message when terms not accepted
  static const String errorTermsNotAccepted =
      'Please accept the terms and conditions';

  /// Error message when country code not selected
  static const String errorCountryCodeNotSelected =
      'Please select a country code';

  /// Error message when fields are empty
  static const String errorFieldsEmpty = 'Please fill in all fields';

  /// Error message for invalid phone number length
  static const String errorPhoneNumberLength =
      'Phone number must be between 8 and 15 digits';

  // Terms & Conditions
  /// Terms agreement prefix text
  static const String termsAgreementPrefix = "I agree to STP's ";

  /// Terms & Conditions link text
  static const String termsAndConditions = 'Terms & Conditions';

  /// Terms separator text
  static const String termsSeparator = ' and ';

  /// Privacy Policy link text
  static const String privacyPolicy = 'Privacy Policy';

  // Button Labels
  /// Login button text
  static const String buttonLogin = 'Login';

  /// Switch to email login text
  static const String buttonLoginWithEmail = 'Login with Email';

  /// Switch to phone login text
  static const String buttonLoginWithPhone = 'Login with Phone Number';

  // Separators
  /// Separator text between login methods
  static const String separatorOr = 'Or';

  // Default Values
  /// Default country code (Indonesia)
  static const String defaultCountryCode = 'ID';

  // Phone Validation
  /// Minimum phone number digits
  static const int phoneMinDigits = 8;

  /// Maximum phone number digits
  static const int phoneMaxDigits = 15;

  // Data Source Error Messages
  /// Error message when phone number and password are required
  static const String errorPhoneNumberAndPasswordRequired =
      'Phone number and password are required';

  /// Error message when email and password are required
  static const String errorEmailAndPasswordRequired =
      'Email and password are required';

  /// Error message for invalid email format
  static const String errorInvalidEmailFormat = 'Invalid email format';

  /// Error message when failed to get country codes
  static const String errorFailedToGetCountryCodes =
      'Failed to get country codes';

  /// Error message when login failed
  static const String errorLoginFailed = 'Login failed';
}
