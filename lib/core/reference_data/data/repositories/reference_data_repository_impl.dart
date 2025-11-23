import 'package:app_mobile_afms/core/database/app_database.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:app_mobile_afms/core/reference_data/data/cache/reference_data_cache.dart';
import 'package:app_mobile_afms/core/reference_data/data/datasources/local/reference_data_local_datasource.dart';
import 'package:app_mobile_afms/core/reference_data/data/datasources/remote/reference_data_remote_datasource.dart';
import 'package:app_mobile_afms/core/reference_data/domain/entities/reference_data_entities.dart';
import 'package:app_mobile_afms/core/reference_data/domain/reference_data_type.dart';
import 'package:app_mobile_afms/core/reference_data/domain/repositories/reference_data_repository.dart';
import 'package:app_mobile_afms/core/reference_data/domain/value_objects/reference_data_seed_result.dart';
import 'package:drift/drift.dart';

class ReferenceDataRepositoryImpl implements ReferenceDataRepository {
  ReferenceDataRepositoryImpl({
    required ReferenceDataLocalDatasource localDatasource,
    required ReferenceDataRemoteDatasource remoteDatasource,
    required ReferenceDataCache cache,
    DateTime Function()? now,
  }) : _local = localDatasource,
       _remote = remoteDatasource,
       _cache = cache,
       _now = now ?? DateTime.now;

  final ReferenceDataLocalDatasource _local;
  final ReferenceDataRemoteDatasource _remote;
  final ReferenceDataCache _cache;
  final DateTime Function() _now;

  @override
  Future<ReferenceDataSeedSummary> seedAll({
    required String userId,
    bool force = false,
  }) async {
    final results = <ReferenceDataType, ReferenceDataSeedResult>{};
    for (final type in ReferenceDataConfig.sortByPriority(
      ReferenceDataType.values,
    )) {
      final result = await _syncType(type, userId: userId, force: force);
      results[type] = result;
    }

    final success = results.values.every((result) => result.success);
    return ReferenceDataSeedSummary(success: success, results: results);
  }

  @override
  Future<ReferenceDataSeedResult> refreshType(
    ReferenceDataType type, {
    required String userId,
    bool force = false,
  }) {
    return _syncType(type, userId: userId, force: force);
  }

  @override
  Future<List<LabTestTypeEntity>> getLabTestTypes(String userId) async {
    final cached = _cache.get<LabTestTypeEntity>(
      userId: userId,
      type: ReferenceDataType.labTestTypes,
    );
    if (cached != null) return cached;
    final data = await _local.getLabTestTypes(userId);
    _cache.set(
      userId: userId,
      type: ReferenceDataType.labTestTypes,
      data: data,
    );
    return data;
  }

  @override
  Future<List<EmployeeSummary>> getEmployees(String userId) async {
    final cached = _cache.get<EmployeeSummary>(
      userId: userId,
      type: ReferenceDataType.employees,
    );
    if (cached != null) return cached;
    final data = await _local.getEmployees(userId);
    _cache.set(userId: userId, type: ReferenceDataType.employees, data: data);
    return data;
  }

  @override
  Future<List<CustomerSummary>> getCustomers(String userId) async {
    final cached = _cache.get<CustomerSummary>(
      userId: userId,
      type: ReferenceDataType.customers,
    );
    if (cached != null) return cached;
    final data = await _local.getCustomers(userId);
    _cache.set(userId: userId, type: ReferenceDataType.customers, data: data);
    return data;
  }

  @override
  Future<List<FarmSummary>> getFarms(String userId) async {
    final cached = _cache.get<FarmSummary>(
      userId: userId,
      type: ReferenceDataType.farms,
    );
    if (cached != null) return cached;
    final data = await _local.getFarms(userId);
    _cache.set(userId: userId, type: ReferenceDataType.farms, data: data);
    return data;
  }

  @override
  Future<List<PondSummary>> getPonds(String userId) async {
    final cached = _cache.get<PondSummary>(
      userId: userId,
      type: ReferenceDataType.ponds,
    );
    if (cached != null) return cached;
    final data = await _local.getPonds(userId);
    _cache.set(userId: userId, type: ReferenceDataType.ponds, data: data);
    return data;
  }

  @override
  Future<void> purgeUserData(String userId) async {
    AppLogger.info('Purging reference data for userId=$userId');
    _cache.clearForUser(userId);
    await _local.deleteAllForUser(userId);
  }

