import 'dart:io';

import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';
part 'tables/fms_10_agent_simulations.dart'; // Includes v_agent_simulation_daily
part 'tables/fms_10_capacity_references.dart'; // Includes _en & _id views
part 'tables/fms_10_devices.dart';
part 'tables/fms_10_harvest_simulations.dart';
part 'tables/fms_10_sync_conflicts.dart';
part 'tables/fms_10_sync_logs.dart';
// Table definitions (1 file per table, grouped if _en/_id variants)
part 'tables/fms_mt_employees.dart';
part 'tables/fms_mt_exchange_rates.dart';
part 'tables/fms_mt_farms.dart';
part 'tables/fms_mt_ponds.dart';
part 'tables/fms_mt_units.dart';
// View SQL definitions
part 'views/database_views.dart';

/// Main database class using Drift.
///
/// This database serves as the local storage for offline-first architecture.
/// All data is stored here and synced with the server when online.
/// AppDatabase - Fresh schema matching backend DDL 100%
/// All 11 tables + 4 views from PostgreSQL DDL
@DriftDatabase(
  tables: [
    // Master Data (5 tables)
    FmsMtEmployees,
    FmsMtFarms,
    FmsMtPonds,
    FmsMtUnits,
    FmsMtExchangeRates,

    // Module Data (6 tables)
    Fms10CapacityReferences,
    Fms10Devices,
    Fms10HarvestSimulations,
    Fms10AgentSimulations,
    Fms10SyncLogs,
    Fms10SyncConflicts,
  ],
  // Views created via custom SQL in onCreate (see migration strategy)
)
class AppDatabase extends _$AppDatabase {
  /// Creates a new instance of [AppDatabase].
  AppDatabase() : super(_openConnection());

  /// Database version - Fresh schema
  @override
  int get schemaVersion => 1;

  /// Migration strategy - Fresh database only
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        AppLogger.info('[DB] Creating fresh schema v$schemaVersion');

        // Enable foreign keys first
        await customStatement('PRAGMA foreign_keys = ON;');

        // Create all 11 tables
        await m.createAll();
        AppLogger.info('[DB] ✅ Created 11 tables');

        // Create all 4 views
        await _createAllViews();
        AppLogger.info('[DB] ✅ Created 4 views');

        // Register device
        await _registerCurrentDevice();

        AppLogger.info('[DB] ✅ Fresh database ready');
      },
      beforeOpen: (details) async {
        // Always enable foreign keys
        await customStatement('PRAGMA foreign_keys = ON;');
        AppLogger.info('[DB] Opened (v${details.versionNow})');
      },
    );
  }

  /// Create all 4 database views
  Future<void> _createAllViews() async {
    await customStatement(DatabaseViews.capacityReferencesEn);
    await customStatement(DatabaseViews.capacityReferencesId);
    await customStatement(DatabaseViews.agentSimulationDaily);
    await customStatement(DatabaseViews.simulationHarvestDaily);
  }

  /// Register current device on first launch.
  Future<void> _registerCurrentDevice() async {
    try {
      AppLogger.info('[DB] Device registration placeholder');
      // Will be implemented when needed
    } catch (e, st) {
      AppLogger.warning('[DB] Device registration skipped: $e');
    }
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
