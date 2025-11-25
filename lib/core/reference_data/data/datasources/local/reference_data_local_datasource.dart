import 'package:app_mobile_afms/core/database/app_database.dart';
import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:app_mobile_afms/core/reference_data/domain/entities/reference_data_entities.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart' as drift;

/// Local datasource interface for reference data operations.
///
/// Provides access to cached reference data stored in local SQLite database.
/// Used for offline-first functionality.
abstract class ReferenceDataLocalDatasource {
  /// Gets all farms from local database.
  ///
  /// Returns [Either] containing [Failure] on error or [List<FarmSummary>] on success.
  Future<Either<Failure, List<FarmSummary>>> getFarms();

  /// Gets all ponds from local database.
  ///
  /// Returns [Either] containing [Failure] on error or [List<PondSummary>] on success.
  Future<Either<Failure, List<PondSummary>>> getPonds();

  /// Gets all employees from local database.
  ///
  /// Returns [Either] containing [Failure] on error or [List<EmployeeSummary>] on success.
  Future<Either<Failure, List<EmployeeSummary>>> getEmployees();

  /// Gets all customers from local database.
  ///
  /// Returns [Either] containing [Failure] on error or [List<CustomerSummary>] on success.
  // TODO: Re-enable when customers API is implemented
  // Future<Either<Failure, List<CustomerSummary>>> getCustomers();

  /// Gets all lab test types from local database.
  ///
  /// Returns [Either] containing [Failure] on error or [List<LabTestTypeEntity>] on success.
  Future<Either<Failure, List<LabTestTypeEntity>>> getLabTestTypes();

  /// Gets all capacity references from local database.
  ///
  /// Returns [Either] containing [Failure] on error or [List<CapacityReference>] on success.
  Future<Either<Failure, List<CapacityReference>>> getCapacityReferences();

  /// Gets all units from local database.
  ///
  /// Returns [Either] containing [Failure] on error or [List<UnitEntity>] on success.
  Future<Either<Failure, List<UnitEntity>>> getUnits();

  /// Saves farms to local database.
  ///
  /// [farms] List of farms to save.
  /// Returns [Either] containing [Failure] on error or [int] (count saved) on success.
  Future<Either<Failure, int>> saveFarms(List<FarmSummary> farms);

  /// Saves ponds to local database.
  ///
  /// [ponds] List of ponds to save.
  /// Returns [Either] containing [Failure] on error or [int] (count saved) on success.
  Future<Either<Failure, int>> savePonds(List<PondSummary> ponds);

  /// Saves employees to local database.
  ///
  /// [employees] List of employees to save.
  /// Returns [Either] containing [Failure] on error or [int] (count saved) on success.
  Future<Either<Failure, int>> saveEmployees(List<EmployeeSummary> employees);

  /// Saves customers to local database.
  ///
  /// [customers] List of customers to save.
  /// Returns [Either] containing [Failure] on error or [int] (count saved) on success.
  // TODO: Re-enable when customers API is implemented
  // Future<Either<Failure, int>> saveCustomers(List<CustomerSummary> customers);

  /// Saves lab test types to local database.
  ///
  /// [labTestTypes] List of lab test types to save.
  /// Returns [Either] containing [Failure] on error or [int] (count saved) on success.
  Future<Either<Failure, int>> saveLabTestTypes(
    List<LabTestTypeEntity> labTestTypes,
  );

  /// Saves capacity references to local database.
  ///
  /// [capacityReferences] List of capacity references to save.
  /// Returns [Either] containing [Failure] on error or [int] (count saved) on success.
  Future<Either<Failure, int>> saveCapacityReferences(
    List<CapacityReference> capacityReferences,
  );

  /// Saves units to local database.
  ///
  /// [units] List of units to save.
  /// Returns [Either] containing [Failure] on error or [int] (count saved) on success.
  Future<Either<Failure, int>> saveUnits(List<UnitEntity> units);

  /// Clears all reference data from local database.
  ///
  /// Returns [Either] containing [Failure] on error or [bool] (success) on success.
  Future<Either<Failure, bool>> clearAllData();
}

/// Implementation of ReferenceDataLocalDatasource using Drift.
class ReferenceDataLocalDatasourceImpl implements ReferenceDataLocalDatasource {
  /// Creates a new instance of [ReferenceDataLocalDatasourceImpl].
  const ReferenceDataLocalDatasourceImpl({required this.database});

  /// Drift database instance.
  final AppDatabase database;

