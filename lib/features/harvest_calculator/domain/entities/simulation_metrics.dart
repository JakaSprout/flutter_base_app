import 'package:freezed_annotation/freezed_annotation.dart';

part 'simulation_metrics.freezed.dart';
part 'simulation_metrics.g.dart';

/// Performance metrics of the simulation
@freezed
class SimulationMetrics with _$SimulationMetrics {
  const factory SimulationMetrics({
    /// Peak biomass reached (kg)
    required double peakBiomass,

    /// Day when peak biomass was reached
    required int peakBiomassDay,

    /// Average daily feed consumption (kg/day)
    required double averageDailyFeedConsumption,

    /// Feed efficiency (revenue per kg feed)
    required double feedEfficiency,

    /// Biomass growth rate (kg/day)
    required double biomassGrowthRate,

    /// Days to reach 50% of target biomass
    required int daysToHalfBiomass,

    /// Days to reach 80% of target biomass
    required int daysToFourFifthBiomass,
  }) = _SimulationMetrics;

  factory SimulationMetrics.fromJson(Map<String, dynamic> json) =>
      _$SimulationMetricsFromJson(json);
}

