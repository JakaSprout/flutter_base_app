/// Service for calculating biomass growth and related metrics in harvest simulation.
///
/// This service handles the core mathematical calculations for:
/// - Weight progression based on ADG (Average Daily Gain)
/// - Population changes with daily mortality
/// - Biomass calculation from weight and population
/// - Capacity validation
class BiomassCalculator {
  const BiomassCalculator._();

  /// Calculates weight at a specific DOC based on ADG.
  ///
  /// Formula: weight(DOC) = weight(DOC-1) + ADG
  ///
  /// [previousWeight]: Weight at previous DOC (grams)
  /// [adg]: Average Daily Gain (grams per day)
  /// Returns weight at current DOC (grams)
  static double calculateWeight(double previousWeight, double adg) {
    return previousWeight + adg;
  }

  /// Calculates population at a specific DOC considering daily mortality.
  ///
  /// Formula: population(DOC) = population(DOC-1) × (1 - dailyLossPercentage/100)
  ///
  /// [previousPopulation]: Population at previous DOC
  /// [dailyLossPercentage]: Daily loss percentage (0-100)
  /// Returns population at current DOC
  static double calculatePopulation(
    double previousPopulation,
    double dailyLossPercentage,
  ) {
    final lossMultiplier = 1.0 - (dailyLossPercentage / 100.0);
    return previousPopulation * lossMultiplier;
  }

  /// Calculates biomass from weight and population.
  ///
  /// Formula: biomass(kg) = (weight(gr) × population) / 1000
  ///
  /// [weight]: Weight in grams
  /// [population]: Number of individuals
  /// Returns biomass in kilograms
  static double calculateBiomass(double weight, double population) {
    return (weight * population) / 1000.0;
  }

  /// Calculates Survival Rate at current DOC.
  ///
  /// Formula: SR(%) = (current_population / initial_population) × 100
  ///
  /// [currentPopulation]: Population at current DOC
  /// [initialPopulation]: Initial population at DOC 1
  /// Returns survival rate percentage (0-100)
  static double calculateSurvivalRate(
    double currentPopulation,
    double initialPopulation,
  ) {
    if (initialPopulation <= 0) return 0.0;
    return (currentPopulation / initialPopulation) * 100.0;
  }

  /// Calculates Average Daily Gain from weight change.
  ///
  /// Formula: ADG = weight_change_per_day
  ///
  /// [currentWeight]: Weight at current DOC
  /// [previousWeight]: Weight at previous DOC
  /// Returns ADG in grams per day
  static double calculateADG(double currentWeight, double previousWeight) {
    return currentWeight - previousWeight;
  }

  /// Validates if biomass is within pond capacity limits.
  ///
  /// [biomass]: Current biomass in kg
  /// [capacityKgPerPond]: Maximum capacity per pond in kg
  /// Returns true if within capacity, false if exceeded
  static bool isWithinCapacity(double biomass, double capacityKgPerPond) {
    return biomass <= capacityKgPerPond;
  }

  /// Calculates capacity utilization percentage.
  ///
  /// Formula: utilization(%) = (biomass / capacity) × 100
  ///
  /// [biomass]: Current biomass in kg
  /// [capacity]: Maximum capacity in kg
  /// Returns utilization percentage (0-100+)
  static double calculateCapacityUtilization(double biomass, double capacity) {
    if (capacity <= 0) return 0.0;
    return (biomass / capacity) * 100.0;
  }

  /// Calculates Feed Conversion Ratio for current period.
  ///
  /// Formula: FCR = total_feed_consumed / biomass_gain
  ///
  /// [totalFeedConsumed]: Total feed consumed in kg
  /// [biomassGain]: Biomass gain in kg
  /// Returns FCR value
  static double calculateFCR(double totalFeedConsumed, double biomassGain) {
    if (biomassGain <= 0) return double.infinity;
    return totalFeedConsumed / biomassGain;
  }
}
