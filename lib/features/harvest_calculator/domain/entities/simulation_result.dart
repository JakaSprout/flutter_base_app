import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/daily_simulation_result.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/harvest_summary.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/simulation_metrics.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/simulation_summary.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'simulation_result.freezed.dart';
part 'simulation_result.g.dart';

/// Domain entity representing the complete results of a harvest simulation.
@freezed
class SimulationResult with _$SimulationResult {
  const factory SimulationResult({
    /// All daily results from DOC 1 to target DOC
    required List<DailySimulationResult> dailyResults,

    /// Summary statistics
    required SimulationSummary summary,

    /// Harvest events that occurred during simulation
    required List<HarvestSummary> harvestSummaries,

    /// Performance metrics
    required SimulationMetrics metrics,

    /// DOC when automatic first harvest occurred (null if no automatic harvest)
    int? automaticHarvestDoc,
  }) = _SimulationResult;

  factory SimulationResult.fromJson(Map<String, dynamic> json) =>
      _$SimulationResultFromJson(json);
}
