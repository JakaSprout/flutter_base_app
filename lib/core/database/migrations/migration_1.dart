import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:drift/drift.dart';

/// Initial database migration.
///
/// This migration creates the initial database schema.
/// Add your tables here when creating the initial schema.
class Migration1 {
  /// Execute migration.
  static Future<void> execute(Migrator m) async {
    AppLogger.info('Executing migration 1: Initial schema');

    // TODO(team): Add table creation here when needed
    // Example:
    // await m.createTable(someTable);

    AppLogger.info('Migration 1 completed successfully');
  }
}
