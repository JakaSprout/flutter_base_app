/// Testing type entity (domain layer).
///
/// Represents the type of testing for lab request.
enum TestingType {
  /// Conventional PCR
  pcrKonvensional,

  /// Real-time PCR
  pcrRealtime,

  /// Pockit PCR
  pcrPockit,

  /// Water Quality testing
  waterQuality;

  /// Get display name for the testing type
  String get displayName {
    switch (this) {
      case TestingType.pcrKonvensional:
        return 'PCR Konvensional';
      case TestingType.pcrRealtime:
        return 'PCR Realtime';
      case TestingType.pcrPockit:
        return 'PCR Pockit';
      case TestingType.waterQuality:
        return 'Water Quality';
    }
  }
}

