import 'dart:async';

import 'package:app_mobile_afms/core/connectivity/connectivity_models.dart';
import 'package:app_mobile_afms/core/database/app_database.dart';
import 'package:app_mobile_afms/core/di/providers/connectivity_provider.dart';
import 'package:app_mobile_afms/core/di/providers/database_provider.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:app_mobile_afms/core/reference_data/data/datasources/local/reference_data_local_datasource.dart';
import 'package:app_mobile_afms/core/reference_data/domain/repositories/reference_data_repository.dart';
import 'package:app_mobile_afms/core/utils/helpers/device_info_helper.dart';
import 'package:app_mobile_afms/core/utils/helpers/device_uuid_helper.dart';
import 'package:drift/drift.dart' as drift;
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Result of master data sync operation.
class MasterDataSyncResult {
  const MasterDataSyncResult({
    required this.success,
    required this.syncedDataTypes,
    required this.failedDataTypes,
    required this.totalRecordsSynced,
    required this.duration,
    required this.wasOffline,
  });

  final bool success;
  final List<String> syncedDataTypes;
  final List<String> failedDataTypes;
  final int totalRecordsSynced;
  final Duration duration;
  final bool wasOffline;

  bool get hasFailures => failedDataTypes.isNotEmpty;

  @override
  String toString() {
    return 'MasterDataSyncResult(success: $success, '
        'synced: $syncedDataTypes, '
        'failed: $failedDataTypes, '
        'records: $totalRecordsSynced, '
        'offline: $wasOffline, '
        'duration: ${duration.inMilliseconds}ms)';
  }
}

/// Service for synchronizing master/reference data.
///
/// This service implements the offline-first flow:
/// 1. Check connectivity
/// 2. If offline: Load from local SQLite
/// 3. If online: Download from API and store locally
///
/// Includes caching to prevent excessive sync calls.
class MasterDataSyncService {
  MasterDataSyncService({
    required this.ref,
    required this.repository,
    required this.localDatasource,
  }) : _instanceId = DateTime.now().millisecondsSinceEpoch;

  final Ref ref;
  final ReferenceDataRepository repository;
  final ReferenceDataLocalDatasource localDatasource;
  final int _instanceId;

  // Static cache to prevent excessive sync calls
  static DateTime? _lastSyncTime;
  static MasterDataSyncResult? _cachedResult;

  /// Sync master data based on connectivity status.
  ///
  /// According to the flowchart:
  /// - If offline: Load from local SQLite (fms_10_capacity_references, fms_mt_units, fms_mt_ponds, fms_mt_employees)
  /// - If online: Download from API and store locally
  ///
  /// Uses caching to prevent excessive sync calls within 5 minutes.
  Future<MasterDataSyncResult> syncMasterData({
    required String employeeId,
    bool forceOnline = false,
  }) async {
    final startTime = DateTime.now();

    // Check if we have a recent cached result (within last 5 minutes)
    if (_cachedResult != null && _lastSyncTime != null && !forceOnline) {
      final timeSinceLastSync = DateTime.now().difference(_lastSyncTime!);
      AppLogger.debug(
        '[MasterDataSync] Cache check (instance: $_instanceId): timeSinceLastSync=${timeSinceLastSync.inSeconds}s, '
        'cachedResult=${_cachedResult != null}, lastSyncTime=${_lastSyncTime != null}',
      );
      if (timeSinceLastSync.inMinutes < 5) {
        AppLogger.info(
          '[MasterDataSync] Using cached result from ${timeSinceLastSync.inSeconds}s ago (instance: $_instanceId)',
        );
        return _cachedResult!;
      }
    } else {
      AppLogger.debug(
        '[MasterDataSync] Cache not available (instance: $_instanceId): cachedResult=${_cachedResult != null}, '
        'lastSyncTime=${_lastSyncTime != null}, forceOnline=$forceOnline',
      );
    }

    AppLogger.info(
      '[MasterDataSync] Starting master data sync for employee: $employeeId (instance: $_instanceId)',
    );

    // Check connectivity
    final connectivityAsync = ref.read(connectivityStatusProvider);
    final connectivityResult = connectivityAsync.when(
      data: (status) => status,
      loading: () => const AppConnectivityResult(
        status: ConnectivityStatus.disconnected,
        message: 'Connectivity check in progress',
      ),
      error: (_, __) => const AppConnectivityResult(
        status: ConnectivityStatus.disconnected,
        message: 'Connectivity check failed',
      ),
    );

    final isOnline = connectivityResult.isConnected || forceOnline;
    AppLogger.info(
      '[MasterDataSync] Connectivity status: ${connectivityResult.status}, online: $isOnline',
    );

    late final MasterDataSyncResult result;
    if (!isOnline) {
      // OFFLINE MODE: Load from local SQLite
      AppLogger.info(
        '[MasterDataSync] Offline mode - loading from local database',
      );
      result = await _loadFromLocalDatabase(employeeId, startTime);
    } else {
      // ONLINE MODE: Download and sync
      AppLogger.info(
        '[MasterDataSync] Online mode - downloading from API and syncing',
      );
      result = await _syncFromApi(employeeId, startTime);
    }

    // Cache the result
    _cachedResult = result;
    _lastSyncTime = DateTime.now();

    return result;
  }

