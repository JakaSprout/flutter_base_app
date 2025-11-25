part of '../app_database.dart';

/// Master data table for employees.
/// 100% matches backend PostgreSQL schema.
/// Based on schema.sql - fms_mt_employees
@DataClassName('FmsMtEmployee')
class FmsMtEmployees extends Table {
  IntColumn get employeeId => integer().autoIncrement()();
  TextColumn get employeeUuid => text().unique().withDefault(
    const Constant(
      "lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-' || substr('89ab',abs(random()) % 4 + 1, 1) || substr(lower(hex(randomblob(2))),2) || '-' || lower(hex(randomblob(6)))",
    ),
  )();
  TextColumn get employeeCode => text().unique()();
  TextColumn get employeeName => text()();
  TextColumn get username => text().nullable().unique()();
  TextColumn get hashedPassword => text().nullable()();
  TextColumn get employeeRole => text().nullable()();
  TextColumn get userAccessLevel => text().nullable()();
  TextColumn get employeeStatus =>
      text().withDefault(const Constant('Active'))();
  TextColumn get email => text().nullable().unique()();
  TextColumn get phoneNumber => text().nullable()();
  TextColumn get address => text().nullable()();
  DateTimeColumn get hireDate => dateTime().nullable()();
  IntColumn get reportingTo => integer().nullable().references(
    FmsMtEmployees,
    #employeeId,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get department => text().nullable()();
  DateTimeColumn get createdDate =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedDate => dateTime().nullable()();

  @override
  List<String> get customConstraints => [
    "CHECK (employee_role IN ('Admin','Manager','Technician','Lab_Technician','HO'))",
    "CHECK (user_access_level IN ('Full','Limited','Read_Only'))",
    "CHECK (employee_status IN ('Active','Inactive'))",
  ];
}
