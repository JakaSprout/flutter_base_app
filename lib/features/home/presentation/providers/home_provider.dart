import 'package:app_mobile_afms/core/config/app_config.dart' show AppConfig;
import 'package:app_mobile_afms/core/di/providers/dio_provider.dart';
import 'package:app_mobile_afms/core/di/providers/master_data_sync_provider.dart';
import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:app_mobile_afms/core/reference_data/domain/services/master_data_sync_service.dart';
import 'package:app_mobile_afms/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/providers/registered_ponds_provider.dart';
import 'package:app_mobile_afms/features/home/data/datasources/remote/home_remote_datasource.dart';
import 'package:app_mobile_afms/features/home/data/repositories/home_repository_impl.dart';
import 'package:app_mobile_afms/features/home/domain/entities/banner_list_data.dart';
import 'package:app_mobile_afms/features/home/domain/entities/dashboard_summary_data.dart';
import 'package:app_mobile_afms/features/home/domain/entities/farm_list_data.dart';
import 'package:app_mobile_afms/features/home/domain/entities/header_data.dart';
import 'package:app_mobile_afms/features/home/domain/entities/home_data.dart';
import 'package:app_mobile_afms/features/home/domain/entities/input_data_list_data.dart';
import 'package:app_mobile_afms/features/home/domain/entities/pond_list_data.dart';
import 'package:app_mobile_afms/features/home/domain/repositories/home_repository.dart';
import 'package:app_mobile_afms/features/home/domain/usecases/get_banner_list_data.dart';
import 'package:app_mobile_afms/features/home/domain/usecases/get_dashboard_summary_data.dart';
import 'package:app_mobile_afms/features/home/domain/usecases/get_farm_list_data.dart';
import 'package:app_mobile_afms/features/home/domain/usecases/get_header_data.dart';
import 'package:app_mobile_afms/features/home/domain/usecases/get_home_data.dart';
import 'package:app_mobile_afms/features/home/domain/usecases/get_input_data_list_data.dart';
import 'package:app_mobile_afms/features/home/domain/usecases/get_pond_list_data.dart';
import 'package:app_mobile_afms/features/home/domain/usecases/update_selected_farm.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_provider.g.dart';

/// Provider for Home remote data source.
///
/// Uses [AppConfig.useMockApi] to determine whether to use mock or real API.
@Riverpod(keepAlive: true)
HomeRemoteDataSource homeRemoteDataSource(HomeRemoteDataSourceRef ref) {
  final config = ref.watch(appConfigProvider);

  // Use mock API if configured for current flavor
  if (config.useMockApi) {
    return HomeRemoteDataSourceMock(config: config);
  }

  // TODO: Return real API implementation when available
  // return HomeRemoteDataSourceImpl(config: config, dio: ref.watch(dioProvider));

  // Fallback to mock for now
  return HomeRemoteDataSourceMock(config: config);
}

/// Provider for Home repository.
@Riverpod(keepAlive: true)
HomeRepository homeRepository(HomeRepositoryRef ref) {
  final remoteDataSource = ref.watch(homeRemoteDataSourceProvider);
  return HomeRepositoryImpl(remoteDataSource: remoteDataSource);
}

/// Provider for GetHomeData use case.
@Riverpod(keepAlive: true)
GetHomeData getHomeData(GetHomeDataRef ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return GetHomeData(repository);
}

/// Provider for GetDashboardSummaryData use case.
@Riverpod(keepAlive: true)
GetDashboardSummaryData getDashboardSummaryData(
  GetDashboardSummaryDataRef ref,
) {
  final repository = ref.watch(homeRepositoryProvider);
  return GetDashboardSummaryData(repository);
}

/// Provider for GetPondListData use case.
@Riverpod(keepAlive: true)
GetPondListData getPondListData(GetPondListDataRef ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return GetPondListData(repository);
}

/// Provider for GetFarmListData use case.
///
/// This provider creates a mock implementation since reference data tables were removed.
/// TODO: Implement with real API data when available.
@riverpod
Future<GetFarmListData> getFarmListData(GetFarmListDataRef ref) async {
  // Mock implementation - reference data tables were removed during development cleanup
  // TODO: Replace with real API implementation
  throw UnimplementedError(
    'Reference data tables were removed. Implement with API data.',
  );
}

