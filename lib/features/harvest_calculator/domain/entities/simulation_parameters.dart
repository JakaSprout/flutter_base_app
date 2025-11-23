import 'package:freezed_annotation/freezed_annotation.dart';

part 'simulation_parameters.freezed.dart';
part 'simulation_parameters.g.dart';

/// Domain entity representing input parameters for harvest simulation calculations.
@freezed
class SimulationParameters with _$SimulationParameters {
  const factory SimulationParameters({
    /// Pond area in square meters (m²)
    required double pondArea,

    /// Initial stocking density (individuals per m²)
    required double stockingDensity,

    /// Initial weight in grams (g)
    required double initialWeight,

    /// Target Survival Rate percentage (0-100)
    required double targetSR,

    /// Target harvest weight in grams (g)
    required double targetHarvestWeight,

    /// Estimated Feed Conversion Ratio
    required double estimatedFCR,

    /// Target Day of Culture (days)
    required int targetDOC,

    /// Estimated Average Daily Gain in grams per day (g/day)
    required double estimatedADG,

    /// Daily loss percentage (0-100)
    required double dailyLossPercentage,

    /// Maximum capacity per square meter (kg/m²)
    required double capacityKgPerM2,

    /// Maximum capacity per pond (kg/pond)
    required double capacityKgPerPond,

    /// Commodity selling price per kg
    required double sellingPricePerKg,

    /// Feed price per kg
    required double feedPricePerKg,

    /// Feeding rate percentage (biomass/day)
    required double feedingRatePercentage,

    /// List of harvest events (partial harvests)
    required List<HarvestEvent> harvestEvents,

    /// Current Day of Culture (for mid cycle, starts simulation from this day)
    int? currentDOC,

    /// Simulation type ('cycle' or 'agent')
    String? simulationType,

    // Agent-specific parameters
    /// Current biomass in kg (agent mode only)
    double? currentBiomass,

    /// Stocking count in individuals (agent mode only)
    double? stocking,

    /// Estimated harvest yield in kg (agent mode only)
    double? estimatedHarvestYield,

    /// Total feed payment obligation in currency (agent mode only)
    double? totalFeedPaymentObligation,

    /// Harvest purchase price per kg (agent mode only)
    double? harvestPurchasePrice,
  }) = _SimulationParameters;

  factory SimulationParameters.fromJson(Map<String, dynamic> json) =>
      _$SimulationParametersFromJson(json);
}

/// Domain entity representing a harvest event in the simulation.
@freezed
class HarvestEvent with _$HarvestEvent {
  const factory HarvestEvent({
    /// Day of Culture when harvest occurs
    required int doc,

    /// Harvest percentage (0-100)
    required double percentage,

    /// Optional description of the harvest event
    String? description,
  }) = _HarvestEvent;

  factory HarvestEvent.fromJson(Map<String, dynamic> json) =>
      _$HarvestEventFromJson(json);
}

