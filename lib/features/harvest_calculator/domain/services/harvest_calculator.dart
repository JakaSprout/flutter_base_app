import 'package:app_mobile_afms/features/harvest_calculator/domain/services/calculation_constants.dart';

/// Service for calculating harvest events and partial harvesting logic in simulation.
///
/// This service handles:
/// - Partial harvest calculations at specific DOC
/// - Population adjustments after harvest
/// - Harvest event scheduling
/// - Final harvest calculations
class HarvestCalculator {
  const HarvestCalculator._();

  /// Calculates harvest amount based on current biomass and harvest percentage.
  ///
  /// Formula: harvest_amount = current_biomass × harvest_percentage / percentageFactor
  ///
  /// [currentBiomass]: Current biomass in kg
  /// [harvestPercentage]: Harvest percentage (0-100)
  /// Returns harvest amount in kg
  static double calculateHarvestAmount(
    double currentBiomass,
    double harvestPercentage,
  ) {
    return CalculationConstants.applyPercentage(
      currentBiomass,
      harvestPercentage,
    );
  }

  /// Calculates remaining biomass after harvest.
  ///
  /// Formula: remaining_biomass = current_biomass - harvest_amount
  ///
  /// [currentBiomass]: Current biomass before harvest
  /// [harvestAmount]: Amount being harvested
  /// Returns remaining biomass in kg
  static double calculateRemainingBiomass(
    double currentBiomass,
    double harvestAmount,
  ) {
    return currentBiomass - harvestAmount;
  }

  /// Calculates population reduction after harvest.
  ///
  /// Formula: population_reduction = current_population × harvest_percentage / percentageFactor
  ///
  /// [currentPopulation]: Current population before harvest
  /// [harvestPercentage]: Harvest percentage (0-100)
  /// Returns population reduction
  static double calculatePopulationReduction(
    double currentPopulation,
    double harvestPercentage,
  ) {
    return CalculationConstants.applyPercentage(
      currentPopulation,
      harvestPercentage,
    );
  }

  /// Calculates remaining population after harvest.
  ///
  /// Formula: remaining_population = current_population - population_reduction
  ///
  /// [currentPopulation]: Current population before harvest
  /// [populationReduction]: Population being harvested
  /// Returns remaining population
  static double calculateRemainingPopulation(
    double currentPopulation,
    double populationReduction,
  ) {
    return currentPopulation - populationReduction;
  }

  /// Calculates final harvest amount (panen raya).
  ///
  /// Formula: final_harvest = remaining_biomass_at_target_doc
  ///
  /// [remainingBiomass]: Biomass remaining at target DOC
  /// Returns final harvest amount in kg
  static double calculateFinalHarvest(double remainingBiomass) {
    return remainingBiomass;
  }

  /// Validates if harvest percentage is within acceptable range.
  ///
  /// [harvestPercentage]: Harvest percentage to validate
  /// [minPercentage]: Minimum allowed percentage (default: minPercentage)
  /// [maxPercentage]: Maximum allowed percentage (default: maxPercentage)
  /// Returns true if valid, false otherwise
  static bool isValidHarvestPercentage(
    double harvestPercentage, {
    double minPercentage = CalculationConstants.minPercentage,
    double maxPercentage = CalculationConstants.maxPercentage,
  }) {
    return harvestPercentage >= minPercentage &&
        harvestPercentage <= maxPercentage;
  }

  /// Calculates total harvested biomass from all harvest events.
  ///
  /// Formula: total_harvested = Σ(harvest_amounts)
  ///
  /// [harvestAmounts]: List of harvest amounts from each event
  /// Returns total harvested biomass in kg
  static double calculateTotalHarvested(List<double> harvestAmounts) {
    return CalculationConstants.sumList(harvestAmounts);
  }

  /// Calculates harvest efficiency (percentage of target biomass achieved).
  ///
  /// Formula: efficiency(%) = (total_harvested / target_biomass) × percentageFactor
  ///
  /// [totalHarvested]: Total biomass harvested
  /// [targetBiomass]: Target biomass to achieve
  /// Returns harvest efficiency percentage
  static double calculateHarvestEfficiency(
    double totalHarvested,
    double targetBiomass,
  ) {
    final efficiencyRatio = CalculationConstants.safeDivide(
      totalHarvested,
      targetBiomass,
    );
    return efficiencyRatio * CalculationConstants.percentageFactor;
  }

  /// Calculates days between harvests.
  ///
  /// [currentDoc]: Current day of culture
  /// [previousHarvestDoc]: Previous harvest day of culture
  /// Returns days between harvests
  static int calculateDaysBetweenHarvests(
    int currentDoc,
    int previousHarvestDoc,
  ) {
    return currentDoc - previousHarvestDoc;
  }

  /// Validates harvest timing (should not harvest too frequently).
  ///
  /// [currentDoc]: Current day of culture
  /// [lastHarvestDoc]: Last harvest day of culture
  /// [minDaysBetweenHarvests]: Minimum days required between harvests
  /// Returns true if timing is valid
  static bool isValidHarvestTiming(
    int currentDoc,
    int lastHarvestDoc,
    int minDaysBetweenHarvests,
  ) {
    final daysSinceLastHarvest = currentDoc - lastHarvestDoc;
    return daysSinceLastHarvest >= minDaysBetweenHarvests;
  }

  /// Calculates biomass recovery rate after partial harvest.
  ///
  /// Formula: recovery_rate = remaining_biomass_after_recovery_period / remaining_biomass_after_harvest
  ///
  /// [biomassAfterRecovery]: Biomass after recovery period
  /// [biomassAfterHarvest]: Biomass immediately after harvest
  /// Returns recovery rate multiplier
  static double calculateBiomassRecoveryRate(
    double biomassAfterRecovery,
    double biomassAfterHarvest,
  ) {
    return CalculationConstants.safeDivide(
      biomassAfterRecovery,
      biomassAfterHarvest,
      CalculationConstants.defaultRecoveryRate,
    );
  }

  /// Estimates harvest schedule based on target intervals.
  ///
  /// [targetDoc]: Final target day of culture
  /// [harvestInterval]: Days between harvests
  /// Returns list of recommended harvest DOCs
  static List<int> estimateHarvestSchedule(int targetDoc, int harvestInterval) {
    final harvestDocs = <int>[];

    for (var doc = harvestInterval; doc < targetDoc; doc += harvestInterval) {
      harvestDocs.add(doc);
    }

    return harvestDocs;
  }
}
