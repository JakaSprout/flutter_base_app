/// Control names for the reactive harvest calculator form.
class HarvestCalculatorFormControls {
  const HarvestCalculatorFormControls._();

  /// Simulation name control name.
  static const String simulationName = 'simulationName';

  /// Commodity control name.
  static const String commodity = 'commodity';

  /// Cultivation system control name.
  static const String cultivationSystem = 'cultivationSystem';

  /// Pond area control name.
  static const String pondArea = 'pondArea';

  /// Pond depth control name (used for stocking density).
  static const String pondDepth = 'pondDepth';

  /// Capacity control name (kg/m²).
  static const String capacityKgPerM2 = 'capacityKgPerM2';

  /// Capacity control name (grams).
  static const String capacityGrams = 'capacityGrams';

  /// Pond capacity control name (kg/kolam).
  static const String pondCapacityKgPerPond = 'pondCapacityKgPerPond';

  /// Fry count control name (deprecated).
  static const String fryCount = 'fryCount';

  /// Target harvest control name.
  static const String targetHarvest = 'targetHarvest';

  /// Estimated ADG control name.
  static const String estimatedADG = 'estimatedADG';

  /// Target DOC control name.
  static const String targetDOC = 'targetDOC';

  /// Target SR control name.
  static const String targetSR = 'targetSR';

  /// Estimated FCR control name.
  static const String estimatedFCR = 'estimatedFCR';

  /// Target biomass control name.
  static const String targetBiomass = 'targetBiomass';

  /// Target selling price control name.
  static const String targetSellingPrice = 'targetSellingPrice';

  /// Target feed price control name.
  static const String targetFeedPrice = 'targetFeedPrice';

  /// Selling price control name.
  static const String sellingPrice = 'sellingPrice';

  /// Feed price control name.
  static const String feedPrice = 'feedPrice';

  /// Cycle type control name (Full Cycle or Mid Cycle).
  static const String cycleType = 'cycleType';

  /// Current DOC control name (when Mid Cycle is selected).
  static const String currentDOC = 'currentDOC';

  /// Stocking density control name (Tebar).
  static const String stocking = 'stocking';

  /// Feeding rate control name.
  static const String feedingRate = 'feedingRate';

  /// Current commodity weight control name.
  static const String currentCommodityWeight = 'currentCommodityWeight';

  /// Target commodity weight control name.
  static const String targetCommodityWeight = 'targetCommodityWeight';

  /// Use registered pond control name.
  static const String useRegisteredPond = 'useRegisteredPond';

  /// Selected pond control name.
  static const String selectedPond = 'selectedPond';

  /// Simulation type control name (Cycle or Agent).
  static const String simulationType = 'simulationType';

  /// Current biomass control name (for Agent mode).
  static const String currentBiomass = 'currentBiomass';

  /// Total feed payment obligation control name (for Agent mode).
  static const String totalFeedPaymentObligation = 'totalFeedPaymentObligation';

  /// Harvest purchase price control name (for Agent mode).
  static const String harvestPurchasePrice = 'harvestPurchasePrice';

  /// Estimated harvest yield control name (for Agent mode).
  static const String estimatedHarvestYield = 'estimatedHarvestYield';
}
