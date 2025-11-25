part of '../app_database.dart';

/// Device registration table for offline sync functionality.
/// 100% matches backend PostgreSQL schema.
@DataClassName('Fms10Device')
class Fms10Devices extends Table {
  IntColumn get deviceId => integer().autoIncrement()();
  TextColumn get idUuid => text().unique()();
  IntColumn get employeeId => integer().references(
    FmsMtEmployees,
    #employeeId,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get deviceUuid => text().unique()();
  TextColumn get deviceName => text()();
  TextColumn get deviceType => text().nullable()();
  TextColumn get osType => text().nullable()();
  TextColumn get osVersion => text().nullable()();
  TextColumn get appVersion => text().nullable()();
  TextColumn get deviceModel => text().nullable()();
  TextColumn get deviceManufacturer => text().nullable()();
  DateTimeColumn get lastSyncDate => dateTime().nullable()();
  DateTimeColumn get lastActiveDate => dateTime().nullable()();
  BoolColumn get isActive =>
      boolean().nullable().withDefault(const Constant(true))();
  BoolColumn get isRegistered =>
      boolean().nullable().withDefault(const Constant(true))();
  TextColumn get registrationStatus =>
      text().nullable().withDefault(const Constant('Pending'))();
  IntColumn get registeredBy => integer().nullable().references(
    FmsMtEmployees,
    #employeeId,
    onDelete: KeyAction.setNull,
  )();
  DateTimeColumn get registeredDate =>
      dateTime().nullable().withDefault(currentDateAndTime)();
  TextColumn get ipAddress => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdDate =>
      dateTime().nullable().withDefault(currentDateAndTime)();
  DateTimeColumn get lastUpdatedDate => dateTime().nullable()();

  @override
  List<String> get customConstraints => [
    "CHECK (device_type IN ('Mobile','Tablet','Desktop'))",
    "CHECK (os_type IN ('Android','iOS','Windows','MacOS','Linux'))",
    "CHECK (registration_status IN ('Pending','Approved','Rejected','Revoked'))",
  ];
}