/// Provider for GetHeaderData use case.
@Riverpod(keepAlive: true)
GetHeaderData getHeaderData(GetHeaderDataRef ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return GetHeaderData(repository);
}

/// Provider for GetBannerListData use case.
@Riverpod(keepAlive: true)
GetBannerListData getBannerListData(GetBannerListDataRef ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return GetBannerListData(repository);
}

/// Provider for GetInputDataListData use case.
@Riverpod(keepAlive: true)
GetInputDataListData getInputDataListData(GetInputDataListDataRef ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return GetInputDataListData(repository);
}

/// Provider for UpdateSelectedFarm use case.
@Riverpod(keepAlive: true)
UpdateSelectedFarm updateSelectedFarm(UpdateSelectedFarmRef ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return UpdateSelectedFarm(repository);
}

/// Provider for master data sync.
///
/// This provider runs master data synchronization when the home screen loads.
/// It checks connectivity and syncs reference data (capacity_references, units, ponds, employees).
/// Returns [AsyncValue<MasterDataSyncResult>] with sync results.
///
/// Uses caching to prevent repeated sync calls within a short time window.
@riverpod
Future<MasterDataSyncResult> masterDataSync(MasterDataSyncRef ref) async {
  final authService = ref.watch(authServiceProvider);
  final masterDataSyncService = ref.watch(masterDataSyncServiceProvider);

  final employeeId = await authService.getStoredEmployeeId();
  if (employeeId == null || employeeId.isEmpty) {
    throw StateError('Employee ID not available for master data sync');
  }

  return masterDataSyncService.syncMasterData(employeeId: employeeId);
}

/// Provider for home data.
///
/// This provider fetches and provides home screen data.
/// Returns [AsyncValue<HomeData>] which handles loading, success, and error states automatically.
@riverpod
Future<HomeData> homeData(HomeDataRef ref) async {
  // Note: Master data sync is handled separately and doesn't need to be watched here
  // to avoid triggering sync on every home data load

  final getHomeData = ref.read(getHomeDataProvider);
  final result = await getHomeData();

  return result.fold<HomeData>(
    (Failure failure) => throw failure,
    (HomeData data) => data,
  );
}

/// Provider for dashboard summary data.
@riverpod
Future<DashboardSummaryData> dashboardSummaryData(
  DashboardSummaryDataRef ref,
) async {
  final getDashboardSummaryData = ref.read(getDashboardSummaryDataProvider);
  final result = await getDashboardSummaryData();

  return result.fold<DashboardSummaryData>(
    (Failure failure) => throw failure,
    (DashboardSummaryData data) => data,
  );
}

/// Provider for pond list data.
@riverpod
Future<PondListData> pondListData(PondListDataRef ref) async {
  final getPondListData = ref.read(getPondListDataProvider);
  final result = await getPondListData();

  return result.fold<PondListData>(
    (Failure failure) => throw failure,
    (PondListData data) => data,
  );
}

/// Provider for farm list data.
///
/// Uses API first (when online), falls back to local SQLite (when offline or API fails).
/// Strategy: API → Local DB → Empty Data
/// This provider doesn't watch sync state to avoid infinite loops.
@riverpod
Future<FarmListData> farmListData(FarmListDataRef ref) async {
  AppLogger.debug('[FarmListData] Starting FarmListData provider');

  final authService = ref.watch(authServiceProvider);
  final employeeId = await authService.getStoredEmployeeId();

  AppLogger.debug('[FarmListData] Retrieved employeeId: "$employeeId"');

  if (employeeId == null || employeeId.isEmpty) {
    AppLogger.error(
      '[FarmListData] Employee ID is null or empty, throwing StateError',
    );
    throw StateError(
      'Employee ID tidak tersedia. Login ulang untuk menyegarkan sesi.',
    );
  }

  AppLogger.debug(
    '[FarmListData] Employee ID valid, fetching from local database',
  );

  // Fetch directly from local database
  return _tryFetchFromLocalDb(ref, employeeId);
}

