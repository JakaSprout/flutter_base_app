import 'package:app_mobile_afms/core/di/providers/database_provider.dart';
import 'package:app_mobile_afms/core/di/providers/dio_provider.dart';
import 'package:app_mobile_afms/core/reference_data/data/cache/reference_data_cache.dart';
import 'package:app_mobile_afms/core/reference_data/data/datasources/local/reference_data_local_datasource.dart';
import 'package:app_mobile_afms/core/reference_data/data/datasources/remote/reference_data_remote_datasource.dart';
import 'package:app_mobile_afms/core/reference_data/data/repositories/reference_data_repository_impl.dart';
import 'package:app_mobile_afms/core/reference_data/domain/repositories/reference_data_repository.dart';
import 'package:app_mobile_afms/core/reference_data/domain/services/reference_data_seeder.dart';
import 'package:app_mobile_afms/core/reference_data/domain/services/reference_data_updater.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reference_data_providers.g.dart';

@Riverpod(keepAlive: true)
ReferenceDataCache referenceDataCache(ReferenceDataCacheRef ref) {
  return ReferenceDataCache();
}

@riverpod
ReferenceDataLocalDatasource referenceDataLocalDatasource(
  ReferenceDataLocalDatasourceRef ref,
) {
  final db = ref.watch(databaseProvider);
  return ReferenceDataLocalDatasource(db);
}

@riverpod
ReferenceDataRemoteDatasource referenceDataRemoteDatasource(
  ReferenceDataRemoteDatasourceRef ref,
) {
  final dio = ref.watch(dioProvider);
  return ReferenceDataRemoteDatasourceImpl(dio: dio);
}

@Riverpod(keepAlive: true)
ReferenceDataRepository referenceDataRepository(
  ReferenceDataRepositoryRef ref,
) {
  final local = ref.watch(referenceDataLocalDatasourceProvider);
  final remote = ref.watch(referenceDataRemoteDatasourceProvider);
  final cache = ref.watch(referenceDataCacheProvider);
  return ReferenceDataRepositoryImpl(
    localDatasource: local,
    remoteDatasource: remote,
    cache: cache,
  );
}

@riverpod
ReferenceDataSeeder referenceDataSeeder(ReferenceDataSeederRef ref) {
  final repo = ref.watch(referenceDataRepositoryProvider);
  return ReferenceDataSeeder(repo);
}

@Riverpod(keepAlive: true)
ReferenceDataUpdater referenceDataUpdater(ReferenceDataUpdaterRef ref) {
  final repo = ref.watch(referenceDataRepositoryProvider);
  final updater = ReferenceDataUpdater(repo);
  ref.onDispose(updater.stop);
  return updater;
}
