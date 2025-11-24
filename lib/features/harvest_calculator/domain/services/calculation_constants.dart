/// Constants for calculation services in harvest calculator.
/// Contains mathematical constants and conversion factors.
class CalculationConstants {
  const CalculationConstants._();

  /// Conversion factor: grams to kilograms
  static const double gramsToKilograms = 1000.0;

  /// Percentage conversion factor (100%)
  static const double percentageFactor = 100.0;

  /// Biomass thresholds for agent mode calculations
  static const double halfBiomass = 0.5;
  static const double fourFifthBiomass = 0.8;

  /// Default harvest percentage when not specified
  static const double defaultHarvestPercentage = 50.0;

  /// Minimum and maximum percentage values
  static const double minPercentage = 0.0;
  static const double maxPercentage = 100.0;

  /// Recovery rate multiplier when biomass after harvest is zero or negative
  static const double defaultRecoveryRate = 1.0;

  /// Return value for mathematically undefined operations (e.g., division by zero)
  static const double undefinedResult = double.infinity;

  /// Return value for business logic that cannot be calculated
  static const double invalidResult = 0.0;

  /// Converts percentage to decimal (e.g., 25% -> 0.25)
  static double percentageToDecimal(double percentage) {
    return percentage / percentageFactor;
  }

  /// Applies percentage to a value (e.g., 1000 * 25% = 250)
  static double applyPercentage(double value, double percentage) {
    return value * percentageToDecimal(percentage);
  }

  /// Safely divides two numbers, returns defaultValue if denominator is zero
  static double safeDivide(double numerator, double denominator, [double defaultValue = 0.0]) {
    if (denominator == 0) return defaultValue;
    return numerator / denominator;
  }

  /// Sums a list of numbers, returns 0.0 for empty list
  static double sumList(List<double> values) {
    return values.fold(minPercentage, (sum, value) => sum + value);
  }
}