/// Fetch farm data directly from local database
Future<FarmListData> _tryFetchFromLocalDb(
  FarmListDataRef ref,
  String employeeId,
) async {
  AppLogger.debug('[FarmListData] Starting _tryFetchFromLocalDb fallback');

  try {
    final localDatasource = ref.read(referenceDataLocalDatasourceProvider);
    final farmsResult = await localDatasource.getFarms();

    return farmsResult.fold(
      (failure) {
        AppLogger.error(
          '[FarmListData] Local DB fallback also failed: $failure',
        );
        return const FarmListData(
          farms: [],
          selectedFarm: '',
          selectedFarmId: 0,
        );
      },
      (farms) {
        AppLogger.debug(
          '[FarmListData] Local DB fallback returned ${farms.length} farms',
        );

        // Debug: Log sample farm data
        for (var i = 0; i < farms.length && i < 3; i++) {
          final farm = farms[i];
          AppLogger.debug(
            '[FarmListData] Farm $i: id="${farm.id}", farmUuid="${farm.farmUuid}", name="${farm.name}", code="${farm.code}"',
          );
        }

        if (farms.isNotEmpty) {
          final farmNames = farms
              .map((farm) => farm.name ?? farm.code)
              .toList();
          final selectedFarm = farms.first.name ?? farms.first.code;
          final selectedFarmId = int.tryParse(farms.first.id) ?? 0;
          final selectedFarmUuid =
              farms.first.farmUuid; // Set default farm UUID

          final result = FarmListData(
            farms: farmNames,
            selectedFarm: selectedFarm,
            selectedFarmId: selectedFarmId,
            selectedFarmUuid: selectedFarmUuid,
          );

          AppLogger.debug('[FarmListData] ===== FARM UUID FLOW DEBUG =====');
          AppLogger.debug(
            '[FarmListData] 1. Raw farm data: first farm UUID="${farms.first.farmUuid}"',
          );
          AppLogger.debug(
            '[FarmListData] 2. Selected farm UUID: "$selectedFarmUuid"',
          );
          AppLogger.debug(
            '[FarmListData] 3. FarmListData result UUID: "${result.selectedFarmUuid}"',
          );
          AppLogger.debug('[FarmListData] ================================');

          return result;
        } else {
          AppLogger.warning('[FarmListData] Local DB fallback also empty');
          return const FarmListData(
            farms: [],
            selectedFarm: '',
            selectedFarmId: 0,
          );
        }
      },
    );
  } catch (e) {
    AppLogger.error('[FarmListData] Error accessing local DB fallback: $e');
    return const FarmListData(farms: [], selectedFarm: '', selectedFarmId: 0);
  }
}

/// Try to fetch farm data from API if online, return empty data if offline

/// Provider for header data.
@riverpod
Future<HeaderData> headerData(HeaderDataRef ref) async {
  final getHeaderData = ref.read(getHeaderDataProvider);
  final result = await getHeaderData();

  return result.fold<HeaderData>(
    (Failure failure) => throw failure,
    (HeaderData data) => data,
  );
}

/// Provider for banner list data.
@riverpod
Future<BannerListData> bannerListData(BannerListDataRef ref) async {
  final getBannerListData = ref.read(getBannerListDataProvider);
  final result = await getBannerListData();

  return result.fold<BannerListData>(
    (Failure failure) => throw failure,
    (BannerListData data) => data,
  );
}

/// Provider for input data list data.
@riverpod
Future<InputDataListData> inputDataListData(InputDataListDataRef ref) async {
  final getInputDataListData = ref.read(getInputDataListDataProvider);
  final result = await getInputDataListData();

  return result.fold<InputDataListData>(
    (Failure failure) => throw failure,
    (InputDataListData data) => data,
  );
}

/// Notifier for farm list operations (update selected farm).
///
/// Keeps state alive across navigation so farm selection persists.
@Riverpod(keepAlive: true)
class FarmListNotifier extends _$FarmListNotifier {
  @override
  Future<FarmListData> build() async {
    // Initialize state from farmListDataProvider
    // This only runs once when provider is first created
    return ref.read(farmListDataProvider.future);
  }

