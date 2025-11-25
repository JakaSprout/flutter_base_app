import 'dart:convert';

import 'package:app_mobile_afms/core/connectivity/connectivity_models.dart';
import 'package:app_mobile_afms/core/database/app_database.dart';
import 'package:app_mobile_afms/core/di/providers/connectivity_provider.dart';
import 'package:app_mobile_afms/core/di/providers/database_provider.dart';
import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:app_mobile_afms/core/utils/helpers/device_uuid_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart' as drift;
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Result of harvest simulation sync operation.
class HarvestSimulationSyncResult {
  const HarvestSimulationSyncResult({
    required this.success,
    required this.pushedCount,
    required this.pulledCount,
    required this.conflictsResolved,
    required this.duration,
    required this.wasOffline,
  });

  final bool success;
  final int pushedCount;
  final int pulledCount;
  final int conflictsResolved;
  final Duration duration;
  final bool wasOffline;

  @override
  String toString() {
    return 'HarvestSimulationSyncResult(success: $success, '
        'pushed: $pushedCount, pulled: $pulledCount, '
        'conflicts: $conflictsResolved, offline: $wasOffline, '
        'duration: ${duration.inMilliseconds}ms)';
  }
}

/// Service for synchronizing harvest simulations.
///
/// Implements push/pull sync with conflict resolution:
/// - Push unsynced simulations to server
/// - Pull simulations from server
/// - Resolve conflicts with "newest wins" strategy
class HarvestSimulationSyncService {
  const HarvestSimulationSyncService({required this.ref, required this.dio});

  final Ref ref;
  final Dio dio;

