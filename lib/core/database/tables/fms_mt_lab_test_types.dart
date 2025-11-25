part of '../app_database.dart';

/// Lab test types master data table.
/// 100% matches backend PostgreSQL schema.
/// Based on schema.sql - fms_mt_lab_test_types
@DataClassName('FmsMtLabTestType')
class FmsMtLabTestTypes extends Table {
  @override
  String get tableName => 'fms_mt_lab_test_types';

  IntColumn get testTypeId => integer().autoIncrement()();
  TextColumn get testTypeUuid => text().unique().withDefault(
    const Constant(
      "lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-' || substr('89ab',abs(random()) % 4 + 1, 1) || substr(lower(hex(randomblob(2))),2) || '-' || lower(hex(randomblob(6)))",
    ),
  )();
  TextColumn get testTypeCode => text().unique()();
  TextColumn get testTypeName => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdDate =>
      dateTime().withDefault(currentDateAndTime)();
}
