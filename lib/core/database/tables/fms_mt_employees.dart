part of '../app_database.dart';

/// Master data table for employees.
/// 100% matches backend PostgreSQL schema.
@DataClassName('FmsMtEmployee')
class FmsMtEmployees extends Table {
  IntColumn get employeeId => integer().autoIncrement()();
  TextColumn get employeeUuid => text().unique()();
  TextColumn get employeeCode => text().unique()();
  TextColumn get employeeName => text()();
  TextColumn get username => text().nullable().unique()();
  TextColumn get hashedPassword => text().nullable()();
  TextColumn get employeeRole => text().nullable()();
  TextColumn get userAccessLevel => text().nullable()();
  TextColumn get employeeStatus =>
      text().nullable().withDefault(const Constant('Active'))();
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
      dateTime().nullable().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedDate => dateTime().nullable()();

  @override
  List<String> get customConstraints => [
    "CHECK (employee_role IN ('Admin','Manager','Technician','Lab_Technician','HO'))",
    "CHECK (user_access_level IN ('Full','Limited','Read_Only'))",
    "CHECK (employee_status IN ('Active','Inactive'))",
  ];
}
