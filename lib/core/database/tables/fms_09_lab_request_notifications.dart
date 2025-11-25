part of '../app_database.dart';

/// Lab request notifications table.
/// 100% matches backend PostgreSQL schema.
/// Based on schema.sql - fms_09_lab_request_notifications
@DataClassName('Fms09LabRequestNotification')
class Fms09LabRequestNotifications extends Table {
  @override
  String get tableName => 'fms_09_lab_request_notifications';

  IntColumn get notificationId => integer().autoIncrement()();
  IntColumn get requestId => integer()();
  TextColumn get notificationType => text()();
  TextColumn get notificationTrigger => text()();
  TextColumn get recipientType => text()();
  TextColumn get recipientName => text()();
  TextColumn get recipientContact => text()();
  TextColumn get messageContent => text()();
  TextColumn get messageTemplate => text()();
  TextColumn get templateVariables => text().nullable()();
  DateTimeColumn get scheduledDateTime => dateTime().nullable()();
  DateTimeColumn get sentDateTime => dateTime().nullable()();
  TextColumn get deliveryStatus =>
      text().withDefault(const Constant('Pending'))();
  TextColumn get deliveryStatusDetail => text().nullable()();
  TextColumn get failureReason => text().nullable()();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  IntColumn get maxRetries => integer().withDefault(const Constant(3))();
  DateTimeColumn get lastRetryDateTime => dateTime().nullable()();
  DateTimeColumn get nextRetryDateTime => dateTime().nullable()();
  TextColumn get messageId => text().nullable()();
  TextColumn get apiResponse => text().nullable()();
  DateTimeColumn get createdDate =>
      dateTime().withDefault(currentDateAndTime)();
}
