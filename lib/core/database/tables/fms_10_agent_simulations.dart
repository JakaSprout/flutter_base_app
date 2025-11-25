part of '../app_database.dart';

/// Agent simulation table for loan and harvest guarantee calculations.
/// 100% matches backend PostgreSQL schema.
/// Based on schema.sql - fms_10_agent_simulation
@DataClassName('Fms10AgentSimulation')
class Fms10AgentSimulations extends Table {
  @override
  String get tableName => 'fms_10_agent_simulation';

  IntColumn get simulationId => integer().autoIncrement()();
  TextColumn get simulationUuid => text().unique().withDefault(
    const Constant(
      "lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-' || substr('89ab',abs(random()) % 4 + 1, 1) || substr(lower(hex(randomblob(2))),2) || '-' || lower(hex(randomblob(6)))",
    ),
  )();
  TextColumn get simulationCode => text().unique()();
  TextColumn get simulationName => text().unique()();
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

  // Agent Type and Loan Parameters
  TextColumn get agentType =>
      text().nullable().withDefault(const Constant('Loan'))();
  RealColumn get loanAmount => real().nullable()();
  TextColumn get loanCurrency =>
      text().nullable().withDefault(const Constant('idr'))();
  RealColumn get interestRatePercent => real().nullable()();
  IntColumn get loanTermMonths => integer().nullable()();

  // Guarantee Parameters
  RealColumn get guaranteePercentage => real().nullable()();
  RealColumn get guaranteeAmount => real().nullable()();
  TextColumn get guaranteeCurrency =>
      text().nullable().withDefault(const Constant('idr'))();
  RealColumn get collateralValue => real().nullable()();
  TextColumn get collateralCurrency =>
      text().nullable().withDefault(const Constant('idr'))();

  // Pond Parameters
  RealColumn get pondArea => real().nullable()();
  TextColumn get pondAreaUnit =>
      text().nullable().withDefault(const Constant('sqm'))();

  // Production and Financial Estimates
  RealColumn get estimatedProductionKg => real().nullable()();
  TextColumn get estimatedProductionUnit =>
      text().nullable().withDefault(const Constant('kg'))();
  RealColumn get estimatedRevenue => real().nullable()();
  TextColumn get estimatedRevenueCurrency =>
      text().nullable().withDefault(const Constant('idr'))();
  RealColumn get estimatedProfit => real().nullable()();
  TextColumn get estimatedProfitCurrency =>
      text().nullable().withDefault(const Constant('idr'))();

  // Risk Assessment
  RealColumn get debtServiceCoverageRatio => real().nullable()();
  RealColumn get loanToValueRatio => real().nullable()();
  RealColumn get riskScore => real().nullable()();
  TextColumn get riskLevel =>
      text().nullable().withDefault(const Constant('Medium'))();
  TextColumn get approvalRecommendation =>
      text().nullable().withDefault(const Constant('Pending'))();

  // Simulation Data (JSONB)
  TextColumn get simulationData => text().nullable()(); // JSONB
  TextColumn get calculationDetails => text().nullable()(); // JSONB
  TextColumn get riskAssessment => text().nullable()(); // JSONB
  TextColumn get monthlyPaymentSchedule => text().nullable()(); // JSONB

  // Approval Workflow
  BoolColumn get isApproved =>
      boolean().nullable().withDefault(const Constant(false))();
  BoolColumn get isSynced =>
      boolean().nullable().withDefault(const Constant(false))();
  TextColumn get simulationStatus =>
      text().nullable().withDefault(const Constant('Draft'))();
  IntColumn get approvedBy => integer().nullable().references(
    FmsMtEmployees,
    #employeeId,
    onDelete: KeyAction.setNull,
  )();
  DateTimeColumn get approvedDate => dateTime().nullable()();
  TextColumn get rejectionReason => text().nullable()();

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

  // Timestamps
  DateTimeColumn get createdDate =>
      dateTime().nullable().withDefault(currentDateAndTime)();
  DateTimeColumn get lastUpdatedDate =>
      dateTime().nullable().withDefault(currentDateAndTime)();
  DateTimeColumn get syncedDate => dateTime().nullable()();
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
    "CHECK (agent_type IN ('Loan','Guarantee','Combined'))",
    "CHECK (risk_level IN ('Low','Medium','High','Very_High'))",
    "CHECK (approval_recommendation IN ('Pending','Approve','Reject','Conditional'))",
    "CHECK (simulation_status IN ('Draft','Active','Approved','Rejected','Completed','Archived'))",
    "CHECK (language_preference IN ('id','en'))",
    "CHECK (unit_system IN ('metric','imperial'))",
  ];
}
