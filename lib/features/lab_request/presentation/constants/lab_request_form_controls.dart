/// Form control names for lab request form.
///
/// Centralizes all form control identifiers used in reactive forms.
/// Pattern follows harvest_calculator/presentation/constants/harvest_calculator_form_controls.dart
class LabRequestFormControls {
  const LabRequestFormControls._();

  // Farm Information Section
  /// Selected farm control name
  static const String selectedFarm = 'selectedFarm';

  /// Tanggal kirim (send date) control name
  static const String sendDate = 'sendDate';

  // Sample Section
  /// List of samples control name
  static const String samples = 'samples';

  // Sender Information (if needed later)
  /// Sender name control name
  static const String senderName = 'senderName';

  /// Sender phone control name
  static const String senderPhone = 'senderPhone';

  /// Sender email control name
  static const String senderEmail = 'senderEmail';

  // Additional Fields (moved to separate screen per design)
  /// Customer control name
  static const String customer = 'customer';

  /// Anamnesa control name
  static const String anamnesa = 'anamnesa';

  /// Sample description control name
  static const String sampleDescription = 'sampleDescription';

  /// Testing type control name
  static const String testingType = 'testingType';
}
