part of '../app_database.dart';

/// Master data table for exchange rates.
/// 100% matches backend PostgreSQL schema.
@DataClassName('FmsMtExchangeRate')
class FmsMtExchangeRates extends Table {
  IntColumn get rateId => integer().autoIncrement()();
  TextColumn get fromCurrencyCode =>
      text().references(FmsMtUnits, #unitCode, onDelete: KeyAction.cascade)();
  TextColumn get toCurrencyCode =>
      text().references(FmsMtUnits, #unitCode, onDelete: KeyAction.cascade)();
  RealColumn get exchangeRate => real()();
  RealColumn get buyRate => real().nullable()();
  RealColumn get sellRate => real().nullable()();
  DateTimeColumn get effectiveDate => dateTime()();
  DateTimeColumn get validUntil => dateTime().nullable()();
  DateTimeColumn get rateTimestamp =>
      dateTime().nullable().withDefault(currentDateAndTime)();
  TextColumn get source => text().nullable()();
  TextColumn get rateType =>
      text().nullable().withDefault(const Constant('Official'))();
  TextColumn get notes => text().nullable()();
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
    "CHECK (rate_type IN ('Official','Commercial','Tourist','Custom'))",
  ];
}
