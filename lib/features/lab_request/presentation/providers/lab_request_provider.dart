import 'package:app_mobile_afms/core/config/app_config.dart' show AppConfig;
import 'package:app_mobile_afms/core/di/providers/dio_provider.dart';
import 'package:app_mobile_afms/features/lab_request/data/datasources/remote/lab_request_remote_datasource.dart';
import 'package:app_mobile_afms/features/lab_request/data/repositories/lab_request_repository_impl.dart';
import 'package:app_mobile_afms/features/lab_request/domain/entities/lab_request.dart';
import 'package:app_mobile_afms/features/lab_request/domain/entities/lab_request_list_data.dart';
import 'package:app_mobile_afms/features/lab_request/domain/repositories/lab_request_repository.dart';
import 'package:app_mobile_afms/features/lab_request/domain/usecases/create_lab_request.dart';
import 'package:app_mobile_afms/features/lab_request/domain/usecases/get_lab_request_list.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lab_request_provider.g.dart';

/// Provider for Lab Request remote data source.
///
/// Uses [AppConfig.useMockApi] to determine whether to use mock or real API.
@Riverpod(keepAlive: true)
LabRequestRemoteDataSource labRequestRemoteDataSource(
  LabRequestRemoteDataSourceRef ref,
) {
  final config = ref.watch(appConfigProvider);

  // Use mock API if configured for current flavor
  if (config.useMockApi) {
    return LabRequestRemoteDataSourceMock(config: config);
  }

  // TODO: Return real API implementation when available
  // return LabRequestRemoteDataSourceImpl(config: config, dio: ref.watch(dioProvider));

  // Fallback to mock for now
  return LabRequestRemoteDataSourceMock(config: config);
}

/// Provider for Lab Request repository.
@Riverpod(keepAlive: true)
LabRequestRepository labRequestRepository(LabRequestRepositoryRef ref) {
  final remoteDataSource = ref.watch(labRequestRemoteDataSourceProvider);
  return LabRequestRepositoryImpl(remoteDataSource: remoteDataSource);
}

/// Provider for CreateLabRequest use case.
@Riverpod(keepAlive: true)
CreateLabRequest createLabRequest(CreateLabRequestRef ref) {
  final repository = ref.watch(labRequestRepositoryProvider);
  return CreateLabRequest(repository);
}

/// Provider for GetLabRequestList use case.
@Riverpod(keepAlive: true)
GetLabRequestList getLabRequestList(GetLabRequestListRef ref) {
  final repository = ref.watch(labRequestRepositoryProvider);
  return GetLabRequestList(repository);
}

/// Provider for creating a lab request.
///
/// This is a family provider that takes a [LabRequest] as parameter.
@riverpod
Future<LabRequest> submitLabRequest(
  SubmitLabRequestRef ref,
  LabRequest request,
) async {
  final useCase = ref.read(createLabRequestProvider);
  final result = await useCase.call(request);
  return result.fold<LabRequest>(
    (failure) => throw Exception(failure.message),
    (request) => request,
  );
}

/// Provider for getting lab request list.
///
/// This provider can be refreshed to reload the list.
/// Uses a family provider to accept optional date filters.
@riverpod
Future<LabRequestListData> labRequestListData(
  LabRequestListDataRef ref, {
  DateTime? startDate,
  DateTime? endDate,
}) async {
  final useCase = ref.read(getLabRequestListProvider);
  final result = await useCase.call(startDate: startDate, endDate: endDate);
  return result.fold<LabRequestListData>(
    (failure) => throw Exception(failure.message),
    (data) => data,
  );
}
