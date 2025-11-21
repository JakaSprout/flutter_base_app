import 'package:flutter_base_app/core/config/app_config.dart';
import 'package:flutter_base_app/core/database/app_database.dart';
import 'package:flutter_base_app/core/di/provider_overrides.dart';
import 'package:flutter_base_app/core/di/providers/database_provider.dart';
import 'package:flutter_base_app/core/di/providers/dio_provider.dart';
import 'package:flutter_base_app/core/di/providers/secure_storage_provider.dart';
import 'package:flutter_base_app/core/network/dio_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  group('testProviderOverrides', () {
    test('should contain appConfigProvider override', () {
      // Act
      final container = ProviderContainer(
        overrides: testProviderOverrides,
      );

      // Assert
      final config = container.read(appConfigProvider);
      expect(config, isA<AppConfig>());
      expect(config.flavor, equals(AppFlavor.dev));

      container.dispose();
    });

    test('should contain secureStorageProvider override', () {
      // Act
      final container = ProviderContainer(
        overrides: testProviderOverrides,
      );

      // Assert
      final secureStorage = container.read(secureStorageProvider);
      expect(secureStorage, isA<FlutterSecureStorage>());

      container.dispose();
    });

    test('should contain dioClientProvider override', () {
      // Act
      final container = ProviderContainer(
        overrides: testProviderOverrides,
      );

      // Assert
      final dioClient = container.read(dioClientProvider);
      expect(dioClient, isA<DioClient>());

      container.dispose();
    });

    test('should work with ProviderContainer', () {
      // Act
      final container = ProviderContainer(
        overrides: testProviderOverrides,
      );

      // Assert - All providers should be accessible
      expect(container.read(appConfigProvider), isA<AppConfig>());
      expect(container.read(secureStorageProvider), isA<FlutterSecureStorage>());
      expect(container.read(dioClientProvider), isA<DioClient>());

      container.dispose();
    });
  });

  group('createTestOverrides', () {
    test('should create empty overrides when no parameters provided', () {
      // Act
      final overrides = createTestOverrides();

      // Assert
      expect(overrides, isEmpty);
    });

    test('should create override for appConfig', () {
      // Arrange
      const testConfig = AppConfig.staging;

      // Act
      final overrides = createTestOverrides(appConfig: testConfig);

      // Assert
      expect(overrides.length, equals(1));

      // Verify override works
      final container = ProviderContainer(overrides: overrides);
      final config = container.read(appConfigProvider);
      expect(config.flavor, equals(AppFlavor.staging));
      expect(config, same(testConfig));

      container.dispose();
    });

    test('should create override for secureStorage', () {
      // Arrange
      const testStorage = FlutterSecureStorage();

      // Act
      final overrides = createTestOverrides(secureStorage: testStorage);

      // Assert
      expect(overrides.length, equals(1));

      // Verify override works
      final container = ProviderContainer(overrides: overrides);
      final storage = container.read(secureStorageProvider);
      expect(storage, same(testStorage));

      container.dispose();
    });

    test('should create override for dioClient', () {
      // Arrange
      const testConfig = AppConfig.dev;
      const testStorage = FlutterSecureStorage();
      final testDioClient = DioClient(
        config: testConfig,
        secureStorage: testStorage,
      );

      // Act
      final overrides = createTestOverrides(dioClient: testDioClient);

      // Assert
      expect(overrides.length, equals(1));

      // Verify override works
      final container = ProviderContainer(overrides: overrides);
      final dioClient = container.read(dioClientProvider);
      expect(dioClient, same(testDioClient));

      container.dispose();
    });

    test('should create override for database', () {
      // Arrange
      final testDatabase = AppDatabase();

      // Act
      final overrides = createTestOverrides(database: testDatabase);

      // Assert
      expect(overrides.length, equals(1));

      // Verify override works
      final container = ProviderContainer(overrides: overrides);
      final database = container.read(databaseProvider);
      expect(database, same(testDatabase));

      container.dispose();
    });

    test('should create multiple overrides when multiple parameters provided', () {
      // Arrange
      const testConfig = AppConfig.staging;
      const testStorage = FlutterSecureStorage();

      // Act
      final overrides = createTestOverrides(
        appConfig: testConfig,
        secureStorage: testStorage,
      );

      // Assert
      expect(overrides.length, equals(2));

      // Verify overrides work
      final container = ProviderContainer(overrides: overrides);
      expect(container.read(appConfigProvider).flavor, equals(AppFlavor.staging));
      expect(container.read(secureStorageProvider), same(testStorage));

      container.dispose();
    });

    test('should create all overrides when all parameters provided', () {
      // Arrange
      const testConfig = AppConfig.prod;
      const testStorage = FlutterSecureStorage();
      final testDioClient = DioClient(
        config: testConfig,
        secureStorage: testStorage,
      );
      final testDatabase = AppDatabase();

      // Act
      final overrides = createTestOverrides(
        appConfig: testConfig,
        secureStorage: testStorage,
        dioClient: testDioClient,
        database: testDatabase,
      );

      // Assert
      expect(overrides.length, equals(4));

      // Verify all overrides work
      final container = ProviderContainer(overrides: overrides);
      expect(container.read(appConfigProvider).flavor, equals(AppFlavor.prod));
      expect(container.read(secureStorageProvider), same(testStorage));
      expect(container.read(dioClientProvider), same(testDioClient));
      expect(container.read(databaseProvider), same(testDatabase));

      container.dispose();
    });
  });
}

