/// Dashboard summary data entity (domain layer).
class DashboardSummaryData {
  /// Creates a new instance of [DashboardSummaryData].
  const DashboardSummaryData({
    required this.activePonds,
    required this.estimasiBiomassa,
    required this.totalPakan,
    required this.biayaPakan,
    required this.estimasiSR,
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
}

