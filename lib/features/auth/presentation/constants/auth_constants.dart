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
  static const String hintPhoneNumber = '0812-3456-7890';

  /// Email input hint
  static const String hintEmail = 'Input email address';

  /// Password input hint
  static const String hintPassword = 'Password';

  // Validation Messages
  /// Error message when terms not accepted
  static const String errorTermsNotAccepted =
      'Please accept the terms and conditions';

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

  // Phone Validation
  /// Minimum phone number digits
  static const int phoneMinDigits = 8;

  /// Maximum phone number digits
  static const int phoneMaxDigits = 15;

  // Data Source Error Messages
  /// Error message when phone number is required
  static const String errorPhoneNumberRequired = 'Phone number is required';

  /// Error message when email and password are required
  static const String errorEmailAndPasswordRequired =
      'Email and password are required';

  /// Error message for invalid email format
  static const String errorInvalidEmailFormat = 'Invalid email format';

  /// Error message when login failed
  static const String errorLoginFailed = 'Login failed';

  // Timing Constants
  /// Threshold duration before token expiration to trigger refresh
  static const Duration tokenExpirationThreshold = Duration(minutes: 5);

  /// Delay duration for provider invalidation
  static const Duration providerInvalidationDelay = Duration(milliseconds: 100);

  /// Retry delay for session timeout check on error
  static const Duration sessionTimeoutRetryDelay = Duration(minutes: 1);

  /// Default check interval when token expiration info is not available
  static const Duration defaultSessionCheckInterval = Duration(minutes: 5);

  // Loading & Sync Messages
  /// Message shown while reference data is being seeded
  static const String messageSeedingInProgress = 'Menyinkronkan data awal...';

  /// Message shown when seeding completes successfully
  static const String messageSeedingSuccess = 'Data siap digunakan';

  /// Message shown when seeding completes with partial issues
  static const String messageSeedingPartial =
      'Sebagian data belum sinkron. Silakan refresh atau coba lagi.';
}
