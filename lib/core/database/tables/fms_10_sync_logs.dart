part of '../app_database.dart';

/// Comprehensive logging for all sync operations.
/// 100% matches backend PostgreSQL schema.
@DataClassName('Fms10SyncLog')
class Fms10SyncLogs extends Table {
  IntColumn get syncLogId => integer().autoIncrement()();
  TextColumn get deviceUuid => text().nullable().references(
    Fms10Devices,
    #deviceUuid,
    onDelete: KeyAction.setNull,
  )();
  IntColumn get employeeId => integer().nullable().references(
    FmsMtEmployees,
    #employeeId,
    onDelete: KeyAction.setNull,
  )();

  // Sync Operation Details
  TextColumn get syncType => text()();
  TextColumn get syncDirection => text()();
  TextColumn get tableNameRef =>
      text().named('table_name')(); // Renamed to avoid conflict
  TextColumn get recordUuid => text().nullable()();
  IntColumn get recordId => integer().nullable()();
  TextColumn get syncStatus => text()();
  TextColumn get syncMethod =>
      text().nullable().withDefault(const Constant('API'))();

  // Statistics
  IntColumn get recordsAttempted =>
      integer().nullable().withDefault(const Constant(0))();
  IntColumn get recordsSucceeded =>
      integer().nullable().withDefault(const Constant(0))();
  IntColumn get recordsFailed =>
      integer().nullable().withDefault(const Constant(0))();
  IntColumn get recordsConflicted =>
      integer().nullable().withDefault(const Constant(0))();
  RealColumn get syncDurationSeconds => real().nullable()();
  IntColumn get dataSizeBytes => integer().nullable()();

  // Error Details
  TextColumn get errorMessage => text().nullable()();
  TextColumn get errorStackTrace => text().nullable()();
  TextColumn get errorCode => text().nullable()();

  // Metadata (JSONB)
  TextColumn get syncMetadata => text().nullable()(); // JSONB
  TextColumn get changesSummary => text().nullable()(); // JSONB

  // Version Info
  TextColumn get clientAppVersion => text().nullable()();
  TextColumn get serverApiVersion => text().nullable()();
  TextColumn get networkType => text().nullable()();

  // Conflict Info
  BoolColumn get hadConflicts =>
      boolean().nullable().withDefault(const Constant(false))();
  TextColumn get conflictResolutionMethod => text().nullable()();
  IntColumn get conflictCount =>
      integer().nullable().withDefault(const Constant(0))();

  // Timestamps
  DateTimeColumn get syncStartedDate => dateTime().nullable()();
  DateTimeColumn get syncedDate =>
      dateTime().nullable().withDefault(currentDateAndTime)();
  DateTimeColumn get syncCompletedDate => dateTime().nullable()();

  @override
  List<String> get customConstraints => [
    "CHECK (sync_type IN ('Push','Pull','Conflict_Resolution','Initial_Sync','Full_Sync'))",
    "CHECK (sync_direction IN ('Upload','Download','Bidirectional'))",
    "CHECK (sync_status IN ('Success','Failed','Conflict','Pending','Partial'))",
    "CHECK (sync_method IN ('API','Background','Manual'))",
  ];
}
