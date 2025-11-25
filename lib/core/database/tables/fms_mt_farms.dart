part of '../app_database.dart';

/// Master data table for farms.
/// 100% matches backend PostgreSQL schema.
/// Based on schema.sql - fms_mt_farms
@DataClassName('FmsMtFarm')
class FmsMtFarms extends Table {
  IntColumn get farmId => integer().autoIncrement()();
  TextColumn get farmUuid => text().unique().withDefault(
    const Constant(
      "lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-' || substr('89ab',abs(random()) % 4 + 1, 1) || substr(lower(hex(randomblob(2))),2) || '-' || lower(hex(randomblob(6)))",
    ),
  )();
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
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdDate =>
      dateTime().withDefault(currentDateAndTime)();
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
}
