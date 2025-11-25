part of '../app_database.dart';

/// Conflict detection and resolution for offline-online sync.
/// 100% matches backend PostgreSQL schema.
@DataClassName('Fms10SyncConflict')
class Fms10SyncConflicts extends Table {
  IntColumn get conflictId => integer().autoIncrement()();
  TextColumn get tableNameRef =>
      text().named('table_name')(); // Renamed to avoid conflict
  TextColumn get recordUuid => text()();
  IntColumn get recordId => integer().nullable()();

  // Conflict Data (JSONB)
  TextColumn get serverData => text()(); // JSONB
  TextColumn get clientData => text()(); // JSONB
  TextColumn get diffAnalysis => text().nullable()(); // JSONB

  // Timestamps
  DateTimeColumn get serverUpdatedDate => dateTime().nullable()();
  DateTimeColumn get clientUpdatedDate => dateTime().nullable()();
  DateTimeColumn get serverCreatedDate => dateTime().nullable()();
  DateTimeColumn get clientCreatedDate => dateTime().nullable()();

  // Resolution
  BoolColumn get isResolved =>
      boolean().nullable().withDefault(const Constant(false))();
  TextColumn get resolutionMethod => text().nullable()();
  TextColumn get resolutionStrategy => text().nullable()();
  IntColumn get resolvedBy => integer().nullable().references(
    FmsMtEmployees,
    #employeeId,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get resolutionNotes => text().nullable()();
  TextColumn get mergedData => text().nullable()(); // JSONB

  // Conflict Classification
  TextColumn get conflictType => text()();
  TextColumn get conflictSeverity =>
      text().nullable().withDefault(const Constant('Medium'))();
  IntColumn get priority =>
      integer().nullable().withDefault(const Constant(5))();

  // Timestamps
  DateTimeColumn get createdDate =>
      dateTime().nullable().withDefault(currentDateAndTime)();
  DateTimeColumn get detectedDate =>
      dateTime().nullable().withDefault(currentDateAndTime)();
  DateTimeColumn get resolvedDate => dateTime().nullable()();
  DateTimeColumn get appliedDate => dateTime().nullable()();
  IntColumn get createdBy => integer().nullable().references(
    FmsMtEmployees,
    #employeeId,
    onDelete: KeyAction.setNull,
  )();

  // Grouping
  IntColumn get relatedConflictId => integer().nullable().references(
    Fms10SyncConflicts,
    #conflictId,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get conflictBatchId => text().nullable()();

  @override
  List<String> get customConstraints => [
    "CHECK (conflict_type IN ('Update_Update','Update_Delete','Create_Create'))",
    "CHECK (conflict_severity IN ('Low','Medium','High','Critical'))",
    "CHECK (resolution_method IN ('Server_Wins','Client_Wins','Manual_Merge','Latest_Wins'))",
    "CHECK (resolution_strategy IN ('Timestamp','Version','User_Choice'))",
    'CHECK (priority >= 1 AND priority <= 10)',
  ];
}
