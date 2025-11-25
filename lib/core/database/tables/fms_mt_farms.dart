part of '../app_database.dart';

/// Master data table for farms.
/// 100% matches backend PostgreSQL schema.
@DataClassName('FmsMtFarm')
class FmsMtFarms extends Table {
  IntColumn get farmId => integer().autoIncrement()();
  TextColumn get farmUuid => text().unique()();
  TextColumn get farmCode => text().unique()();
  TextColumn get farmName => text()();
  TextColumn get farmLocation => text().nullable()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  TextColumn get farmBoundary => text().nullable()();
  RealColumn get farmArea => real().nullable()();
  TextColumn get farmAreaUnit =>
      text().nullable().withDefault(const Constant('sqm'))();
  TextColumn get ownerName => text().nullable()();
  TextColumn get contactInfo => text().nullable()();
  DateTimeColumn get establishedDate => dateTime().nullable()();
  BoolColumn get isActive =>
      boolean().nullable().withDefault(const Constant(true))();
  DateTimeColumn get createdDate =>
      dateTime().nullable().withDefault(currentDateAndTime)();
  IntColumn get createdBy => integer().nullable().references(
    FmsMtEmployees,
    #employeeId,
    onDelete: KeyAction.setNull,
  )();
}
