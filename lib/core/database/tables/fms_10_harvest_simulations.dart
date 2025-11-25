part of '../app_database.dart';

/// Harvest simulation engine for production cycle planning.
/// 100% matches backend PostgreSQL schema.
@DataClassName('Fms10HarvestSimulation')
class Fms10HarvestSimulations extends Table {
  IntColumn get simulationId => integer().autoIncrement()();
  TextColumn get simulationUuid => text().unique()();
  TextColumn get simulationCode => text().unique()();
  TextColumn get simulationName => text()();
  IntColumn get employeeId => integer().references(
    FmsMtEmployees,
    #employeeId,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get pondId => integer().nullable().references(
    FmsMtPonds,
    #pondId,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get deviceUuid => text().nullable().references(
    Fms10Devices,
    #deviceUuid,
    onDelete: KeyAction.setNull,
  )();

  // Cycle Configuration
  TextColumn get cycleType =>
      text().nullable().withDefault(const Constant('Full_Cycle'))();
  TextColumn get harvestMode =>
      text().nullable().withDefault(const Constant('Auto'))();
  IntColumn get harvestFrequencyDays => integer().nullable()();
  RealColumn get partialHarvestPercentage => real().nullable()();

  // Pond Parameters
  RealColumn get pondArea => real().nullable()();
  TextColumn get pondAreaUnit =>
      text().nullable().withDefault(const Constant('sqm'))();
  RealColumn get pwa => real().nullable()();
  TextColumn get pwaUnit =>
      text().nullable().withDefault(const Constant('sqm'))();
  RealColumn get pondDepth => real().nullable()();
  TextColumn get pondDepthUnit =>
      text().nullable().withDefault(const Constant('meter'))();

  // Stocking Parameters
  RealColumn get stockingDensity => real().nullable()();
  TextColumn get stockingDensityUnit =>
      text().nullable().withDefault(const Constant('per_sqm'))();
  RealColumn get initialAbw => real().nullable()();
  TextColumn get initialAbwUnit =>
      text().nullable().withDefault(const Constant('gram'))();
  RealColumn get targetAbw => real().nullable()();
  TextColumn get targetAbwUnit =>
      text().nullable().withDefault(const Constant('gram'))();
  RealColumn get targetSurvivalRatePercent => real().nullable()();
  RealColumn get targetFcr => real().nullable()();
  IntColumn get targetDoc => integer().nullable()();