  /// Load master data from local SQLite database (offline mode).
  Future<MasterDataSyncResult> _loadFromLocalDatabase(
    String employeeId,
    DateTime startTime,
  ) async {
    final syncedDataTypes = <String>[];
    final failedDataTypes = <String>[];
    var totalRecords = 0;

    // Load capacity references
    try {
      final capacityRefsResult = await localDatasource.getCapacityReferences();
      capacityRefsResult.fold(
        (failure) {
          AppLogger.warning(
            '[MasterDataSync] Failed to load capacity references: $failure',
          );
          failedDataTypes.add('capacity_references');
        },
        (refs) {
          totalRecords += refs.length;
          syncedDataTypes.add('capacity_references');
          AppLogger.debug(
            '[MasterDataSync] Loaded ${refs.length} capacity references from local DB',
          );
        },
      );
    } catch (e) {
      AppLogger.error('[MasterDataSync] Error loading capacity references: $e');
      failedDataTypes.add('capacity_references');
    }

    // Load units
    try {
      final unitsResult = await localDatasource.getUnits();
      unitsResult.fold(
        (failure) {
          AppLogger.warning('[MasterDataSync] Failed to load units: $failure');
          failedDataTypes.add('units');
        },
        (units) {
          totalRecords += units.length;
          syncedDataTypes.add('units');
          AppLogger.debug(
            '[MasterDataSync] Loaded ${units.length} units from local DB',
          );
        },
      );
    } catch (e) {
      AppLogger.error('[MasterDataSync] Error loading units: $e');
      failedDataTypes.add('units');
    }

    // Load ponds
    try {
      final pondsResult = await localDatasource.getPonds();
      pondsResult.fold(
        (failure) {
          AppLogger.warning('[MasterDataSync] Failed to load ponds: $failure');
          failedDataTypes.add('ponds');
        },
        (ponds) {
          totalRecords += ponds.length;
          syncedDataTypes.add('ponds');
          AppLogger.debug(
            '[MasterDataSync] Loaded ${ponds.length} ponds from local DB',
          );
        },
      );
    } catch (e) {
      AppLogger.error('[MasterDataSync] Error loading ponds: $e');
      failedDataTypes.add('ponds');
    }

    // Load employees
    try {
      final employeesResult = await localDatasource.getEmployees();
      employeesResult.fold(
        (failure) {
          AppLogger.warning(
            '[MasterDataSync] Failed to load employees: $failure',
          );
          failedDataTypes.add('employees');
        },
        (employees) {
          totalRecords += employees.length;
          syncedDataTypes.add('employees');
          AppLogger.debug(
            '[MasterDataSync] Loaded ${employees.length} employees from local DB',
          );
        },
      );
    } catch (e) {
      AppLogger.error('[MasterDataSync] Error loading employees: $e');
      failedDataTypes.add('employees');
    }

    final duration = DateTime.now().difference(startTime);
    final success = failedDataTypes.isEmpty;

    final result = MasterDataSyncResult(
      success: success,
      syncedDataTypes: syncedDataTypes,
      failedDataTypes: failedDataTypes,
      totalRecordsSynced: totalRecords,
      duration: duration,
      wasOffline: true,
    );

    AppLogger.info('[MasterDataSync] Completed offline sync: $result');
    return result;
  }

