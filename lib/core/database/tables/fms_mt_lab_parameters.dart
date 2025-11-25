part of '../app_database.dart';

/// Lab parameters master data table.
/// 100% matches backend PostgreSQL schema.
/// Based on schema.sql - fms_mt_lab_parameters
@DataClassName('FmsMtLabParameter')
class FmsMtLabParameters extends Table {
  @override
  String get tableName => 'fms_mt_lab_parameters';

  IntColumn get parameterId => integer().autoIncrement()();
  TextColumn get parameterUuid => text().unique().withDefault(
    const Constant(
      "lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-' || substr('89ab',abs(random()) % 4 + 1, 1) || substr(lower(hex(randomblob(2))),2) || '-' || lower(hex(randomblob(6)))",
    ),
  )();
  IntColumn get testTypeId =>
      integer().references(FmsMtLabTestTypes, #testTypeId)();
  TextColumn get parameterCode => text()();
  TextColumn get parameterName => text()();
  TextColumn get standardOperator => text().nullable()();
  RealColumn get standardMin => real().nullable()();
  RealColumn get standardMax => real().nullable()();
  TextColumn get parameterUnit => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdDate =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
    'UNIQUE(test_type_id, parameter_code)',
  ];
}
