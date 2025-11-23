import 'dart:io';

import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:app_mobile_afms/core/reference_data/domain/reference_data_type.dart'
    show ReferenceDataType;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'tables/reference_data_tables.dart';
part 'app_database.g.dart';

/// Main database class using Drift.
///
/// This database serves as the local storage for offline-first architecture.
/// All data is stored here and synced with the server when online.
@DriftDatabase(
  tables: [
    ReferenceDataMetadataEntries,
    LabTestTypeEntries,
    EmployeeEntries,
    CustomerEntries,
    FarmEntries,
    PondEntries,
  ],
)
class AppDatabase extends _$AppDatabase {
  /// Creates a new instance of [AppDatabase].
  AppDatabase() : super(_openConnection());

  /// Database version.
  @override
  int get schemaVersion => AppConstants.databaseVersion;

  /// Migration callbacks.
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        AppLogger.info('Creating database schema version $schemaVersion');
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        AppLogger.info('Upgrading database from version $from to $to');
        // Migrations will be handled by migration files
        // TODO(team): Add migration logic here when schema changes
      },
      beforeOpen: (details) async {
        if (details.wasCreated) {
          AppLogger.info('Database created successfully');
        } else if (details.hadUpgrade) {
          AppLogger.info('Database upgraded successfully');
        }
      },
    );
  }

  /// Close database connection.
  @override
  Future<void> close() {
    AppLogger.info('Closing database connection');
    return super.close();
  }
}

/// Open database connection.
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, AppConstants.databaseName));

    AppLogger.info('Opening database at: ${file.path}');

    return NativeDatabase.createInBackground(file);
  });
}
