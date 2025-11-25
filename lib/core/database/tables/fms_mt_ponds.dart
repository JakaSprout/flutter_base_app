part of '../app_database.dart';

/// Master data table for ponds.
/// 100% matches backend PostgreSQL schema.
@DataClassName('FmsMtPond')
class FmsMtPonds extends Table {
  IntColumn get pondId => integer().autoIncrement()();
  TextColumn get pondUuid => text().unique()();
  IntColumn get farmId => integer().nullable().references(
    FmsMtFarms,
    #farmId,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get pondCode => text().unique()();
  TextColumn get pondName => text().nullable()();
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
  TextColumn get pondType => text().nullable()();
  TextColumn get pondShape => text().nullable()();
  TextColumn get bottomType => text().nullable()();
  BoolColumn get hasAerator =>
      boolean().nullable().withDefault(const Constant(false))();
  IntColumn get aeratorCount => integer().nullable()();
  RealColumn get aeratorTotalHp => real().nullable()();
  BoolColumn get hasCentralDrain =>
      boolean().nullable().withDefault(const Constant(false))();
  TextColumn get waterSource => text().nullable()();
  TextColumn get pondStatus =>
      text().nullable().withDefault(const Constant('Available'))();
  IntColumn get currentCycleId => integer().nullable()();
  RealColumn get maxBiomass => real().nullable()();
  TextColumn get maxBiomassUnit =>
      text().nullable().withDefault(const Constant('kg_per_sqm'))();
  RealColumn get recommendedStockingDensity => real().nullable()();
  BoolColumn get isActive =>
      boolean().nullable().withDefault(const Constant(true))();
  DateTimeColumn get createdDate =>
      dateTime().nullable().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedDate => dateTime().nullable()();

  @override
  List<String> get customConstraints => [
    "CHECK (pond_type IN ('Earthen','Concrete','Liner','RAS','Biofloc'))",
    "CHECK (pond_shape IN ('Rectangular','Circular'))",
    "CHECK (bottom_type IN ('Clay','Sand','Concrete'))",
    "CHECK (water_source IN ('Reservoir','River','Sea','Well'))",
    "CHECK (pond_status IN ('Available','In_Production','Maintenance','Closed'))",
  ];
}
