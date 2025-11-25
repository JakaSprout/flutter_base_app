part of '../app_database.dart';

/// Master data table for units system.
/// 100% matches backend PostgreSQL schema.
@DataClassName('FmsMtUnit')
class FmsMtUnits extends Table {
  IntColumn get unitId => integer().autoIncrement()();
  TextColumn get unitCode => text().unique()();
  TextColumn get unitCategory => text()();
  TextColumn get unitNameId => text().nullable()();
  TextColumn get unitNameEn => text().nullable()();
  TextColumn get unitSymbol => text().nullable()();
  TextColumn get unitDescriptionId => text().nullable()();
  TextColumn get unitDescriptionEn => text().nullable()();
  BoolColumn get isBaseUnit =>
      boolean().nullable().withDefault(const Constant(false))();
  TextColumn get baseUnitCode => text().nullable().references(
    FmsMtUnits,
    #unitCode,
    onDelete: KeyAction.setNull,
  )();
  RealColumn get defaultConversionFactor => real().nullable()();
  BoolColumn get isDynamic =>
      boolean().nullable().withDefault(const Constant(false))();
  BoolColumn get isMetric =>
      boolean().nullable().withDefault(const Constant(true))();
  IntColumn get displayDecimals =>
      integer().nullable().withDefault(const Constant(2))();
  IntColumn get sortOrder => integer().nullable()();
  BoolColumn get isActive =>
      boolean().nullable().withDefault(const Constant(true))();
  DateTimeColumn get createdDate =>
      dateTime().nullable().withDefault(currentDateAndTime)();
  IntColumn get createdBy => integer().nullable().references(
    FmsMtEmployees,
    #employeeId,
    onDelete: KeyAction.setNull,
  )();
  DateTimeColumn get lastUpdatedDate =>
      dateTime().nullable().withDefault(currentDateAndTime)();
  IntColumn get lastUpdatedBy => integer().nullable().references(
    FmsMtEmployees,
    #employeeId,
    onDelete: KeyAction.setNull,
  )();

  @override
  List<String> get customConstraints => [
    "CHECK (unit_category IN ('Weight','Area','Length','Currency','Temperature','Volume'))",
  ];
}
