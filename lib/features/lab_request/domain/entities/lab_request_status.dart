/// Enum representing the status of a lab request.
enum LabRequestStatus {
  /// Request has been sent/submitted
  dikirim('Dikirim'),

  /// Request is being processed
  diproses('Diproses'),

  /// Request has been completed/finished
  selesai('Selesai'),

  /// Request has been rejected/declined
  ditolak('Ditolak');

  /// Creates a new instance of [LabRequestStatus].
  const LabRequestStatus(this.displayName);

  /// Display name for the status
  final String displayName;

  /// Get the status from string value
  static LabRequestStatus? fromString(String? value) {
    if (value == null) return null;

    switch (value.toLowerCase()) {
      case 'dikirim':
        return LabRequestStatus.dikirim;
      case 'diproses':
        return LabRequestStatus.diproses;
      case 'selesai':
        return LabRequestStatus.selesai;
      case 'ditolak':
        return LabRequestStatus.ditolak;
      default:
        return null;
    }
  }

  /// Convert status to string for API/storage
  String toJson() => name;

  /// Get color for status display
  String get color {
    switch (this) {
      case LabRequestStatus.dikirim:
        return '#007AFF'; // Blue
      case LabRequestStatus.diproses:
        return '#FF9500'; // Orange
      case LabRequestStatus.selesai:
        return '#34C759'; // Green
      case LabRequestStatus.ditolak:
        return '#FF3B30'; // Red
    }
  }

  /// Get background color for status badge
  String get backgroundColor {
    switch (this) {
      case LabRequestStatus.dikirim:
        return '#E3F2FD'; // Light blue
      case LabRequestStatus.diproses:
        return '#FFF3E0'; // Light orange
      case LabRequestStatus.selesai:
        return '#E8F5E8'; // Light green
      case LabRequestStatus.ditolak:
        return '#FFEBEE'; // Light red
    }
  }
}





