import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';

/// Helper class for capacity recommendations based on commodity and cultivation system.
class CapacityRecommendationHelper {
  const CapacityRecommendationHelper._();

  /// Gets recommended capacity (kg/m²) based on commodity and cultivation system.
  ///
  /// Returns null if no recommendation is available for the given combination.
  static String? getRecommendedCapacity({
    required String? commodity,
    required String? cultivationSystem,
  }) {
    if (commodity == null || cultivationSystem == null) {
      return null;
    }

    // Define recommendations based on commodity and cultivation system
    // This is a placeholder - adjust values based on actual business requirements
    if (commodity == HarvestCalculatorConstants.commodityShrimp) {
      switch (cultivationSystem) {
        case HarvestCalculatorConstants.systemRAS:
          return '1.5';
        case HarvestCalculatorConstants.systemBiofloc:
          return '1.2';
        case HarvestCalculatorConstants.systemTraditional:
          return '1.0';
        default:
          return null;
      }
    } else if (commodity == HarvestCalculatorConstants.commodityTilapia ||
        commodity == HarvestCalculatorConstants.commodityNila) {
      switch (cultivationSystem) {
        case HarvestCalculatorConstants.systemRAS:
          return '6';
        case HarvestCalculatorConstants.systemBiofloc:
          return '5';
        case HarvestCalculatorConstants.systemTraditional:
          return '4';
        default:
          return null;
      }
    }

    return null;
  }
}

