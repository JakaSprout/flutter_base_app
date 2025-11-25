part of '../app_database.dart';

/// Lab type master data table.
/// 100% matches backend PostgreSQL schema.
/// Based on schema.sql - fms_mt_lab_type
@DataClassName('FmsMtLabType')
class FmsMtLabTypes extends Table {
  @override
  String get tableName => 'fms_mt_lab_type';

  IntColumn get labTypeId => integer().autoIncrement()();
  TextColumn get idUuid => text().unique().withDefault(
    const Constant(
      "lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-' || substr('89ab',abs(random()) % 4 + 1, 1) || substr(lower(hex(randomblob(2))),2) || '-' || lower(hex(randomblob(6)))",
    ),
  )();
  TextColumn get labSampleTestType => text()();
  TextColumn get standard => text().nullable()();
  TextColumn get testType => text()();
  TextColumn get testTypeDetail => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get createdBy => integer().nullable()();
  DateTimeColumn get createdDate =>
      dateTime().withDefault(currentDateAndTime)();
  IntColumn get lastUpdatedBy => integer().nullable()();
  DateTimeColumn get lastUpdatedDate => dateTime().nullable()();

  @override
  List<String> get customConstraints => [
    "CHECK (test_type IN ('PCR Konvensional','PCR Pockit','PCR Realtime','Water Quality'))",
  ];
}