  /// Sync harvest simulations based on connectivity.
  ///
  /// According to flowchart:
  /// - Push unsynced data to server
  /// - Pull data from server
  /// - Handle conflicts with "newest wins" resolution
  Future<HarvestSimulationSyncResult> syncHarvestSimulations({
    required String employeeId,
  }) async {
    final startTime = DateTime.now();
    AppLogger.info(
      '[HarvestSync] Starting harvest simulation sync for employee: $employeeId',
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

    if (!connectivityResult.isConnected) {
      AppLogger.info('[HarvestSync] Offline - skipping sync');
      return HarvestSimulationSyncResult(
        success: true,
        pushedCount: 0,
        pulledCount: 0,
        conflictsResolved: 0,
        duration: DateTime.now().difference(startTime),
        wasOffline: true,
      );
    }

    var pushedCount = 0;
    var pulledCount = 0;
    var conflictsResolved = 0;

    try {
      // 1. Push unsynced data to server
      final pushResult = await _pushUnsyncedSimulations(employeeId);
      pushResult.fold(
        (failure) {
          AppLogger.warning(
            '[HarvestSync] Failed to push unsynced data: $failure',
          );
        },
        (count) {
          pushedCount = count;
          AppLogger.info(
            '[HarvestSync] Successfully pushed $count simulations',
          );
        },
      );

      // 2. Pull data from server
      final pullResult = await _pullSimulationsFromServer(employeeId);
      pullResult.fold(
        (failure) {
          AppLogger.warning(
            '[HarvestSync] Failed to pull data from server: $failure',
          );
        },
        (result) {
          pulledCount = result.$1;
          conflictsResolved = result.$2;
          AppLogger.info(
            '[HarvestSync] Successfully pulled $pulledCount simulations, resolved $conflictsResolved conflicts',
          );
        },
      );

      final duration = DateTime.now().difference(startTime);
      const success =
          true; // Even if some operations fail, consider sync successful

      final finalResult = HarvestSimulationSyncResult(
        success: success,
        pushedCount: pushedCount,
        pulledCount: pulledCount,
        conflictsResolved: conflictsResolved,
        duration: duration,
        wasOffline: false,
      );

      AppLogger.info('[HarvestSync] Completed sync: $finalResult');
      return finalResult;
    } catch (e) {
      AppLogger.error('[HarvestSync] Unexpected error during sync: $e');
      return HarvestSimulationSyncResult(
        success: false,
        pushedCount: pushedCount,
        pulledCount: pulledCount,
        conflictsResolved: conflictsResolved,
        duration: DateTime.now().difference(startTime),
        wasOffline: false,
      );
    }
  }

  /// Push unsynced harvest simulations to server.
  Future<Either<Failure, int>> _pushUnsyncedSimulations(
    String employeeId,
  ) async {
    try {
      final database = ref.read(databaseProvider);
      final deviceUuid = await DeviceUuidHelper.getOrGenerateUuid();

      // Get unsynced simulations for this employee and device
      final unsyncedSimulations =
          await (database.select(database.fms10HarvestSimulations)..where(
                (tbl) =>
                    tbl.employeeId.equals(int.tryParse(employeeId) ?? 0) &
                    tbl.deviceUuid.equals(deviceUuid) &
                    tbl.isSynced.equals(false) &
                    tbl.deletedDate.isNull(),
              ))
              .get();

      if (unsyncedSimulations.isEmpty) {
        AppLogger.debug('[HarvestSync] No unsynced simulations to push');
        return const Right(0);
      }

      // Convert to JSON for API
      final simulationsJson = unsyncedSimulations.map((sim) {
        return {
          'simulation_uuid': sim.simulationUuid,
          'simulation_code': sim.simulationCode,
          'simulation_name': sim.simulationName,
          'employee_id': sim.employeeId,
          'pond_id': sim.pondId,
          'device_uuid': sim.deviceUuid,
          'cycle_type': sim.cycleType,
          'harvest_mode': sim.harvestMode,
          'harvest_frequency_days': sim.harvestFrequencyDays,
          'partial_harvest_percentage': sim.partialHarvestPercentage,
          'pond_area': sim.pondArea,
          'pond_area_unit': sim.pondAreaUnit,
          'pwa': sim.pwa,
          'pwa_unit': sim.pwaUnit,
          'pond_depth': sim.pondDepth,
          'pond_depth_unit': sim.pondDepthUnit,
          'stocking_density': sim.stockingDensity,
          'stocking_density_unit': sim.stockingDensityUnit,
          'initial_abw': sim.initialAbw,
          'initial_abw_unit': sim.initialAbwUnit,
          'target_abw': sim.targetAbw,
          'target_abw_unit': sim.targetAbwUnit,
          'target_survival_rate_percent': sim.targetSurvivalRatePercent,
          'target_fcr': sim.targetFcr,
          'target_doc': sim.targetDoc,
          'commodity_code': sim.commodityCode,
          'culture_system': sim.cultureSystem,
          'current_doc': sim.currentDoc,
          'current_population': sim.currentPopulation,
          'current_abw': sim.currentAbw,
          'current_abw_unit': sim.currentAbwUnit,
          'cumulative_feed_used': sim.cumulativeFeedUsed,
          'cumulative_feed_used_unit': sim.cumulativeFeedUsedUnit,
          'capacity_ref_id': sim.capacityRefId,
          'capacity_per_area': sim.capacityPerArea,
          'capacity_per_area_unit': sim.capacityPerAreaUnit,
          'capacity_total': sim.capacityTotal,
          'capacity_total_unit': sim.capacityTotalUnit,
          'estimated_adg': sim.estimatedAdg,
          'estimated_adg_unit': sim.estimatedAdgUnit,
          'initial_stocking_count': sim.initialStockingCount,
          'daily_loss_rate_percent': sim.dailyLossRatePercent,
          'feed_price': sim.feedPrice,
          'feed_price_currency': sim.feedPriceCurrency,
          'commodity_price': sim.commodityPrice,
          'commodity_price_currency': sim.commodityPriceCurrency,
          'feeding_rate_percent': sim.feedingRatePercent,
          'base_mortality_rate_percent': sim.baseMortalityRatePercent,
          'water_exchange_rate_percent': sim.waterExchangeRatePercent,
          'daily_projections': sim.dailyProjections != null
              ? jsonDecode(sim.dailyProjections!)
              : null,
          'harvest_events': sim.harvestEvents != null
              ? jsonDecode(sim.harvestEvents!)
              : null,
          'summary_data': sim.summaryData != null
              ? jsonDecode(sim.summaryData!)
              : null,
          'monthly_summary': sim.monthlySummary != null
              ? jsonDecode(sim.monthlySummary!)
              : null,
          'is_materialized': sim.isMaterialized,
          'simulation_status': sim.simulationStatus,
          'approval_status': sim.approvalStatus,
          'language_preference': sim.languagePreference,
          'unit_system': sim.unitSystem,
          'display_weight_unit': sim.displayWeightUnit,
          'display_area_unit': sim.displayAreaUnit,
          'display_currency': sim.displayCurrency,
          'simulation_version': sim.simulationVersion,
          'created_date': sim.createdDate?.toIso8601String(),
          'last_updated_date': sim.lastUpdatedDate?.toIso8601String(),
        };
      }).toList();

      // Send to server
      final response = await dio.post(
        '/api/sync/harvest-simulations/push',
        data: {
          'employee_id': employeeId,
          'device_uuid': deviceUuid,
          'simulations': simulationsJson,
        },
      );

      if (response.statusCode == 200) {
        // Mark as synced locally
        final now = DateTime.now();
        for (final sim in unsyncedSimulations) {
          database.update(database.fms10HarvestSimulations)
            ..where((tbl) => tbl.simulationUuid.equals(sim.simulationUuid))
            ..write(
              Fms10HarvestSimulationsCompanion(
                isSynced: const drift.Value(true),
                syncedDate: drift.Value(now),
              ),
            );
        }

        AppLogger.info(
          '[HarvestSync] Successfully pushed ${unsyncedSimulations.length} simulations',
        );
        return Right(unsyncedSimulations.length);
      } else {
        return Left(
          NetworkFailure(
            message: 'Failed to push simulations: ${response.statusMessage}',
          ),
        );
      }
    } catch (e) {
      AppLogger.error('[HarvestSync] Error pushing simulations: $e');
      return Left(NetworkFailure(message: 'Failed to push simulations: $e'));
    }
  }

  /// Pull harvest simulations from server.
  Future<Either<Failure, (int, int)>> _pullSimulationsFromServer(
    String employeeId,
  ) async {
    try {
      final database = ref.read(databaseProvider);
      final deviceUuid = await DeviceUuidHelper.getOrGenerateUuid();

      // Get last sync time
      final lastSyncResult =
          await (database.select(database.fms10HarvestSimulations)
                ..where(
                  (tbl) =>
                      tbl.employeeId.equals(int.tryParse(employeeId) ?? 0) &
                      tbl.syncedDate.isNotNull(),
                )
                ..orderBy([(tbl) => drift.OrderingTerm.desc(tbl.syncedDate)])
                ..limit(1))
              .getSingleOrNull();

      final lastSyncTime = lastSyncResult?.syncedDate;

      // Pull from server
      final response = await dio.get(
        '/api/sync/harvest-simulations/pull',
        queryParameters: {
          'employee_id': employeeId,
          'device_uuid': deviceUuid,
          'last_sync_time': lastSyncTime?.toIso8601String(),
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final simulations = responseData['data'] as List<dynamic>;

        var pulledCount = 0;
        var conflictsResolved = 0;

        for (final simJson in simulations) {
          final serverSim = simJson as Map<String, dynamic>;
          final simulationUuid = serverSim['simulation_uuid'] as String;

          // Check if exists locally
          final existingSim =
              await (database.select(database.fms10HarvestSimulations)
                    ..where((tbl) => tbl.simulationUuid.equals(simulationUuid)))
                  .getSingleOrNull();

          if (existingSim == null) {
            // New simulation - insert
            await _insertSimulationFromServer(database, serverSim);
            pulledCount++;
          } else {
            // Existing simulation - check for conflicts
            final serverUpdated = DateTime.parse(
              serverSim['last_updated_date'] as String,
            );
            final localUpdated =
                existingSim.lastUpdatedDate ??
                DateTime.fromMillisecondsSinceEpoch(0);

            if (serverUpdated.isAfter(localUpdated)) {
              // Server is newer - update local
              await _updateSimulationFromServer(
                database,
                simulationUuid,
                serverSim,
              );
              conflictsResolved++;
            }
            // If local is newer, keep local (client wins for now)
          }
        }

        return Right((pulledCount, conflictsResolved));
      } else {
        return Left(
          NetworkFailure(
            message: 'Failed to pull simulations: ${response.statusMessage}',
          ),
        );
      }
    } catch (e) {
      AppLogger.error('[HarvestSync] Error pulling simulations: $e');
      return Left(NetworkFailure(message: 'Failed to pull simulations: $e'));
    }
  }

  /// Insert simulation from server data.
  Future<void> _insertSimulationFromServer(
    AppDatabase database,
    Map<String, dynamic> simJson,
  ) async {
    await database
        .into(database.fms10HarvestSimulations)
        .insert(
          Fms10HarvestSimulationsCompanion(
            simulationUuid: drift.Value(simJson['simulation_uuid'] as String),
            simulationCode: drift.Value(simJson['simulation_code'] as String),
            simulationName: simJson['simulation_name'] != null
                ? drift.Value(simJson['simulation_name'] as String)
                : const drift.Value.absent(),
            employeeId: drift.Value(simJson['employee_id'] as int),
            pondId: drift.Value(simJson['pond_id'] as int?),
            deviceUuid: drift.Value(simJson['device_uuid'] as String?),
            cycleType: drift.Value(simJson['cycle_type'] as String?),
            harvestMode: drift.Value(simJson['harvest_mode'] as String?),
            harvestFrequencyDays: drift.Value(
              simJson['harvest_frequency_days'] as int?,
            ),
            partialHarvestPercentage: drift.Value(
              (simJson['partial_harvest_percentage'] as num?)?.toDouble(),
            ),
            pondArea: drift.Value((simJson['pond_area'] as num?)?.toDouble()),
            pondAreaUnit: drift.Value(simJson['pond_area_unit'] as String?),
            pwa: drift.Value((simJson['pwa'] as num?)?.toDouble()),
            pwaUnit: drift.Value(simJson['pwa_unit'] as String?),
            pondDepth: drift.Value((simJson['pond_depth'] as num?)?.toDouble()),
            pondDepthUnit: drift.Value(simJson['pond_depth_unit'] as String?),
            stockingDensity: drift.Value(
              (simJson['stocking_density'] as num?)?.toDouble(),
            ),
            stockingDensityUnit: drift.Value(
              simJson['stocking_density_unit'] as String?,
            ),
            initialAbw: drift.Value(
              (simJson['initial_abw'] as num?)?.toDouble(),
            ),
            initialAbwUnit: drift.Value(simJson['initial_abw_unit'] as String?),
            targetAbw: drift.Value((simJson['target_abw'] as num?)?.toDouble()),
            targetAbwUnit: drift.Value(simJson['target_abw_unit'] as String?),
            targetSurvivalRatePercent: drift.Value(
              (simJson['target_survival_rate_percent'] as num?)?.toDouble(),
            ),
            targetFcr: drift.Value((simJson['target_fcr'] as num?)?.toDouble()),
            targetDoc: drift.Value(simJson['target_doc'] as int?),
            commodityCode: drift.Value(simJson['commodity_code'] as String?),
            cultureSystem: drift.Value(simJson['culture_system'] as String?),
            currentDoc: drift.Value(simJson['current_doc'] as int?),
            currentPopulation: drift.Value(
              simJson['current_population'] as int?,
            ),
            currentAbw: drift.Value(
              (simJson['current_abw'] as num?)?.toDouble(),
            ),
            currentAbwUnit: drift.Value(simJson['current_abw_unit'] as String?),
            cumulativeFeedUsed: drift.Value(
              (simJson['cumulative_feed_used'] as num?)?.toDouble(),
            ),
            cumulativeFeedUsedUnit: drift.Value(
              simJson['cumulative_feed_used_unit'] as String?,
            ),
            capacityRefId: drift.Value(simJson['capacity_ref_id'] as int?),
            capacityPerArea: drift.Value(
              (simJson['capacity_per_area'] as num?)?.toDouble(),
            ),
            capacityPerAreaUnit: drift.Value(
              simJson['capacity_per_area_unit'] as String?,
            ),
            capacityTotal: drift.Value(
              (simJson['capacity_total'] as num?)?.toDouble(),
            ),
            capacityTotalUnit: drift.Value(
              simJson['capacity_total_unit'] as String?,
            ),
            estimatedAdg: drift.Value(
              (simJson['estimated_adg'] as num?)?.toDouble(),
            ),
            estimatedAdgUnit: drift.Value(
              simJson['estimated_adg_unit'] as String?,
            ),
            initialStockingCount: drift.Value(
              simJson['initial_stocking_count'] as int?,
            ),
            dailyLossRatePercent: drift.Value(
              (simJson['daily_loss_rate_percent'] as num?)?.toDouble(),
            ),
            feedPrice: drift.Value((simJson['feed_price'] as num?)?.toDouble()),
            feedPriceCurrency: drift.Value(
              simJson['feed_price_currency'] as String?,
            ),
            commodityPrice: drift.Value(
              (simJson['commodity_price'] as num?)?.toDouble(),
            ),
            commodityPriceCurrency: drift.Value(
              simJson['commodity_price_currency'] as String?,
            ),
            feedingRatePercent: drift.Value(
              (simJson['feeding_rate_percent'] as num?)?.toDouble(),
            ),
            baseMortalityRatePercent: drift.Value(
              (simJson['base_mortality_rate_percent'] as num?)?.toDouble(),
            ),
            waterExchangeRatePercent: drift.Value(
              (simJson['water_exchange_rate_percent'] as num?)?.toDouble(),
            ),
            dailyProjections: drift.Value(
              simJson['daily_projections'] != null
                  ? jsonEncode(simJson['daily_projections'])
                  : null,
            ),
            harvestEvents: drift.Value(
              simJson['harvest_events'] != null
                  ? jsonEncode(simJson['harvest_events'])
                  : null,
            ),
            summaryData: drift.Value(
              simJson['summary_data'] != null
                  ? jsonEncode(simJson['summary_data'])
                  : null,
            ),
            monthlySummary: drift.Value(
              simJson['monthly_summary'] != null
                  ? jsonEncode(simJson['monthly_summary'])
                  : null,
            ),
            isMaterialized: drift.Value(
              simJson['is_materialized'] as bool? ?? false,
            ),
            isSynced: const drift.Value(true),
            simulationStatus: drift.Value(
              simJson['simulation_status'] as String?,
            ),
            approvalStatus: drift.Value(simJson['approval_status'] as String?),
            languagePreference: drift.Value(
              simJson['language_preference'] as String?,
            ),
            unitSystem: drift.Value(simJson['unit_system'] as String?),
            displayWeightUnit: drift.Value(
              simJson['display_weight_unit'] as String?,
            ),
            displayAreaUnit: drift.Value(
              simJson['display_area_unit'] as String?,
            ),
            displayCurrency: drift.Value(
              simJson['display_currency'] as String?,
            ),
            simulationVersion: drift.Value(
              simJson['simulation_version'] as String?,
            ),
            syncedDate: drift.Value(DateTime.now()),
          ),
        );
  }

  /// Update simulation from server data.
  Future<void> _updateSimulationFromServer(
    AppDatabase database,
    String simulationUuid,
    Map<String, dynamic> simJson,
  ) async {
    (database.update(database.fms10HarvestSimulations)
      ..where((tbl) => tbl.simulationUuid.equals(simulationUuid))
      ..write(
        Fms10HarvestSimulationsCompanion(
          simulationName: simJson['simulation_name'] != null
              ? drift.Value(simJson['simulation_name'] as String)
              : const drift.Value.absent(),
          pondId: drift.Value(simJson['pond_id'] as int?),
          cycleType: drift.Value(simJson['cycle_type'] as String?),
          harvestMode: drift.Value(simJson['harvest_mode'] as String?),
          harvestFrequencyDays: drift.Value(
            simJson['harvest_frequency_days'] as int?,
          ),
          partialHarvestPercentage: drift.Value(
            (simJson['partial_harvest_percentage'] as num?)?.toDouble(),
          ),
          pondArea: drift.Value((simJson['pond_area'] as num?)?.toDouble()),
          pondAreaUnit: drift.Value(simJson['pond_area_unit'] as String?),
          pwa: drift.Value((simJson['pwa'] as num?)?.toDouble()),
          pwaUnit: drift.Value(simJson['pwa_unit'] as String?),
          pondDepth: drift.Value((simJson['pond_depth'] as num?)?.toDouble()),
          pondDepthUnit: drift.Value(simJson['pond_depth_unit'] as String?),
          stockingDensity: drift.Value(
            (simJson['stocking_density'] as num?)?.toDouble(),
          ),
          stockingDensityUnit: drift.Value(
            simJson['stocking_density_unit'] as String?,
          ),
          initialAbw: drift.Value((simJson['initial_abw'] as num?)?.toDouble()),
          initialAbwUnit: drift.Value(simJson['initial_abw_unit'] as String?),
          targetAbw: drift.Value((simJson['target_abw'] as num?)?.toDouble()),
          targetAbwUnit: drift.Value(simJson['target_abw_unit'] as String?),
          targetSurvivalRatePercent: drift.Value(
            (simJson['target_survival_rate_percent'] as num?)?.toDouble(),
          ),
          targetFcr: drift.Value((simJson['target_fcr'] as num?)?.toDouble()),
          targetDoc: drift.Value(simJson['target_doc'] as int?),
          commodityCode: drift.Value(simJson['commodity_code'] as String?),
          cultureSystem: drift.Value(simJson['culture_system'] as String?),
          currentDoc: drift.Value(simJson['current_doc'] as int?),
          currentPopulation: drift.Value(simJson['current_population'] as int?),
          currentAbw: drift.Value((simJson['current_abw'] as num?)?.toDouble()),
          currentAbwUnit: drift.Value(simJson['current_abw_unit'] as String?),
          cumulativeFeedUsed: drift.Value(
            (simJson['cumulative_feed_used'] as num?)?.toDouble(),
          ),
          cumulativeFeedUsedUnit: drift.Value(
            simJson['cumulative_feed_used_unit'] as String?,
          ),
          capacityRefId: drift.Value(simJson['capacity_ref_id'] as int?),
          capacityPerArea: drift.Value(
            (simJson['capacity_per_area'] as num?)?.toDouble(),
          ),
          capacityPerAreaUnit: drift.Value(
            simJson['capacity_per_area_unit'] as String?,
          ),
          capacityTotal: drift.Value(
            (simJson['capacity_total'] as num?)?.toDouble(),
          ),
          capacityTotalUnit: drift.Value(
            simJson['capacity_total_unit'] as String?,
          ),
          estimatedAdg: drift.Value(
            (simJson['estimated_adg'] as num?)?.toDouble(),
          ),
          estimatedAdgUnit: drift.Value(
            simJson['estimated_adg_unit'] as String?,
          ),
          initialStockingCount: drift.Value(
            simJson['initial_stocking_count'] as int?,
          ),
          dailyLossRatePercent: drift.Value(
            (simJson['daily_loss_rate_percent'] as num?)?.toDouble(),
          ),
          feedPrice: drift.Value((simJson['feed_price'] as num?)?.toDouble()),
          feedPriceCurrency: drift.Value(
            simJson['feed_price_currency'] as String?,
          ),
          commodityPrice: drift.Value(
            (simJson['commodity_price'] as num?)?.toDouble(),
          ),
          commodityPriceCurrency: drift.Value(
            simJson['commodity_price_currency'] as String?,
          ),
          feedingRatePercent: drift.Value(
            (simJson['feeding_rate_percent'] as num?)?.toDouble(),
          ),
          baseMortalityRatePercent: drift.Value(
            (simJson['base_mortality_rate_percent'] as num?)?.toDouble(),
          ),
          waterExchangeRatePercent: drift.Value(
            (simJson['water_exchange_rate_percent'] as num?)?.toDouble(),
          ),
          dailyProjections: drift.Value(
            simJson['daily_projections'] != null
                ? jsonEncode(simJson['daily_projections'])
                : null,
          ),
          harvestEvents: drift.Value(
            simJson['harvest_events'] != null
                ? jsonEncode(simJson['harvest_events'])
                : null,
          ),
          summaryData: drift.Value(
            simJson['summary_data'] != null
                ? jsonEncode(simJson['summary_data'])
                : null,
          ),
          monthlySummary: drift.Value(
            simJson['monthly_summary'] != null
                ? jsonEncode(simJson['monthly_summary'])
                : null,
          ),
          isMaterialized: drift.Value(
            simJson['is_materialized'] as bool? ?? false,
          ),
          isSynced: const drift.Value(true),
          simulationStatus: drift.Value(
            simJson['simulation_status'] as String?,
          ),
          approvalStatus: drift.Value(simJson['approval_status'] as String?),
          languagePreference: drift.Value(
            simJson['language_preference'] as String?,
          ),
          unitSystem: drift.Value(simJson['unit_system'] as String?),
          displayWeightUnit: drift.Value(
            simJson['display_weight_unit'] as String?,
          ),
          displayAreaUnit: drift.Value(simJson['display_area_unit'] as String?),
          displayCurrency: drift.Value(simJson['display_currency'] as String?),
          simulationVersion: drift.Value(
            simJson['simulation_version'] as String?,
          ),
          syncedDate: drift.Value(DateTime.now()),
          lastUpdatedDate: drift.Value(
            DateTime.parse(simJson['last_updated_date'] as String),
          ),
        ),
      ));
  }
}
