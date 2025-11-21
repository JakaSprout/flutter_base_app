import 'package:app_mobile_afms/features/home/domain/entities/pond_entity.dart';

/// Home data entity (domain layer).
///
/// This represents the home screen data in the domain layer.
/// It's a pure business object without any framework dependencies.
class HomeData {
  /// Creates a new instance of [HomeData].
  const HomeData({
    required this.activePonds,
    required this.estimasiBiomassa,
    required this.totalPakan,
    required this.biayaPakan,
    required this.estimasiSR,
    required this.ponds,
    required this.companies,
    this.selectedCompany,
  });

  /// Number of active ponds
  final int activePonds;

  /// Estimasi Biomassa value
  final String estimasiBiomassa;

  /// Total Pakan value
  final String totalPakan;

  /// Biaya Pakan value
  final String biayaPakan;

  /// Estimasi SR value
  final String estimasiSR;

  /// List of ponds
  final List<PondEntity> ponds;

  /// List of available companies
  final List<String> companies;

  /// Currently selected company (optional)
  final String? selectedCompany;
}
