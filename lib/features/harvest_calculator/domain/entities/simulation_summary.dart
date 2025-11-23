import 'package:freezed_annotation/freezed_annotation.dart';

part 'simulation_summary.freezed.dart';
part 'simulation_summary.g.dart';

/// Summary statistics of the simulation
@freezed
class SimulationSummary with _$SimulationSummary {
  const factory SimulationSummary({
    /// Final biomass at target DOC (kg)
    required double finalBiomass,

    /// Total feed consumption (kg)
    required double totalFeedConsumption,

    /// Total revenue from all harvests (Rp)
    required double totalRevenue,

    /// Total feed cost (Rp)
    required double totalFeedCost,

    /// Net profit (Rp)
    required double netProfit,

    /// Final survival rate (%)
    required double finalSurvivalRate,

    /// Average FCR throughout simulation
    required double averageFCR,

    /// Total harvest weight (kg)
    required double totalHarvestWeight,

    /// Simulation duration (days)
    required int simulationDays,
  }) = _SimulationSummary;

  factory SimulationSummary.fromJson(Map<String, dynamic> json) =>
      _$SimulationSummaryFromJson(json);
}

