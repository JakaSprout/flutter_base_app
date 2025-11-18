/// Anamnesa type entity (domain layer).
///
/// Represents the type of anamnesa for lab request.
enum AnamnesaType {
  /// Diagnostic anamnesa
  diagnostik,

  /// Screening anamnesa
  screening;

  /// Get display name for the anamnesa type
  String get displayName {
    switch (this) {
      case AnamnesaType.diagnostik:
        return 'Diagnostik';
      case AnamnesaType.screening:
        return 'Screening';
    }
  }
}

