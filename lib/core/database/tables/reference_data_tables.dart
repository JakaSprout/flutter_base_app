part of 'package:app_mobile_afms/core/database/app_database.dart';

/// Metadata table to track reference data sync per user and type.
class ReferenceDataMetadataEntries extends Table {
  /// User identifier (scopes metadata per user).
  TextColumn get userId => text()();

  /// Reference data type (see [ReferenceDataType]).
  TextColumn get dataType => text()();

  /// Last successful fetch timestamp.
  DateTimeColumn get lastFetchedAt => dateTime()();

  /// Last update timestamp reported by server.
  DateTimeColumn get lastUpdatedAt => dateTime().nullable()();

  /// Optional server-provided version (x-version header).
  TextColumn get version => text().nullable()();

  /// Optional ETag header for conditional requests.
  TextColumn get etag => text().nullable()();

  /// Number of records stored for this data type.
  IntColumn get recordCount => integer().withDefault(const Constant(0))();

  /// Sync status string (idle, syncing, error, cached, etc.).
  TextColumn get syncStatus => text().withDefault(const Constant('idle'))();

  /// Last error message if sync failed.
  TextColumn get lastError => text().nullable()();

  /// Retry attempt counter.
  IntColumn get retryCount => integer().withDefault(const Constant(0))();

  /// Created timestamp.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Updated timestamp.
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {userId, dataType};
}

/// Reference data table for lab test types.
class LabTestTypeEntries extends Table {
  TextColumn get userId => text()();
  TextColumn get labTestTypeId => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  IntColumn get displayOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {userId, labTestTypeId};
}

/// Reference data table for employees.
class EmployeeEntries extends Table {
  TextColumn get userId => text()();
  IntColumn get employeeId => integer()();
  TextColumn get name => text()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get position => text().nullable()();
  TextColumn get department => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {userId, employeeId};
}

/// Reference data table for customers.
class CustomerEntries extends Table {
  TextColumn get userId => text()();
  IntColumn get customerId => integer()();
  TextColumn get name => text()();
  TextColumn get code => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get address => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {userId, customerId};
}

/// Reference data table for farms.
class FarmEntries extends Table {
  TextColumn get userId => text()();
  IntColumn get farmId => integer()();
  TextColumn get name => text()();
  TextColumn get code => text().nullable()();
  TextColumn get address => text().nullable()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {userId, farmId};
}

/// Reference data table for ponds.
class PondEntries extends Table {
  TextColumn get userId => text()();
  IntColumn get pondId => integer()();
  IntColumn get farmId => integer().nullable()();
  TextColumn get name => text()();
  TextColumn get code => text().nullable()();
  RealColumn get areaSqm => real().nullable()();
  TextColumn get status => text().withDefault(const Constant('Available'))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {userId, pondId};

  @override
  List<String> get customConstraints => [
    "CONSTRAINT pond_status CHECK (status IN ('Available','In_Production','Maintenance','Closed'))",
  ];
}
