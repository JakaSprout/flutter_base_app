import 'package:flutter_base_app/core/config/app_config.dart' show AppConfig;
import 'package:flutter_base_app/core/di/providers/dio_provider.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/home/data/datasources/remote/home_remote_datasource.dart';
import 'package:flutter_base_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:flutter_base_app/features/home/domain/entities/banner_list_data.dart';
import 'package:flutter_base_app/features/home/domain/entities/company_list_data.dart';
import 'package:flutter_base_app/features/home/domain/entities/dashboard_summary_data.dart';
import 'package:flutter_base_app/features/home/domain/entities/header_data.dart';
import 'package:flutter_base_app/features/home/domain/entities/home_data.dart';
import 'package:flutter_base_app/features/home/domain/entities/input_data_list_data.dart';
import 'package:flutter_base_app/features/home/domain/entities/pond_list_data.dart';
import 'package:flutter_base_app/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_base_app/features/home/domain/usecases/get_banner_list_data.dart';
import 'package:flutter_base_app/features/home/domain/usecases/get_company_list_data.dart';
import 'package:flutter_base_app/features/home/domain/usecases/get_dashboard_summary_data.dart';
import 'package:flutter_base_app/features/home/domain/usecases/get_header_data.dart';
import 'package:flutter_base_app/features/home/domain/usecases/get_home_data.dart';
import 'package:flutter_base_app/features/home/domain/usecases/get_input_data_list_data.dart';
import 'package:flutter_base_app/features/home/domain/usecases/get_pond_list_data.dart';
import 'package:flutter_base_app/features/home/domain/usecases/update_selected_company.dart';
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

/// Provider for GetCompanyListData use case.
@Riverpod(keepAlive: true)
GetCompanyListData getCompanyListData(GetCompanyListDataRef ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return GetCompanyListData(repository);
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

/// Provider for UpdateSelectedCompany use case.
@Riverpod(keepAlive: true)
UpdateSelectedCompany updateSelectedCompany(UpdateSelectedCompanyRef ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return UpdateSelectedCompany(repository);
}

/// Provider for home data.
///
/// This provider fetches and provides home screen data.
/// Returns [AsyncValue<HomeData>] which handles loading, success, and error states automatically.
@riverpod
Future<HomeData> homeData(HomeDataRef ref) async {
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

/// Provider for company list data.
@riverpod
Future<CompanyListData> companyListData(CompanyListDataRef ref) async {
  final getCompanyListData = ref.read(getCompanyListDataProvider);
  final result = await getCompanyListData();

  return result.fold<CompanyListData>(
    (Failure failure) => throw failure,
    (CompanyListData data) => data,
  );
}

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

/// Notifier for company list operations (update selected company).
@riverpod
class CompanyListNotifier extends _$CompanyListNotifier {
  @override
  Future<CompanyListData> build() async {
    return ref.watch(companyListDataProvider.future);
  }

  /// Update selected company.
  Future<void> updateCompany(String company) async {
    final updateCompany = ref.read(updateSelectedCompanyProvider);
    final result = await updateCompany(company);

    result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
      },
      (data) {
        state = AsyncValue.data(data);
      },
    );
  }
}

/// Notifier for home data operations (refresh, update company).
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

  /// Update selected company (legacy - deprecated).
  @Deprecated('Use CompanyListNotifier.updateCompany instead')
  Future<void> updateCompany(String company) async {
    // Legacy method - no longer used
    // This is kept for backward compatibility only
  }
}
