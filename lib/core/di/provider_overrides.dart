import 'package:flutter_base_app/core/config/app_config.dart';
import 'package:flutter_base_app/core/database/app_database.dart';
import 'package:flutter_base_app/core/di/providers/database_provider.dart';
import 'package:flutter_base_app/core/di/providers/dio_provider.dart';
import 'package:flutter_base_app/core/di/providers/secure_storage_provider.dart';
import 'package:flutter_base_app/core/network/dio_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provider overrides for testing.
///
/// This file contains provider overrides that can be used during testing
/// to replace real implementations with mocks or test implementations.
///
/// Usage:
/// ```dart
/// final container = ProviderContainer(
///   overrides: [
///     ...testProviderOverrides,
///   ],
/// );
/// ```

/// Test provider overrides for all core services.
///
/// This list contains overrides for:
/// - AppConfig (uses dev config)
/// - FlutterSecureStorage (uses in-memory storage)
/// - DioClient (uses test Dio instance)
/// - AppDatabase (uses in-memory database)
/// - ConnectivityService (uses mock connectivity)
/// - Logger (uses test logger)
final List<Override> testProviderOverrides = [
  // Override AppConfig to use dev config for testing
  appConfigProvider.overrideWithValue(AppConfig.dev),

  // Override FlutterSecureStorage with in-memory storage for testing
  secureStorageProvider.overrideWithValue(
    const FlutterSecureStorage(
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock_this_device,
      ),
    ),
  ),

  // Override DioClient with test configuration
  dioClientProvider.overrideWith((ref) {
    final config = ref.watch(appConfigProvider);
    final secureStorage = ref.watch(secureStorageProvider);
    return DioClient(config: config, secureStorage: secureStorage);
  }),

  // Override Database with in-memory database for testing
  // Note: You may need to create a test database implementation
  // databaseProvider.overrideWith(...),

  // Override ConnectivityService with mock for testing
  // connectivityServiceProvider.overrideWith(...),

  // Override Logger with test logger
  // loggerProvider.overrideWith(...),
];

/// Create provider overrides for a specific test scenario.
///
/// This function allows you to create custom provider overrides for
/// specific test scenarios.
///
/// Example:
/// ```dart
/// final overrides = createTestOverrides(
///   appConfig: AppConfig.staging,
///   secureStorage: mockSecureStorage,
/// );
/// ```
List<Override> createTestOverrides({
  AppConfig? appConfig,
  FlutterSecureStorage? secureStorage,
  DioClient? dioClient,
  AppDatabase? database,
}) {
  final overrides = <Override>[];

  if (appConfig != null) {
    overrides.add(appConfigProvider.overrideWithValue(appConfig));
  }

  if (secureStorage != null) {
    overrides.add(secureStorageProvider.overrideWithValue(secureStorage));
  }

  if (dioClient != null) {
    overrides.add(dioClientProvider.overrideWithValue(dioClient));
  }

  if (database != null) {
    overrides.add(databaseProvider.overrideWithValue(database));
  }

  return overrides;
}
