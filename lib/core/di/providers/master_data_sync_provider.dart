import 'package:app_mobile_afms/core/database/app_database.dart';
import 'package:app_mobile_afms/core/di/providers/database_provider.dart';
import 'package:app_mobile_afms/core/di/providers/dio_provider.dart';
import 'package:app_mobile_afms/core/reference_data/data/datasources/local/reference_data_local_datasource.dart';
import 'package:app_mobile_afms/core/reference_data/data/datasources/remote/reference_data_remote_datasource.dart';
import 'package:app_mobile_afms/core/reference_data/data/repositories/reference_data_repository_impl.dart';
import 'package:app_mobile_afms/core/reference_data/domain/repositories/reference_data_repository.dart';
import 'package:app_mobile_afms/core/reference_data/domain/services/master_data_sync_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'master_data_sync_provider.g.dart';

/// Provider for reference data remote datasource.
@Riverpod(keepAlive: true)
ReferenceDataRemoteDatasource referenceDataRemoteDatasource(
  ReferenceDataRemoteDatasourceRef ref,
) {
  final dio = ref.watch(dioProvider);
  return ReferenceDataRemoteDatasourceImpl(dio: dio);
}

/// Provider for reference data local datasource.
@Riverpod(keepAlive: true)
ReferenceDataLocalDatasource referenceDataLocalDatasource(
  ReferenceDataLocalDatasourceRef ref,
) {
  final database = ref.watch(databaseProvider);
  return ReferenceDataLocalDatasourceImpl(database: database);
}

/// Provider for reference data repository.
@Riverpod(keepAlive: true)
ReferenceDataRepository referenceDataRepository(
  ReferenceDataRepositoryRef ref,
) {
  final remoteDatasource = ref.watch(referenceDataRemoteDatasourceProvider);
  return ReferenceDataRepositoryImpl(remoteDatasource: remoteDatasource);
}

/// Provider for master data sync service.
@Riverpod(keepAlive: true)
MasterDataSyncService masterDataSyncService(MasterDataSyncServiceRef ref) {
  final repository = ref.watch(referenceDataRepositoryProvider);
  final localDatasource = ref.watch(referenceDataLocalDatasourceProvider);

  return MasterDataSyncService(
    ref: ref,
    repository: repository,
    localDatasource: localDatasource,
  );
}


