part of '../app_database.dart';

/// Lab request histories table for audit trail.
/// 100% matches backend PostgreSQL schema.
/// Based on schema.sql - fms_09_lab_request_histories
@DataClassName('Fms09LabRequestHistory')
class Fms09LabRequestHistories extends Table {
  @override
  String get tableName => 'fms_09_lab_request_histories';

  IntColumn get historyId => integer().autoIncrement()();
  IntColumn get requestId => integer()();
  TextColumn get action => text()();
  TextColumn get oldStatus => text().nullable()();
  TextColumn get newStatus => text().nullable()();
  TextColumn get changeDetails => text().nullable()();
  TextColumn get changedFields => text().nullable()();
  TextColumn get changedBy => text()();
  IntColumn get employeeId => integer().nullable()();
  TextColumn get ipAddress => text().nullable()();
  TextColumn get userAgent => text().nullable()();
  DateTimeColumn get actionDateTime =>
      dateTime().withDefault(currentDateAndTime)();
}
