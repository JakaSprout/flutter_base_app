part of '../app_database.dart';

/// Lab request main table.
/// 100% matches backend PostgreSQL schema.
/// Based on schema.sql - fms_20_lab_request
@DataClassName('Fms20LabRequest')
class Fms20LabRequests extends Table {
  @override
  String get tableName => 'fms_20_lab_request';

  IntColumn get labRequestId => integer().autoIncrement()();
  TextColumn get idUuid => text().unique().withDefault(
    const Constant(
      "lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-' || substr('89ab',abs(random()) % 4 + 1, 1) || substr(lower(hex(randomblob(2))),2) || '-' || lower(hex(randomblob(6)))",
    ),
  )();
  TextColumn get employeeUuid => text()();
  DateTimeColumn get orderDate => dateTime().withDefault(currentDateAndTime)();
  TextColumn get farmUuid => text()();
  TextColumn get testType => text()();
  TextColumn get anamnesa => text()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  TextColumn get createdBy => text().nullable()();
  DateTimeColumn get createdDate =>
      dateTime().withDefault(currentDateAndTime)();
  TextColumn get lastUpdatedBy => text().nullable()();
  DateTimeColumn get lastUpdatedDate => dateTime().nullable()();
}