  // Commodity & System
  TextColumn get commodityCode => text().nullable().references(
    Fms10CapacityReferences,
    #commodityCode,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get cultureSystem => text().nullable()();

  // Current State
  IntColumn get currentDoc =>
      integer().nullable().withDefault(const Constant(0))();
  IntColumn get currentPopulation => integer().nullable()();
  RealColumn get currentAbw => real().nullable()();
  TextColumn get currentAbwUnit =>
      text().nullable().withDefault(const Constant('gram'))();
  RealColumn get cumulativeFeedUsed => real().nullable()();
  TextColumn get cumulativeFeedUsedUnit =>
      text().nullable().withDefault(const Constant('kg'))();

  // Capacity References
  IntColumn get capacityRefId => integer().nullable().references(
    Fms10CapacityReferences,
    #capacityRefId,
    onDelete: KeyAction.setNull,
  )();
  RealColumn get capacityPerArea => real().nullable()();
  TextColumn get capacityPerAreaUnit =>
      text().nullable().withDefault(const Constant('kg_per_sqm'))();
  RealColumn get capacityTotal => real().nullable()();
  TextColumn get capacityTotalUnit =>
      text().nullable().withDefault(const Constant('kg'))();

  // Growth Parameters
  RealColumn get estimatedAdg => real().nullable()();
  TextColumn get estimatedAdgUnit =>
      text().nullable().withDefault(const Constant('gram'))();
  IntColumn get initialStockingCount => integer().nullable()();
  RealColumn get dailyLossRatePercent => real().nullable()();

  // Economic Parameters
  RealColumn get feedPrice => real().nullable()();
  TextColumn get feedPriceCurrency =>
      text().nullable().withDefault(const Constant('idr'))();
  RealColumn get commodityPrice => real().nullable()();
  TextColumn get commodityPriceCurrency =>
      text().nullable().withDefault(const Constant('idr'))();
  RealColumn get feedingRatePercent => real().nullable()();
  RealColumn get baseMortalityRatePercent => real().nullable()();
  RealColumn get waterExchangeRatePercent => real().nullable()();

  // Materialized Results (JSONB)
  TextColumn get dailyProjections => text().nullable()(); // JSONB
  TextColumn get harvestEvents => text().nullable()(); // JSONB
  TextColumn get summaryData => text().nullable()(); // JSONB
  TextColumn get monthlySummary => text().nullable()(); // JSONB

  // Status Flags
  BoolColumn get isMaterialized =>
      boolean().nullable().withDefault(const Constant(false))();
  BoolColumn get isSynced =>
      boolean().nullable().withDefault(const Constant(false))();
  TextColumn get simulationStatus =>
      text().nullable().withDefault(const Constant('Draft'))();
  TextColumn get approvalStatus =>
      text().nullable().withDefault(const Constant('Pending'))();
  IntColumn get approvedBy => integer().nullable().references(
    FmsMtEmployees,
    #employeeId,
    onDelete: KeyAction.setNull,
  )();
  DateTimeColumn get approvedDate => dateTime().nullable()();
  TextColumn get rejectionReason => text().nullable()();

  // Comparison & Variance
  IntColumn get comparedToCycleId => integer().nullable().references(
    Fms10HarvestSimulations,
    #simulationId,
    onDelete: KeyAction.setNull,
  )();
  RealColumn get varianceBiomassPercent => real().nullable()();
  RealColumn get varianceFcrPercent => real().nullable()();
  RealColumn get varianceSurvivalPercent => real().nullable()();

  // Display Preferences
  TextColumn get languagePreference =>
      text().nullable().withDefault(const Constant('id'))();
  TextColumn get unitSystem =>
      text().nullable().withDefault(const Constant('metric'))();
  TextColumn get displayWeightUnit =>
      text().nullable().withDefault(const Constant('kg'))();
  TextColumn get displayAreaUnit =>
      text().nullable().withDefault(const Constant('sqm'))();
  TextColumn get displayCurrency =>
      text().nullable().withDefault(const Constant('idr'))();

  // Metadata
  TextColumn get simulationVersion =>
      text().nullable().withDefault(const Constant('v1.0'))();
  IntColumn get clonedFromSimulationId => integer().nullable().references(
    Fms10HarvestSimulations,
    #simulationId,
    onDelete: KeyAction.setNull,
  )();

  // Timestamps
  DateTimeColumn get createdDate =>
      dateTime().nullable().withDefault(currentDateAndTime)();
  DateTimeColumn get lastUpdatedDate =>
      dateTime().nullable().withDefault(currentDateAndTime)();
  DateTimeColumn get syncedDate => dateTime().nullable()();
  DateTimeColumn get materializedDate => dateTime().nullable()();
  DateTimeColumn get deletedDate => dateTime().nullable()();
  IntColumn get createdBy => integer().nullable().references(
    FmsMtEmployees,
    #employeeId,
    onDelete: KeyAction.setNull,
  )();
  IntColumn get lastUpdatedBy => integer().nullable().references(
    FmsMtEmployees,
    #employeeId,
    onDelete: KeyAction.setNull,
  )();

  @override
  List<String> get customConstraints => [
    "CHECK (cycle_type IN ('Full_Cycle','Partial_Harvest','Multi_Harvest'))",
    "CHECK (harvest_mode IN ('Auto','Manual'))",
    "CHECK (simulation_status IN ('Draft','Active','Approved','Completed','Archived'))",
    "CHECK (approval_status IN ('Pending','Approved','Rejected'))",
    "CHECK (language_preference IN ('id','en'))",
    "CHECK (unit_system IN ('metric','imperial'))",
  ];
}
