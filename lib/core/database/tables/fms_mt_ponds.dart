part of '../app_database.dart';

/// Master data table for ponds.
/// 100% matches backend PostgreSQL schema.
/// Based on schema.sql - fms_mt_ponds
@DataClassName('FmsMtPond')
class FmsMtPonds extends Table {
  IntColumn get pondId => integer().autoIncrement()();
  TextColumn get pondUuid => text().unique().withDefault(
    const Constant(
      "lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-' || substr('89ab',abs(random()) % 4 + 1, 1) || substr(lower(hex(randomblob(2))),2) || '-' || lower(hex(randomblob(6)))",
    ),
  )();
  TextColumn get pondCode => text().unique()();
  TextColumn get pondName => text()();
  TextColumn get pondType => text().nullable()();
  TextColumn get pondShape => text().nullable()();
  RealColumn get pondSize => real().nullable()();
  TextColumn get pondSizeUnit =>
      text().nullable().withDefault(const Constant('sqm'))();
  RealColumn get pwa => real().nullable()();
  TextColumn get pwaUnit =>
      text().nullable().withDefault(const Constant('sqm'))();
  RealColumn get depth => real().nullable()();
  TextColumn get depthUnit =>
      text().nullable().withDefault(const Constant('meter'))();
  RealColumn get maxDepth => real().nullable()();
  TextColumn get maxDepthUnit =>
      text().nullable().withDefault(const Constant('meter'))();
  RealColumn get volume => real().nullable()();
  TextColumn get volumeUnit =>
      text().nullable().withDefault(const Constant('cubic_meter'))();
  TextColumn get bottomType => text().nullable()();
  BoolColumn get hasAerator => boolean().withDefault(const Constant(false))();
  IntColumn get aeratorCount => integer().nullable()();
  RealColumn get aeratorTotalHp => real().nullable()();
  BoolColumn get hasCentralDrain =>
      boolean().withDefault(const Constant(false))();
  TextColumn get waterSource => text().nullable()();
  TextColumn get pondStatus =>
      text().withDefault(const Constant('Available'))();
  IntColumn get currentCycleId => integer().nullable()();
  RealColumn get maxBiomassKgPerSqm => real().nullable()();
  RealColumn get recommendedStockingDensity => real().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdDate =>
      dateTime().withDefault(currentDateAndTime)();
  IntColumn get createdBy => integer().nullable().references(
    FmsMtEmployees,
    #employeeId,
    onDelete: KeyAction.setNull,
  )();
  DateTimeColumn get lastUpdatedDate =>
      dateTime().withDefault(currentDateAndTime)();
  IntColumn get lastUpdatedBy => integer().nullable().references(
    FmsMtEmployees,
    #employeeId,
    onDelete: KeyAction.setNull,
  )();
  DateTimeColumn get deletedDate => dateTime().nullable()();
  RealColumn get maxBiomass => real().nullable()();
  TextColumn get maxBiomassUnit => text().nullable()();
  IntColumn get farmId => integer().nullable().references(
    FmsMtFarms,
    #farmId,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get farmUuid => text().nullable()();

  @override
  List<String> get customConstraints => [
    "CHECK (pond_type IN ('Earthen','Concrete','Liner','RAS','Biofloc'))",
    "CHECK (pond_shape IN ('Rectangular','Circular'))",
    "CHECK (pond_status IN ('Available','In_Production','Maintenance','Closed'))",
  ];
}
