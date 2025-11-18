/// Constants for Lab Request feature.
///
/// Contains all text constants for Lab Request screens
/// to avoid hardcoded strings throughout the feature.
class LabRequestConstants {
  // Private constructor to prevent instantiation
  LabRequestConstants._();

  // Screen Titles
  /// Title for lab request list screen
  static const String screenTitle = 'Permintaan Analisis Lab';

  /// Title for lab request form screen
  static const String formTitle = 'Request Form';

  // Form Fields
  /// Label for sender name field
  static const String fieldNamaPengirim = 'Nama Pengirim';

  /// Label for phone number field
  static const String fieldNoTelp = 'No. Telp';

  /// Label for email field
  static const String fieldEmail = 'Email';

  /// Label for origin pond field
  static const String fieldTambakAsal = 'Tambak Asal';

  /// Label for customer field
  static const String fieldCustomer = 'Customer';

  /// Label for delivery/pickup date field
  static const String fieldTanggalPengiriman = 'Tanggal Pengiriman/Pengambilan';

  /// Label for anamnesa field
  static const String fieldAnamnesa = 'Anamnesa';

  /// Label for sample description field
  static const String fieldKeteranganSampel = 'Keterangan Sampel';

  /// Label for testing type field
  static const String fieldJenisTesting = 'Jenis Testing';

  // Form Hints
  /// Hint for sender name field
  static const String hintNamaPengirim = 'Input nama pengirim';

  /// Hint for phone number field
  static const String hintNoTelp = 'Input nomor telepon';

  /// Hint for email field
  static const String hintEmail = 'Input email address';

  /// Hint for origin pond field
  static const String hintTambakAsal = 'Pilih tambak asal';

  /// Hint for customer field
  static const String hintCustomer = 'Pilih customer';

  /// Hint for sample description field
  static const String hintKeteranganSampel = 'Input keterangan sampel';

  // Buttons
  /// Submit button text
  static const String buttonSubmit = 'Konfirmasi';

  /// Next button text
  static const String buttonNext = 'Next';

  /// Create new request button text
  static const String buttonNewRequest = 'Request Baru';

  // List Screen
  /// Empty state message
  static const String emptyStateMessage = 'Belum ada request yang dikirim';

  /// Filter label
  static const String filterLabel = 'Filter';

  /// Request date label
  static const String filterTanggalRequest = 'Tanggal Request';

  /// Filter "to" label
  static const String filterTo = 's/d';

  // Validation Messages
  /// Error message when field is required
  static const String errorRequired = 'Field ini wajib diisi';

  /// Error message for invalid email
  static const String errorInvalidEmail = 'Format email tidak valid';

  /// Error message for invalid phone
  static const String errorInvalidPhone = 'Format nomor telepon tidak valid';
}