  Future<ReferenceDataSeedResult> _syncType(
    ReferenceDataType type, {
    required String userId,
    required bool force,
  }) async {
    final metadata = await _local.getMetadata(userId, type);

    if (!force && _isFresh(metadata, type)) {
      return ReferenceDataSeedResult.cachedResult(type);
    }

    try {
      switch (type) {
        case ReferenceDataType.labTestTypes:
          final response = await _remote.fetchLabTestTypes(userId);
          await _local.replaceLabTestTypes(userId, response.data);
          await _writeSuccessMetadata(
            userId: userId,
            type: type,
            metadata: metadata,
            recordCount: response.data.length,
            etag: response.etag,
            version: response.version,
            lastUpdatedAt: metadata?.lastUpdatedAt ?? response.fetchedAt,
          );
          _cache.set(userId: userId, type: type, data: response.data);
          return ReferenceDataSeedResult(
            dataType: type,
            success: true,
            recordCount: response.data.length,
          );
        case ReferenceDataType.employees:
          final response = await _remote.fetchEmployees(userId);
          await _local.replaceEmployees(userId, response.data);
          await _writeSuccessMetadata(
            userId: userId,
            type: type,
            metadata: metadata,
            recordCount: response.data.length,
            etag: response.etag,
            version: response.version,
            lastUpdatedAt: metadata?.lastUpdatedAt ?? response.fetchedAt,
          );
          _cache.set(userId: userId, type: type, data: response.data);
          return ReferenceDataSeedResult(
            dataType: type,
            success: true,
            recordCount: response.data.length,
          );
        case ReferenceDataType.customers:
          final response = await _remote.fetchCustomers(userId);
          await _local.replaceCustomers(userId, response.data);
          await _writeSuccessMetadata(
            userId: userId,
            type: type,
            metadata: metadata,
            recordCount: response.data.length,
            etag: response.etag,
            version: response.version,
            lastUpdatedAt: metadata?.lastUpdatedAt ?? response.fetchedAt,
          );
          _cache.set(userId: userId, type: type, data: response.data);
          return ReferenceDataSeedResult(
            dataType: type,
            success: true,
            recordCount: response.data.length,
          );
        case ReferenceDataType.farms:
          final response = await _remote.fetchFarms(userId);
          await _local.replaceFarms(userId, response.data);
          await _writeSuccessMetadata(
            userId: userId,
            type: type,
            metadata: metadata,
            recordCount: response.data.length,
            etag: response.etag,
            version: response.version,
            lastUpdatedAt: metadata?.lastUpdatedAt ?? response.fetchedAt,
          );
          _cache.set(userId: userId, type: type, data: response.data);
          return ReferenceDataSeedResult(
            dataType: type,
            success: true,
            recordCount: response.data.length,
          );
        case ReferenceDataType.ponds:
          final response = await _remote.fetchPonds(userId);
          await _local.replacePonds(userId, response.data);
          await _writeSuccessMetadata(
            userId: userId,
            type: type,
            metadata: metadata,
            recordCount: response.data.length,
            etag: response.etag,
            version: response.version,
            lastUpdatedAt: metadata?.lastUpdatedAt ?? response.fetchedAt,
          );
          _cache.set(userId: userId, type: type, data: response.data);
          return ReferenceDataSeedResult(
            dataType: type,
            success: true,
            recordCount: response.data.length,
          );
      }
    } catch (error, stackTrace) {
      AppLogger.error(
        'Reference data sync failed for ${type.label}',
        error,
        stackTrace,
      );
      await _writeFailureMetadata(
        userId: userId,
        type: type,
        metadata: metadata,
        error: error,
      );
      return ReferenceDataSeedResult(
        dataType: type,
        success: false,
        recordCount: metadata?.recordCount ?? 0,
        error: error.toString(),
      );
    }
  }

  bool _isFresh(ReferenceDataMetadataEntry? metadata, ReferenceDataType type) {
    if (metadata == null) return false;
    final ttl = ReferenceDataConfig.ttlFor(type);
    final age = _now().difference(metadata.lastFetchedAt);
    return age < ttl;
  }

  Future<void> _writeSuccessMetadata({
    required String userId,
    required ReferenceDataType type,
    required ReferenceDataMetadataEntry? metadata,
    required int recordCount,
    String? etag,
    String? version,
    DateTime? lastUpdatedAt,
  }) {
    final now = _now();
    final companion = ReferenceDataMetadataEntriesCompanion(
      userId: Value(userId),
      dataType: Value(type.key),
      lastFetchedAt: Value(now),
      lastUpdatedAt: Value(lastUpdatedAt ?? now),
      version: Value(version),
      etag: Value(etag),
      recordCount: Value(recordCount),
      syncStatus: const Value('synced'),
      lastError: const Value(null),
      retryCount: const Value(0),
      createdAt: metadata == null ? Value(now) : const Value.absent(),
    );
    return _local.upsertMetadata(companion);
  }

  Future<void> _writeFailureMetadata({
    required String userId,
    required ReferenceDataType type,
    required ReferenceDataMetadataEntry? metadata,
    required Object error,
  }) {
    final now = _now();
    final companion = ReferenceDataMetadataEntriesCompanion(
      userId: Value(userId),
      dataType: Value(type.key),
      lastFetchedAt: Value(metadata?.lastFetchedAt ?? now),
      lastUpdatedAt: Value(metadata?.lastUpdatedAt),
      version: Value(metadata?.version),
      etag: Value(metadata?.etag),
      recordCount: Value(metadata?.recordCount ?? 0),
      syncStatus: const Value('error'),
      lastError: Value(error.toString()),
      retryCount: Value((metadata?.retryCount ?? 0) + 1),
      createdAt: metadata == null ? Value(now) : const Value.absent(),
    );
    return _local.upsertMetadata(companion);
  }
}