  /// Maps API status to database access level.
  String _mapStatusToAccessLevel(String? status) {
    if (status == null) return 'Limited';
    switch (status.toLowerCase()) {
      case 'active':
        return 'Full';
      case 'inactive':
        return 'Read_Only';
      default:
        return 'Limited';
    }
  }

  /// Maps API status to database employee status.
  String _mapApiStatusToDbStatus(String? status) {
    if (status == null) return 'Active';
    return status.toLowerCase() == 'active' ? 'Active' : 'Inactive';
  }

  /// Maps API role to database employee role.
  String _mapApiRoleToDbRole(String? role) {
    if (role == null) return 'Technician';
    switch (role.toLowerCase()) {
      case 'admin':
        return 'Admin';
      case 'manager':
        return 'Manager';
      case 'technician':
        return 'Technician';
      case 'lab_technician':
        return 'Lab_Technician';
      case 'ho':
        return 'HO';
      default:
        return 'Technician'; // Default fallback
    }
  }

  @override
  Future<Either<Failure, List<FarmSummary>>> getFarms() async {
    try {
      final farms = await database.select(database.fmsMtFarms).get();
      final farmSummaries = farms.map((farm) {
        return FarmSummary(
          id: farm.farmUuid,
          code: farm.farmCode,
          name: farm.farmName,
          location: farm.farmLocation,
          latitude: farm.latitude,
          longitude: farm.longitude,
          area: farm.farmArea,
          areaUnit: farm.farmAreaUnit,
          ownerName: farm.ownerName,
          contactInfo: farm.contactInfo,
          establishedDate: farm.establishedDate,
          isActive: farm.isActive ?? true,
        );
      }).toList();
      return Right(farmSummaries);
    } catch (e) {
      return Left(
        CacheFailure(message: 'Failed to get farms from local database: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<PondSummary>>> getPonds() async {
    try {
      final ponds = await database.select(database.fmsMtPonds).get();
      final pondSummaries = ponds.map((pond) {
        return PondSummary(
          id: pond.pondUuid,
          code: pond.pondCode,
          name: pond.pondName ?? pond.pondCode,
          farmId: pond.farmId?.toString(),
          size: pond.pondSize,
          sizeUnit: pond.pondSizeUnit,
          pwa: pond.pwa,
          pwaUnit: pond.pwaUnit,
          depth: pond.depth,
          depthUnit: pond.depthUnit,
          pondType: pond.pondType,
          pondStatus: pond.pondStatus,
          isActive: pond.isActive ?? true,
        );
      }).toList();
      return Right(pondSummaries);
    } catch (e) {
      return Left(
        CacheFailure(message: 'Failed to get ponds from local database: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<EmployeeSummary>>> getEmployees() async {
    try {
      final employees = await database.select(database.fmsMtEmployees).get();
      final employeeSummaries = employees.map((employee) {
        return EmployeeSummary(
          id: employee.employeeUuid,
          name: employee.employeeName,
          code: employee.employeeCode,
          username: employee.username,
          email: employee.email,
          phoneNumber: employee.phoneNumber,
          role: employee.employeeRole,
          status: employee.employeeStatus,
          isActive: employee.employeeStatus == 'Active',
        );
      }).toList();
      return Right(employeeSummaries);
    } catch (e) {
      return Left(
        CacheFailure(
          message: 'Failed to get employees from local database: $e',
        ),
      );
    }
  }

  // TODO: Re-enable when customers API is implemented
  // @override
  // Future<Either<Failure, List<CustomerSummary>>> getCustomers() async {
  //   try {
  //     // TODO: Implement when local database tables are ready
  //     // For now, return empty list
  //     return const Right([]);
  //   } catch (e) {
  //     return Left(
  //       CacheFailure(
  //         message: 'Failed to get customers from local database: $e',
  //       ),
  //     );
  //   }
  // }

  @override
  Future<Either<Failure, List<LabTestTypeEntity>>> getLabTestTypes() async {
    try {
      // TODO: Implement when local database tables are ready
      // For now, return empty list
      return const Right([]);
    } catch (e) {
      return Left(
        CacheFailure(
          message: 'Failed to get lab test types from local database: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> saveFarms(List<FarmSummary> farms) async {
    try {
      AppLogger.debug('Saving ${farms.length} farms to database');
      await database.batch((batch) {
        for (final farm in farms) {
          AppLogger.debug(
            'Saving farm: ${farm.code} with farmUuid: ${farm.id}',
          );
          batch.insert(
            database.fmsMtFarms,
            FmsMtFarmsCompanion(
              farmUuid: drift.Value(farm.id),
              farmCode: drift.Value(farm.code),
              farmName: drift.Value(farm.name),
              farmLocation: drift.Value(farm.location),
              latitude: drift.Value(farm.latitude),
              longitude: drift.Value(farm.longitude),
              farmArea: drift.Value(farm.area),
              farmAreaUnit: drift.Value(farm.areaUnit),
              ownerName: drift.Value(farm.ownerName),
              contactInfo: drift.Value(farm.contactInfo),
              establishedDate: drift.Value(farm.establishedDate),
              isActive: drift.Value(farm.isActive),
            ),
            mode: drift.InsertMode.insertOrReplace,
          );
        }
      });
      AppLogger.debug('Successfully saved ${farms.length} farms to database');
      return Right(farms.length);
    } catch (e) {
      return Left(
        CacheFailure.writeError('Failed to save farms to local database: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, int>> savePonds(List<PondSummary> ponds) async {
    try {
      // First, collect all the farmId lookups outside the batch
      AppLogger.debug(
        'Starting to save ${ponds.length} ponds, checking existing farms...',
      );
      final allFarms = await database.select(database.fmsMtFarms).get();
      AppLogger.debug(
        'Found ${allFarms.length} farms in database: ${allFarms.map((f) => 'farmId:${f.farmId}, farmUuid:${f.farmUuid}').join(', ')}',
      );

      final pondFarmIds = <String, int?>{};
      for (final pond in ponds) {
        if (pond.farmId != null) {
          AppLogger.debug(
            'Looking for farm with farmUuid: "${pond.farmId}" (type: ${pond.farmId.runtimeType}) for pond: ${pond.code}',
          );

          // Try a more explicit query
          final farms = await (database.select(
            database.fmsMtFarms,
          )..where((f) => f.farmUuid.equals(pond.farmId!))).get();
          AppLogger.debug(
            'Query returned ${farms.length} results for farmUuid "${pond.farmId}"',
          );

          final farm = farms.isNotEmpty ? farms.first : null;
          AppLogger.debug(
            'Using first result - Found farm: ${farm?.farmId}, farmUuid: "${farm?.farmUuid}" (type: ${farm?.farmUuid.runtimeType})',
          );
          pondFarmIds[pond.id] = farm?.farmId;

          // Debug logging
          if (farm == null) {
            AppLogger.warning(
              'Failed to find farm with farmUuid: "${pond.farmId}" for pond: ${pond.code} - farm is null',
            );
          } else
            AppLogger.debug(
              'Successfully found farmId: ${farm.farmId} for farmUuid: "${pond.farmId}" and pond: ${pond.code}',
            );
        } else {
          AppLogger.warning('Pond ${pond.code} has null farmId');
          pondFarmIds[pond.id] = null;
        }
      }

      // Debug: Log pondFarmIds map contents
      AppLogger.debug('pondFarmIds map contents (first 5):');
      pondFarmIds.entries.take(5).forEach((entry) {
        AppLogger.debug('  Pond ${entry.key}: farmId = ${entry.value}');
      });

      // Then batch insert all ponds
      await database.batch((batch) {
        for (final pond in ponds) {
          final farmId = pondFarmIds[pond.id];
          AppLogger.debug(
            'Inserting pond ${pond.code} with farmId: $farmId (type: ${farmId?.runtimeType})',
          );

          batch.insert(
            database.fmsMtPonds,
            FmsMtPondsCompanion(
              pondUuid: drift.Value(pond.id),
              farmId: drift.Value(farmId),
              pondCode: drift.Value(pond.code),
              pondName: drift.Value(pond.name),
              pondSize: drift.Value(pond.size),
              pondSizeUnit: drift.Value(pond.sizeUnit ?? 'sqm'),
              pwa: drift.Value(pond.pwa),
              pwaUnit: drift.Value(pond.pwaUnit ?? 'sqm'),
              depth: drift.Value(pond.depth),
              depthUnit: drift.Value(pond.depthUnit ?? 'meter'),
              maxDepth: drift.Value(pond.maxDepth),
              maxDepthUnit: drift.Value(pond.maxDepthUnit ?? 'meter'),
              volume: drift.Value(pond.volume),
              volumeUnit: drift.Value(pond.volumeUnit ?? 'cubic_meter'),
              pondType: drift.Value(pond.pondType),
              pondShape: drift.Value(pond.pondShape),
              bottomType: drift.Value(pond.bottomType),
              hasAerator: drift.Value(pond.hasAerator ?? false),
              aeratorCount: drift.Value(pond.aeratorCount),
              aeratorTotalHp: drift.Value(pond.aeratorTotalHp),
              hasCentralDrain: drift.Value(pond.hasCentralDrain ?? false),
              waterSource: drift.Value(pond.waterSource),
              pondStatus: drift.Value(pond.pondStatus ?? 'Available'),
              currentCycleId: drift.Value(pond.currentCycleId),
              maxBiomass: drift.Value(pond.maxBiomass),
              maxBiomassUnit: drift.Value(pond.maxBiomassUnit ?? 'kg_per_sqm'),
              recommendedStockingDensity: drift.Value(
                pond.recommendedStockingDensity,
              ),
              isActive: drift.Value(pond.isActive),
              createdDate: drift.Value(pond.createdAt),
              deletedDate: drift.Value(pond.deletedAt),
            ),
            mode: drift.InsertMode.insertOrReplace,
          );
        }
      });

      // Verify that ponds were saved with correct farmId
      AppLogger.debug('Verifying saved ponds...');
      for (final pond in ponds.take(3)) {
        // Check first 3 ponds
        final savedPond = await (database.select(
          database.fmsMtPonds,
        )..where((p) => p.pondUuid.equals(pond.id))).getSingleOrNull();
        AppLogger.debug(
          'Saved pond ${pond.code}: farmId = ${savedPond?.farmId}',
        );
      }

      return Right(ponds.length);
    } catch (e) {
      // Log detailed error for debugging
      AppLogger.error('Failed to save ponds to local database', e);
      return Left(
        CacheFailure.writeError('Failed to save ponds to local database: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, int>> saveEmployees(
    List<EmployeeSummary> employees,
  ) async {
    try {
      await database.batch((batch) {
        for (final employee in employees) {
          batch.insert(
            database.fmsMtEmployees,
            FmsMtEmployeesCompanion(
              employeeUuid: drift.Value(employee.id),
              employeeCode: drift.Value(employee.code),
              employeeName: drift.Value(employee.name),
              username: drift.Value(employee.username),
              email: drift.Value(employee.email),
              phoneNumber: drift.Value(employee.phoneNumber),
              employeeRole: drift.Value(_mapApiRoleToDbRole(employee.role)),
              userAccessLevel: drift.Value(
                _mapStatusToAccessLevel(employee.status),
              ),
              employeeStatus: drift.Value(
                _mapApiStatusToDbStatus(employee.status),
              ),
            ),
            mode: drift.InsertMode.insertOrReplace,
          );
        }
      });
      return Right(employees.length);
    } catch (e) {
      // Log detailed error for debugging
      AppLogger.error('Failed to save employees to local database', e);
      return Left(
        CacheFailure.writeError(
          'Failed to save employees to local database: $e',
        ),
      );
    }
  }

  // TODO: Re-enable when customers API is implemented
  // @override
  // Future<Either<Failure, int>> saveCustomers(
  //   List<CustomerSummary> customers,
  // ) async {
  //   try {
  //     // TODO: Implement when local database tables are ready
  //     // For now, return success with count
  //     return Right(customers.length);
  //   } catch (e) {
  //     return Left(
  //       CacheFailure.writeError(
  //         'Failed to save customers to local database: $e',
  //       ),
  //     );
  //   }
  // }

  @override
  Future<Either<Failure, int>> saveLabTestTypes(
    List<LabTestTypeEntity> labTestTypes,
  ) async {
    try {
      // TODO: Implement when local database tables are ready
      // For now, return success with count
      return Right(labTestTypes.length);
    } catch (e) {
      return Left(
        CacheFailure.writeError(
          'Failed to save lab test types to local database: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<CapacityReference>>>
  getCapacityReferences() async {
    try {
      final capacityRefs = await database
          .select(database.fms10CapacityReferences)
          .get();
      final capacityReferences = capacityRefs.map((ref) {
        return CapacityReference(
          id: ref.capacityRefUuid,
          commodityCode: ref.commodityCode,
          commodityName: ref.commodityNameEn ?? ref.commodityNameId ?? '',
          possibleTechnology:
              ref.possibleTechnologyEn ?? ref.possibleTechnologyId,
          category: ref.categoryEn ?? ref.categoryId,
          intensityLevel: ref.intensityLevelEn ?? ref.intensityLevelId,
          maxCapacity: ref.maxCapacity,
          maxCapacityUnit: ref.maxCapacityUnit,
          maxCapacityKgPerSqm: ref.maxCapacityKgPerSqm,
          maxCapacityNotes: ref.maxCapacityNotes,
          scientificReferences: ref.scientificReferences,
          referenceUrls: ref.referenceUrls?.split(','),
          isActive: ref.isActive ?? true,
        );
      }).toList();
      return Right(capacityReferences);
    } catch (e) {
      return Left(
        CacheFailure.writeError(
          'Failed to get capacity references from local database: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<UnitEntity>>> getUnits() async {
    try {
      final units = await database.select(database.fmsMtUnits).get();
      final unitEntities = units.map((unit) {
        return UnitEntity(
          id: unit.unitCode,
          code: unit.unitCode,
          category: unit.unitCategory,
          name: unit.unitNameEn ?? unit.unitNameId,
          symbol: unit.unitSymbol,
          description: unit.unitDescriptionEn ?? unit.unitDescriptionId,
          isBaseUnit: unit.isBaseUnit,
          baseUnitCode: unit.baseUnitCode,
          conversionFactor: unit.defaultConversionFactor,
          isDynamic: unit.isDynamic,
          isMetric: unit.isMetric,
          displayDecimals: unit.displayDecimals,
          sortOrder: unit.sortOrder,
          isActive: unit.isActive ?? true,
        );
      }).toList();
      return Right(unitEntities);
    } catch (e) {
      return Left(
        CacheFailure.writeError('Failed to get units from local database: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, int>> saveCapacityReferences(
    List<CapacityReference> capacityReferences,
  ) async {
    try {
      await database.batch((batch) {
        for (final ref in capacityReferences) {
          batch.insert(
            database.fms10CapacityReferences,
            Fms10CapacityReferencesCompanion(
              capacityRefUuid: drift.Value(ref.id),
              commodityCode: drift.Value(ref.commodityCode),
              commodityNameId: drift.Value(ref.commodityName),
              commodityNameEn: drift.Value(ref.commodityName),
              possibleTechnologyId: drift.Value(ref.possibleTechnology ?? ''),
              possibleTechnologyEn: drift.Value(ref.possibleTechnology ?? ''),
              categoryId: drift.Value(ref.category ?? ''),
              categoryEn: drift.Value(ref.category ?? ''),
              intensityLevelId: drift.Value(ref.intensityLevel ?? ''),
              intensityLevelEn: drift.Value(ref.intensityLevel ?? ''),
              maxCapacity: drift.Value(ref.maxCapacity ?? 0.0),
              maxCapacityUnit: drift.Value(ref.maxCapacityUnit ?? 'kg_per_sqm'),
              maxCapacityKgPerSqm: drift.Value(ref.maxCapacityKgPerSqm),
              maxCapacityNotes: drift.Value(ref.maxCapacityNotes),
              scientificReferences: drift.Value(ref.scientificReferences),
              referenceUrls: drift.Value(ref.referenceUrls?.join(',')),
              isActive: drift.Value(ref.isActive),
            ),
            mode: drift.InsertMode.insertOrReplace,
          );
        }
      });
      return Right(capacityReferences.length);
    } catch (e) {
      return Left(
        CacheFailure.writeError(
          'Failed to save capacity references to local database: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> saveUnits(List<UnitEntity> units) async {
    try {
      await database.batch((batch) {
        for (final unit in units) {
          batch.insert(
            database.fmsMtUnits,
            FmsMtUnitsCompanion(
              unitCode: drift.Value(unit.code),
              unitCategory: drift.Value(unit.category),
              unitNameId: drift.Value(unit.name),
              unitNameEn: drift.Value(unit.name),
              unitSymbol: drift.Value(unit.symbol),
              unitDescriptionId: drift.Value(unit.description),
              unitDescriptionEn: drift.Value(unit.description),
              isBaseUnit: drift.Value(unit.isBaseUnit),
              baseUnitCode: drift.Value(unit.baseUnitCode),
              defaultConversionFactor: drift.Value(unit.conversionFactor),
              isDynamic: drift.Value(unit.isDynamic),
              isMetric: drift.Value(unit.isMetric),
              displayDecimals: drift.Value(unit.displayDecimals),
              sortOrder: drift.Value(unit.sortOrder),
              isActive: drift.Value(unit.isActive),
            ),
            mode: drift.InsertMode.insertOrReplace,
          );
        }
      });
      return Right(units.length);
    } catch (e) {
      return Left(
        CacheFailure.writeError('Failed to save units to local database: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> clearAllData() async {
    try {
      // TODO: Implement when local database tables are ready
      // For now, return success
      return const Right(true);
    } catch (e) {
      return Left(
        CacheFailure.writeError('Failed to clear local database: $e'),
      );
    }
  }
}
