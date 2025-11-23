import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_simulation_result.freezed.dart';
part 'daily_simulation_result.g.dart';

/// Domain entity representing calculation results for a single day in the simulation.
@freezed
class DailySimulationResult with _$DailySimulationResult {
  const factory DailySimulationResult({
    /// Day of Culture (1-based)
    required int doc,

    /// Weight at the end of this day (grams)
    required double weight,

    /// Population at the end of this day
    required double population,

    /// Biomass at the end of this day (kg)
    required double biomass,

    /// Daily feed consumption (kg)
    required double dailyFeedConsumption,

    /// Cumulative feed consumption up to this day (kg)
    required double cumulativeFeedConsumption,

    /// Potential revenue if harvested at this point (Rp)
    required double potentialRevenue,

    /// Cumulative feed cost up to this day (Rp)
    required double cumulativeFeedCost,

    /// Potential profit if harvested at this point (Rp)
    required double potentialProfit,

    /// Survival Rate at this point (%)
    required double survivalRate,

    /// Feed Conversion Ratio at this point
    required double fcr,

    /// Average Daily Gain (g/day) - calculated from weight change
    required double adg,

    /// Whether this day includes a harvest event
    @Default(false) bool hasHarvest,

    /// Harvest amount if applicable (kg)
    double? harvestAmount,

    /// Population reduction due to harvest
    double? harvestPopulationReduction,
  }) = _DailySimulationResult;

  factory DailySimulationResult.fromJson(Map<String, dynamic> json) =>
      _$DailySimulationResultFromJson(json);
}

