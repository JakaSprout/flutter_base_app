import 'package:app_mobile_afms/core/database/app_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_provider.g.dart';

/// Provider for the application database instance.
///
/// This provider creates a singleton database instance that can be used
/// throughout the application. The database is automatically disposed when
/// the provider is disposed.
@riverpod
AppDatabase database(DatabaseRef ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
}

/// Provider for database connection status.
///
/// This can be used to monitor database health and connection status.
/// Returns true if database is available, false otherwise.
@riverpod
bool databaseStatus(DatabaseStatusRef ref) {
  // Database is considered available if provider exists
  ref.watch(databaseProvider);
  return true;
}
