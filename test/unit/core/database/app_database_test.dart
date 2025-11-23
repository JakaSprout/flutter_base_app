import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/core/database/app_database.dart';
import 'package:drift/drift.dart' hide isNotNull;
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Initialize Flutter binding for tests that need platform channels
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppDatabase', () {
    late AppDatabase database;

    setUp(() {
      // Create database instance
      // Note: This will use the real connection which requires path_provider
      // For unit tests, we focus on testing properties and migration strategy
      // that don't require actual database connection
      database = AppDatabase();
    });

    tearDown(() async {
      // Close database after each test
      try {
        await database.close();
      } catch (e) {
        // Ignore errors if already closed or if connection wasn't established
      }
    });

    group('initialization', () {
      test('should create database instance', () {
        // Assert
        expect(database, isNotNull);
        expect(database, isA<AppDatabase>());
      });

      test('should have correct schema version', () {
        // Assert
        expect(database.schemaVersion, equals(AppConstants.databaseVersion));
        expect(database.schemaVersion, equals(1));
      });

      test('should have migration strategy configured', () {
        // Act
        final migration = database.migration;

        // Assert
        expect(migration, isNotNull);
        expect(migration, isA<MigrationStrategy>());
      });
    });

    group('migration', () {
      test('should have migration strategy', () {
        // Act
        final migration = database.migration;

        // Assert
        expect(migration, isNotNull);
        expect(migration, isA<MigrationStrategy>());
      });

      test('should have onCreate callback', () {
        // Act
        final migration = database.migration;

        // Assert
        expect(migration.onCreate, isNotNull);
      });

      test('should have onUpgrade callback', () {
        // Act
        final migration = database.migration;

        // Assert
        expect(migration.onUpgrade, isNotNull);
      });

      test('should have beforeOpen callback', () {
        // Act
        final migration = database.migration;

        // Assert
        expect(migration.beforeOpen, isNotNull);
      });

      test('should have migration strategy with all callbacks configured', () {
        // Act
        final migration = database.migration;

        // Assert
        expect(migration.onCreate, isNotNull);
        expect(migration.onUpgrade, isNotNull);
        expect(migration.beforeOpen, isNotNull);
      });
    });

    group('close', () {
      test('should close database connection', () async {
        // Act
        await database.close();

        // Assert
        // Verify close completed without errors
        expect(() => database.close(), returnsNormally);
      });

      test('should allow multiple close calls', () async {
        // Act
        await database.close();
        await database.close();

        // Assert
        // Multiple close calls should not throw
        expect(() => database.close(), returnsNormally);
      });

      test('should not throw when closing already closed database', () async {
        // Arrange
        await database.close();

        // Act & Assert
        expect(() => database.close(), returnsNormally);
        await database.close();
        // Should complete without errors
        expect(true, isTrue);
      });
    });

    group('database configuration', () {
      test('should have correct database name constant', () {
        // Assert
        expect(AppConstants.databaseName, equals('flutter_base_app.db'));
      });

      test('should have correct database version constant', () {
        // Assert
        expect(AppConstants.databaseVersion, equals(1));
        expect(database.schemaVersion, equals(AppConstants.databaseVersion));
      });
    });
  });
}