  /// Update selected farm.
  Future<void> updateFarm(String farm) async {
    AppLogger.debug('[FarmListNotifier] updateFarm called with: "$farm"');

    // Get current farm list data
    final currentData = await ref.read(farmListDataProvider.future);
    AppLogger.debug(
      '[FarmListNotifier] Current state: selectedFarm="${currentData.selectedFarm}", selectedFarmUuid="${currentData.selectedFarmUuid}"',
    );

    // Try to get farm ID from local data
    try {
      final localDatasource = ref.read(referenceDataLocalDatasourceProvider);
      final farmsResult = await localDatasource.getFarms();

      farmsResult.fold(
        (failure) {
          // Fallback to index-based ID if local data fails
          final farmIndex = currentData.farms.indexOf(farm);
          final selectedFarmId = farmIndex >= 0
              ? farmIndex + 1
              : currentData.selectedFarmId;

          AppLogger.warning(
            '[FarmListNotifier] Failed to fetch farms from local DB, using fallback ID: $selectedFarmId',
          );

          // Update state with fallback values, preserve selectedFarmUuid from currentData
          state = AsyncValue.data(
            FarmListData(
              farms: currentData.farms,
              selectedFarm: farm,
              selectedFarmId: selectedFarmId,
              selectedFarmUuid: currentData.selectedFarmUuid,
            ),
          );
        },
        (farms) {
          // Find farm with matching name
          final selectedFarmEntity = farms.firstWhere(
            (farmEntity) => (farmEntity.name ?? farmEntity.code) == farm,
            orElse: () => farms.isNotEmpty
                ? farms.first
                : throw StateError('Farm tidak ditemukan'),
          );

          final selectedFarmId = selectedFarmEntity.id.isNotEmpty
              ? int.tryParse(selectedFarmEntity.id) ??
                    (currentData.farms.indexOf(farm) + 1)
              : (currentData.farms.indexOf(farm) + 1);

          // Update state with new selected farm, ID, and UUID
          final selectedFarmUuid =
              selectedFarmEntity.farmUuid?.isNotEmpty ?? false
              ? selectedFarmEntity.farmUuid
              : null;

          AppLogger.debug(
            '[FarmListNotifier] Farm entity details: id="${selectedFarmEntity.id}", farmUuid="${selectedFarmEntity.farmUuid}", name="${selectedFarmEntity.name}"',
          );

          final newFarmListData = FarmListData(
            farms: currentData.farms,
            selectedFarm: farm,
            selectedFarmId: selectedFarmId,
            selectedFarmUuid: selectedFarmUuid,
          );

          AppLogger.debug(
            '[FarmListNotifier] ===== FARM SELECTION UPDATE =====',
          );
          AppLogger.debug('[FarmListNotifier] 1. User selected farm: "$farm"');
          AppLogger.debug(
            '[FarmListNotifier] 2. Found farm entity UUID: "$selectedFarmUuid"',
          );
          AppLogger.debug(
            '[FarmListNotifier] 3. New state UUID: "${newFarmListData.selectedFarmUuid}"',
          );
          AppLogger.debug(
            '[FarmListNotifier] ================================',
          );

          state = AsyncValue.data(newFarmListData);
        },
      );

      // Let reactive watching handle the update - pond provider will auto-refresh when farm state changes
    } catch (e) {
      // On error, just update the selected farm name
      AppLogger.warning(
        '[FarmListNotifier] Failed to get farm ID, updating name only: $e',
      );
      state = AsyncValue.data(
        FarmListData(
          farms: currentData.farms,
          selectedFarm: farm,
          selectedFarmId: currentData.selectedFarmId,
          selectedFarmUuid: currentData.selectedFarmUuid,
        ),
      );
      ref.invalidate(registeredPondOptionsProvider);
    }
  }
}

/// Notifier for home data operations (refresh, update farm).
@riverpod
class HomeDataNotifier extends _$HomeDataNotifier {
  @override
  Future<HomeData> build() async {
    return ref.watch(homeDataProvider.future);
  }

  /// Refresh home data.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.refresh(homeDataProvider.future));
  }
}