  /// Sync master data from API and store locally (online mode).
  Future<MasterDataSyncResult> _syncFromApi(
    String employeeId,
    DateTime startTime,
  ) async {
    final syncedDataTypes = <String>[];
    final failedDataTypes = <String>[];
    var totalRecords = 0;

    // Register device if not already registered
    final deviceRegistered = await _ensureDeviceRegistration(employeeId);
    if (!deviceRegistered) {
      AppLogger.warning(
        '[MasterDataSync] Device registration failed, proceeding with data sync',
      );
    }

    // Sync capacity references
    try {
      final apiResult = await repository.getCapacityReferences(employeeId);
      await apiResult.fold(
        (failure) async {
          AppLogger.warning(
            '[MasterDataSync] Failed to fetch capacity references from API: $failure',
          );
          failedDataTypes.add('capacity_references');
        },
        (refs) async {
          final saveResult = await localDatasource.saveCapacityReferences(refs);
          await saveResult.fold(
            (saveFailure) {
              AppLogger.error(
                '[MasterDataSync] Failed to save capacity references: $saveFailure',
              );
              failedDataTypes.add('capacity_references');
            },
            (savedCount) {
              totalRecords += savedCount;
              syncedDataTypes.add('capacity_references');
              AppLogger.debug(
                '[MasterDataSync] Synced $savedCount capacity references',
              );
            },
          );
        },
      );
    } catch (e) {
      AppLogger.error('[MasterDataSync] Error syncing capacity references: $e');
      failedDataTypes.add('capacity_references');
    }

    // Sync units
    try {
      final apiResult = await repository.getUnits(employeeId);
      await apiResult.fold(
        (failure) async {
          AppLogger.warning(
            '[MasterDataSync] Failed to fetch units from API: $failure',
          );
          failedDataTypes.add('units');
        },
        (units) async {
          final saveResult = await localDatasource.saveUnits(units);
          await saveResult.fold(
            (saveFailure) {
              AppLogger.error(
                '[MasterDataSync] Failed to save units: $saveFailure',
              );
              failedDataTypes.add('units');
            },
            (savedCount) {
              totalRecords += savedCount;
              syncedDataTypes.add('units');
              AppLogger.debug('[MasterDataSync] Synced $savedCount units');
            },
          );
        },
      );
    } catch (e) {
      AppLogger.error('[MasterDataSync] Error syncing units: $e');
      failedDataTypes.add('units');
    }

    // Sync ponds
    try {
      final apiResult = await repository.getPonds(employeeId);
      await apiResult.fold(
        (failure) async {
          AppLogger.warning(
            '[MasterDataSync] Failed to fetch ponds from API: $failure',
          );
          failedDataTypes.add('ponds');
        },
        (ponds) async {
          final saveResult = await localDatasource.savePonds(ponds);
          await saveResult.fold(
            (saveFailure) {
              AppLogger.error(
                '[MasterDataSync] Failed to save ponds: $saveFailure',
              );
              failedDataTypes.add('ponds');
            },
            (savedCount) {
              totalRecords += savedCount;
              syncedDataTypes.add('ponds');
              AppLogger.debug('[MasterDataSync] Synced $savedCount ponds');
            },
          );
        },
      );
    } catch (e) {
      AppLogger.error('[MasterDataSync] Error syncing ponds: $e');
      failedDataTypes.add('ponds');
    }

    // Sync employees
    try {
      final apiResult = await repository.getEmployees(employeeId);
      await apiResult.fold(
        (failure) async {
          AppLogger.warning(
            '[MasterDataSync] Failed to fetch employees from API: $failure',
          );
          failedDataTypes.add('employees');
        },
        (employees) async {
          final saveResult = await localDatasource.saveEmployees(employees);
          await saveResult.fold(
            (saveFailure) {
              AppLogger.error(
                '[MasterDataSync] Failed to save employees: $saveFailure',
              );
              failedDataTypes.add('employees');
            },
            (savedCount) {
              totalRecords += savedCount;
              syncedDataTypes.add('employees');
              AppLogger.debug('[MasterDataSync] Synced $savedCount employees');
            },
          );
        },
      );
    } catch (e) {
      AppLogger.error('[MasterDataSync] Error syncing employees: $e');
      failedDataTypes.add('employees');
    }

    final duration = DateTime.now().difference(startTime);
    final success = failedDataTypes.isEmpty;

    final result = MasterDataSyncResult(
      success: success,
      syncedDataTypes: syncedDataTypes,
      failedDataTypes: failedDataTypes,
      totalRecordsSynced: totalRecords,
      duration: duration,
      wasOffline: false,
    );

    AppLogger.info('[MasterDataSync] Completed online sync: $result');
    return result;
  }

