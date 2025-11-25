/// Constants for Lab Request Info screen.
///
/// Contains all text constants for the information screen
/// to avoid hardcoded strings.
class LabRequestInfoConstants {
  // Private constructor to prevent instantiation
  LabRequestInfoConstants._();

  // Screen Title
  /// Title for lab request info screen
  static const String screenTitle = 'Permintaan Tes Lab';

  // Section Titles
  /// Title for procedure section
  static const String sectionTitleProcedure = 'Tentang Prosedur Ini';

  /// Title for test types section
  static const String sectionTitleTestTypes = 'Meliputi 4 Tes';

  // Procedure Description
  /// First paragraph of procedure description
  static const String procedureDescriptionPara1 =
      'Laboratorium akan menerima data dan sampel yang terkait. '
      'Tim lab kemudian akan melakukan pemeriksaan sesuai jenis '
      'testing yang dipilih, seperti PCR atau uji kualitas air.';

  /// Second paragraph of procedure description
  static const String procedureDescriptionPara2 =
      'Sampel akan dianalisis untuk mendeteksi keberadaan '
      'penyakit, kondisi lingkungan, atau kualitas air berdasarkan '
      'permintaan. Hasil analisis ini digunakan untuk membantu '
      'penanganan masalah kesehatan ikan/udang atau kondisi '
      'Farm secara akurat.';

  // Test Types (from TestingType enum)
  /// PCR Konvensional test type label
  static const String testTypePcrKonvensional = 'PCR Konvensional';

  /// PCR Realtime test type label
  static const String testTypePcrRealtime = 'PCR Realtime';

  /// PCR Pockit test type label
  static const String testTypePcrPockit = 'PCR Pockit';

  /// Water Quality test type label
  static const String testTypeKualitasAir = 'Kualitas Air';

  // Button
  /// Start button text
  static const String buttonStart = 'Mulai';
}
