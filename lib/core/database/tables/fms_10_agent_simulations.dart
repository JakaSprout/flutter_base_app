part of '../app_database.dart';

/// Agent simulation table for loan and harvest guarantee calculations.
/// 100% matches backend PostgreSQL schema.
/// Note: Backend table name is fms_10_agent_simulation (singular)
@DataClassName('Fms10AgentSimulation')
class Fms10AgentSimulations extends Table {
  @override
  String get tableName => 'fms_10_agent_simulation';

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

  // Display Units
  TextColumn get displayCurrency =>
      text().nullable().withDefault(const Constant('idr'))();
  TextColumn get displayWeightUnit =>
      text().nullable().withDefault(const Constant('kg'))();
  TextColumn get displayAreaUnit =>
      text().nullable().withDefault(const Constant('sqm'))();

  // Current State
  IntColumn get currentDoc => integer().nullable()();
  RealColumn get currentBiomass => real().nullable()();
  TextColumn get currentBiomassUnit =>
      text().nullable().withDefault(const Constant('kg'))();

  // Stocking Parameters
  IntColumn get stockingCount => integer().nullable()();
  RealColumn get targetSrPercent => real().nullable()();
  IntColumn get targetDoc => integer().nullable()();

  // Financial Parameters
  RealColumn get feedPayment => real().nullable()();
  TextColumn get feedPaymentCurrency =>
      text().nullable().withDefault(const Constant('idr'))();
  RealColumn get harvestPrice => real().nullable()();
  TextColumn get harvestPriceCurrency =>
      text().nullable().withDefault(const Constant('idr'))();

  // Estimates
  RealColumn get estimatedHarvest => real().nullable()();
  TextColumn get estimatedHarvestUnit =>
      text().nullable().withDefault(const Constant('kg'))();
  RealColumn get estimatedFcr => real().nullable()();
  RealColumn get feedPrice => real().nullable()();
  TextColumn get feedPriceCurrency =>
      text().nullable().withDefault(const Constant('idr'))();
  RealColumn get harvestGuarantee => real().nullable()();
  TextColumn get harvestGuaranteeCurrency =>
      text().nullable().withDefault(const Constant('idr'))();
  RealColumn get ltvRatio => real().nullable()();
  RealColumn get progress => real().nullable()();

  // ABW Parameters
  RealColumn get currentAbw => real().nullable()();
  TextColumn get currentAbwUnit =>
      text().nullable().withDefault(const Constant('gram'))();
  RealColumn get harvestAbw => real().nullable()();
  TextColumn get harvestAbwUnit =>
      text().nullable().withDefault(const Constant('gram'))();

  // Feed Calculations
  RealColumn get feedNeed => real().nullable()();
  TextColumn get feedNeedUnit =>
      text().nullable().withDefault(const Constant('kg'))();
  RealColumn get feedCost => real().nullable()();
  TextColumn get feedCostCurrency =>
      text().nullable().withDefault(const Constant('idr'))();

  // Loan Calculations
  RealColumn get maxLoan => real().nullable()();
  TextColumn get maxLoanCurrency =>
      text().nullable().withDefault(const Constant('idr'))();

  // Calculation Details (JSONB)
  TextColumn get calculationDetails => text().nullable()(); // JSONB

  // Status Flags
  BoolColumn get isMaterialized =>
      boolean().nullable().withDefault(const Constant(false))();
  BoolColumn get isSynced =>
      boolean().nullable().withDefault(const Constant(false))();
  TextColumn get simulationStatus =>
      text().nullable().withDefault(const Constant('Draft'))();

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
    "CHECK (simulation_status IN ('Draft','Active','Completed','Archived'))",
  ];
}