  /// Ensure device is registered for sync operations.
  ///
  /// According to flowchart: Register device if not already registered.
  /// INSERT into fms_10_devices with device_uuid random UUID, employee_id, etc.
  Future<bool> _ensureDeviceRegistration(String employeeId) async {
    try {
      final database = ref.read(databaseProvider);

      // Get device UUID
      final deviceUuid = await DeviceUuidHelper.getOrGenerateUuid();

      // Check if device is already registered locally
      final existingDevice = await (database.select(
        database.fms10Devices,
      )..where((tbl) => tbl.deviceUuid.equals(deviceUuid))).getSingleOrNull();

      if (existingDevice != null &&
          existingDevice.registrationStatus == 'Approved') {
        AppLogger.debug(
          '[MasterDataSync] Device already registered: $deviceUuid',
        );
        return true;
      }

      // Get device info
      final deviceInfo = await DeviceInfoHelper.getDeviceInfo();

      // Register device locally (will be synced to server later)
      await database
          .into(database.fms10Devices)
          .insert(
            Fms10DevicesCompanion(
              deviceUuid: drift.Value(deviceUuid),
              employeeId: drift.Value(int.tryParse(employeeId) ?? 0),
              deviceName: drift.Value(deviceInfo['deviceName'] ?? 'Unknown'),
              deviceType: drift.Value(deviceInfo['deviceType'] ?? 'Mobile'),
              osType: drift.Value(deviceInfo['osType'] ?? 'Unknown'),
              osVersion: drift.Value(deviceInfo['osVersion'] ?? ''),
              appVersion: drift.Value(deviceInfo['appVersion'] ?? ''),
              deviceModel: drift.Value(deviceInfo['deviceModel'] ?? ''),
              deviceManufacturer: drift.Value(
                deviceInfo['deviceManufacturer'] ?? '',
              ),
              registrationStatus: const drift.Value(
                'Approved',
              ), // Auto-approve for local registration
              lastActiveDate: drift.Value(DateTime.now()),
              isActive: const drift.Value(true),
              isRegistered: const drift.Value(true),
            ),
            mode: drift.InsertMode.insertOrReplace,
          );

      AppLogger.info('[MasterDataSync] Device registered locally: $deviceUuid');
      return true;
    } catch (e) {
      AppLogger.error('[MasterDataSync] Failed to register device: $e');
      return false;
    }
  }
}
