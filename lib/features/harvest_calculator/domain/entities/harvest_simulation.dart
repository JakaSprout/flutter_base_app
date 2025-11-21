import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/simulation_chart_data.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/simulation_table_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'harvest_simulation.freezed.dart';
part 'harvest_simulation.g.dart';

/// Domain entity representing a harvest simulation.
@freezed
class HarvestSimulation with _$HarvestSimulation {
  const factory HarvestSimulation({
    required String id,
    required String name,
    required DateTime createdAt,
    required String commodity,
    required String cultivationSystem,
    required double pondArea,
    required double targetHarvest,
    required double estimatedADG,
    required int targetDOC,
    required double targetSR,
    required double estimatedFCR,
    required double targetBiomass,
    required double sellingPrice,
    required double feedPrice,
    required String cycleType,
    required double? currentDOC,
    required SimulationResults results,
  }) = _HarvestSimulation;

  factory HarvestSimulation.fromJson(Map<String, dynamic> json) =>
      _$HarvestSimulationFromJson(json);
}

/// Domain entity representing simulation results.
@freezed
class SimulationResults with _$SimulationResults {
  const factory SimulationResults({
    required double potentialRevenue,
    required double potentialFeedCost,
    required double potentialProfit,
    required double biomass,
    required List<BiomassPoint> biomassPoints,
    required List<FeedPoint> feedVsRevenuePoints,
    required List<SimulationTableRow> tableRows,
  }) = _SimulationResults;

  factory SimulationResults.fromJson(Map<String, dynamic> json) =>
      _$SimulationResultsFromJson(json);
}
