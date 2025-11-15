/// Country code entity (domain layer).
///
/// Represents a country code for phone number input.
class CountryCode {
  /// Creates a new instance of [CountryCode].
  const CountryCode({
    required this.code,
    required this.dialCode,
    required this.name,
    this.flag,
  });

  /// ISO country code (e.g., 'ID', 'US')
  final String code;

  /// International dial code (e.g., '+62', '+1')
  final String dialCode;

  /// Country name (e.g., 'Indonesia', 'United States')
  final String name;

  /// Optional flag emoji or asset path
  final String? flag;
}


