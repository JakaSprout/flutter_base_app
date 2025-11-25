part of '../app_database.dart';

/// Lab request detail table.
/// 100% matches backend PostgreSQL schema.
/// Based on schema.sql - fms_29_lab_request_detail
@DataClassName('Fms29LabRequestDetail')
class Fms29LabRequestDetails extends Table {
  @override
  String get tableName => 'fms_29_lab_request_detail';

  IntColumn get labRequestDetailId => integer().autoIncrement()();
  TextColumn get idUuid => text().unique().withDefault(
    const Constant(
      "lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-' || substr('89ab',abs(random()) % 4 + 1, 1) || substr(lower(hex(randomblob(2))),2) || '-' || lower(hex(randomblob(6)))",
    ),
  )();
  TextColumn get labRequestUuid =>
      text().references(Fms20LabRequests, #idUuid)();
  TextColumn get sampleCode => text().nullable()();
  TextColumn get pondUuid => text()();
  TextColumn get sampleLabTypeUuid => text()();
  IntColumn get doc => integer().nullable()();
  TextColumn get testTypeDetails => text().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  TextColumn get createdBy => text().nullable()();
  DateTimeColumn get createdDate =>
      dateTime().withDefault(currentDateAndTime)();
  TextColumn get lastUpdatedBy => text().nullable()();
  DateTimeColumn get lastUpdatedDate => dateTime().nullable()();
}
