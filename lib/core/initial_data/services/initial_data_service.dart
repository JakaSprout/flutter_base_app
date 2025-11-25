import 'package:app_mobile_afms/core/database/app_database.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';

/// Service for seeding initial data into the database
/// This is used for first-time setup and provides basic employee, farm, and pond data
class InitialDataService {
  InitialDataService(this.database, this.dio);

  final AppDatabase database;
  final Dio dio;

  /// Seed initial data (employees, then farms, then ponds)
  /// Returns true if all seeding completed successfully
  Future<bool> seedInitialData() async {
    try {
      AppLogger.info(
        '[InitialDataService] Starting initial data seeding with upsert',
      );

      // Seed employees (upsert - insert or update)
      final employeesResult = await seedInitialEmployees();
      if (!employeesResult) {
        AppLogger.error('[InitialDataService] Employee seeding failed');
        return false;
      }

      // Seed farms (upsert - insert or update)
      final farmsResult = await seedInitialFarms();
      if (!farmsResult) {
        AppLogger.error('[InitialDataService] Farm seeding failed');
        return false;
      }

      // Seed ponds (upsert - insert or update)
      final pondsResult = await seedInitialPonds();
      if (!pondsResult) {
        AppLogger.error('[InitialDataService] Pond seeding failed');
        return false;
      }

      // Seed capacity references (upsert - insert or update)
      final capacityRefsResult = await seedInitialCapacityReferences();
      if (!capacityRefsResult) {
        AppLogger.error(
          '[InitialDataService] Capacity references seeding failed',
        );
        return false;
      }

      AppLogger.info(
        '[InitialDataService] Initial data seeding completed successfully',
      );
      return true;
    } catch (e) {
      AppLogger.error('[InitialDataService] Initial data seeding failed: $e');
      return false;
    }
  }

  /// Seed initial employee data from API using upsert
  /// Returns true if seeding completed successfully
  Future<bool> seedInitialEmployees() async {
    AppLogger.info(
      '[InitialDataService] Starting initial employee data seeding from API',
    );

    try {
      // Fetch employees from API
      final response = await dio.get('/api/v1/employees?limit=100');

      if (response.statusCode != 200) {
        AppLogger.error(
          '[InitialDataService] Failed to fetch employees from API: ${response.statusCode}',
        );
        return false;
      }

      final responseData = response.data as Map<String, dynamic>;
      final data = responseData['data'] as List<dynamic>;

      AppLogger.info(
        '[InitialDataService] Fetched ${data.length} employees from API',
      );

      await database.transaction(() async {
        for (final employeeJson in data) {
          try {
            final employeeData = employeeJson as Map<String, dynamic>;

            // Create employee companion
            final employeeCompanion = FmsMtEmployeesCompanion(
              employeeId: Value(employeeData['id'] as int),
              employeeUuid: Value(employeeData['userId'] as String),
              employeeCode: Value(employeeData['employeeCode'] as String),
              employeeName: Value(employeeData['employeeName'] as String),
              username: Value(employeeData['username'] as String?),
              employeeRole: Value(
                _mapApiEmployeeRoleToDb(
                  employeeData['employeeRole'] as String?,
                ),
              ),
              employeeStatus: Value(
                employeeData['employeeStatus'] == 'active'
                    ? 'Active'
                    : 'Inactive',
              ),
              email: Value(employeeData['email'] as String?),
              phoneNumber: Value(employeeData['contactInfo'] as String?),
              createdDate: Value(
                employeeData['createdAt'] != null
                    ? DateTime.parse(employeeData['createdAt'] as String)
                    : DateTime.now(),
              ),
            );

            // Upsert employee (insert or update on conflict)
            // Use insertOne with DoUpdate and target employeeCode for unique constraint handling
            await database.fmsMtEmployees.insertOne(
              employeeCompanion,
              onConflict: DoUpdate(
                (old) => employeeCompanion,
                target: [
                  database.fmsMtEmployees.employeeCode,
                ], // Specify employee_code as conflict target
              ),
            );

            AppLogger.debug(
              '[InitialDataService] Successfully upserted employee: ${employeeData['employeeCode']}',
            );
          } catch (e) {
            AppLogger.error(
              '[InitialDataService] Failed to upsert employee: $e',
            );
            // Continue with other employees even if one fails
          }
        }
      });

      AppLogger.info(
        '[InitialDataService] Initial employee data seeding completed: ${data.length} employees processed',
      );
      return true;
    } catch (e) {
      AppLogger.error(
        '[InitialDataService] Failed to seed initial employee data from API: $e',
      );
      return false;
    }
  }

  /// Seed initial farm data from API using upsert
  /// Returns true if seeding completed successfully
  Future<bool> seedInitialFarms() async {
    AppLogger.info(
      '[InitialDataService] Starting initial farm data seeding from API',
    );

    try {
      // Fetch farms from API
      final response = await dio.get('/api/v1/farms?limit=100');

      if (response.statusCode != 200) {
        AppLogger.error(
          '[InitialDataService] Failed to fetch farms from API: ${response.statusCode}',
        );
        return false;
      }

      final responseData = response.data as Map<String, dynamic>;
      final data = responseData['data'] as List<dynamic>;

      AppLogger.info(
        '[InitialDataService] Fetched ${data.length} farms from API',
      );

      await database.transaction(() async {
        for (final farmJson in data) {
          final farmData = farmJson as Map<String, dynamic>;
          try {
            // Create farm companion
            final farmCompanion = FmsMtFarmsCompanion(
              farmUuid: Value(farmData['farm_uuid'] as String),
              farmCode: Value(farmData['farm_code'] as String),
              farmName: Value(farmData['farm_name'] as String),
              farmLocation: Value(farmData['farm_location'] as String?),
              latitude: Value(
                farmData['latitude'] != null
                    ? (farmData['latitude'] as num).toDouble()
                    : null,
              ),
              longitude: Value(
                farmData['longitude'] != null
                    ? (farmData['longitude'] as num).toDouble()
                    : null,
              ),
              farmArea: Value(
                farmData['farm_area_sqm'] != null
                    ? (farmData['farm_area_sqm'] as num).toDouble()
                    : null,
              ),
              farmAreaUnit: const Value('sqm'), // Default unit from API
              ownerName: Value(farmData['owner_name'] as String?),
              contactInfo: Value(farmData['contact_info'] as String?),
              isActive: Value(farmData['is_active'] as bool? ?? true),
              createdDate: Value(
                farmData['created_at'] != null
                    ? DateTime.parse(farmData['created_at'] as String)
                    : DateTime.now(),
              ),
              createdBy: Value(
                farmData['created_by'] != null
                    ? int.tryParse(farmData['created_by'].toString())
                    : null,
              ),
              lastUpdatedBy: Value(
                farmData['last_updated_by'] != null
                    ? int.tryParse(farmData['last_updated_by'].toString())
                    : null,
              ),
            );

            // Upsert farm (insert or update on conflict)
            // Use insertOne with DoUpdate and target farmCode for unique constraint handling
            await database.fmsMtFarms.insertOne(
              farmCompanion,
              onConflict: DoUpdate(
                (old) => farmCompanion,
                target: [
                  database.fmsMtFarms.farmCode,
                ], // Specify farm_code as conflict target
              ),
            );

            AppLogger.debug(
              '[InitialDataService] Successfully upserted farm: ${farmData['farm_code']}',
            );
          } catch (e, stackTrace) {
            AppLogger.error('[InitialDataService] Failed to upsert farm: $e');
            AppLogger.error(
              '[InitialDataService] Farm data that failed: $farmData',
            );
            AppLogger.error('[InitialDataService] Stack trace: $stackTrace');
            // Continue with other farms even if one fails
          }
        }
      });

      AppLogger.info(
        '[InitialDataService] Initial farm data seeding completed: ${data.length} farms processed',
      );
      return true;
    } catch (e) {
      AppLogger.error(
        '[InitialDataService] Failed to seed initial farm data from API: $e',
      );
      return false;
    }
  }

  /// Seed initial pond data from API using upsert
  /// Returns true if seeding completed successfully
  Future<bool> seedInitialPonds() async {
    AppLogger.info(
      '[InitialDataService] Starting initial pond data seeding from API',
    );

    try {
      // Fetch ponds from API
      final response = await dio.get('/api/v1/ponds?limit=100');

      if (response.statusCode != 200) {
        AppLogger.error(
          '[InitialDataService] Failed to fetch ponds from API: ${response.statusCode}',
        );
        return false;
      }

      final responseData = response.data as Map<String, dynamic>;
      final data = responseData['data'] as List<dynamic>;

      AppLogger.info(
        '[InitialDataService] Fetched ${data.length} ponds from API',
      );

      await database.transaction(() async {
        for (final pondJson in data) {
          final pondData = pondJson as Map<String, dynamic>;
          try {
            // Find farm by farm_uuid (foreign key) - required for ponds
            final farm =
                await (database.select(database.fmsMtFarms)..where(
                      (f) => f.farmUuid.equals(pondData['farm_uuid'] as String),
                    ))
                    .getSingleOrNull();

            if (farm == null) {
              AppLogger.warning(
                '[InitialDataService] Farm with uuid ${pondData['farm_uuid']} not found for pond ${pondData['pond_code']}, skipping',
              );
              continue;
            }

            // Debug: Log pond data structure
            AppLogger.debug(
              '[InitialDataService] Processing pond data: ${pondData.keys.toList()}',
            );
            AppLogger.debug(
              '[InitialDataService] Pond data sample: id=${pondData['id']}, pond_code=${pondData['pond_code']}, pond_name=${pondData['pond_name']}',
            );

            // Validate required fields
            final pondId = pondData['id'];
            final pondUuid = pondData['pond_uuid'];
            final pondCode = pondData['pond_code'];
            final pondName = pondData['pond_name'];
            final farmUuid = pondData['farm_uuid'];

            if (pondId == null ||
                pondUuid == null ||
                pondCode == null ||
                pondName == null ||
                farmUuid == null) {
              AppLogger.warning(
                '[InitialDataService] Skipping pond due to missing required fields: id=$pondId, pond_uuid=$pondUuid, pond_code=$pondCode, pond_name=$pondName, farm_uuid=$farmUuid',
              );
              continue;
            }

            // Create pond companion
            final pondCompanion = FmsMtPondsCompanion(
              pondId: Value(pondId as int),
              pondUuid: Value(pondUuid as String),
              pondCode: Value(pondCode as String),
              pondName: Value(pondName as String),
              pondType: Value(pondData['pond_type'] as String?),
              pondShape: Value(pondData['pond_shape'] as String?),
              pondSize: Value(
                pondData['pond_size_sqm'] != null
                    ? (pondData['pond_size_sqm'] as num).toDouble()
                    : null,
              ),
              pondSizeUnit: const Value('sqm'),
              pwa: Value(
                pondData['pwa_sqm'] != null
                    ? (pondData['pwa_sqm'] as num).toDouble()
                    : null,
              ),
              pwaUnit: const Value('sqm'),
              depth: Value(
                pondData['depth_meter'] != null
                    ? (pondData['depth_meter'] as num).toDouble()
                    : null,
              ),
              depthUnit: const Value('meter'),
              maxDepth: Value(
                pondData['max_depth_meter'] != null
                    ? (pondData['max_depth_meter'] as num).toDouble()
                    : null,
              ),
              maxDepthUnit: const Value('meter'),
              volume: Value(
                pondData['volume_cubic_meter'] != null
                    ? (pondData['volume_cubic_meter'] as num).toDouble()
                    : null,
              ),
              volumeUnit: const Value('cubic_meter'),
              bottomType: Value(pondData['bottom_type'] as String?),
              hasAerator: Value(pondData['has_aerator'] as bool? ?? false),
              aeratorCount: Value(pondData['aerator_count'] as int?),
              aeratorTotalHp: Value(
                pondData['aerator_total_hp'] != null
                    ? (pondData['aerator_total_hp'] as num).toDouble()
                    : null,
              ),
              hasCentralDrain: Value(
                pondData['has_central_drain'] as bool? ?? false,
              ),
              waterSource: Value(pondData['water_source'] as String?),
              pondStatus: Value(
                pondData['pond_status'] as String? ?? 'Available',
              ),
              currentCycleId: Value(pondData['current_cycle_id'] as int?),
              maxBiomassKgPerSqm: Value(
                pondData['max_biomass_kg_per_sqm'] != null
                    ? (pondData['max_biomass_kg_per_sqm'] as num).toDouble()
                    : null,
              ),
              recommendedStockingDensity: Value(
                pondData['recommended_stocking_density'] != null
                    ? (pondData['recommended_stocking_density'] as num)
                          .toDouble()
                    : null,
              ),
              isActive: Value(pondData['is_active'] as bool? ?? true),
              createdDate: Value(
                pondData['created_at'] != null
                    ? DateTime.parse(pondData['created_at'] as String)
                    : DateTime.now(),
              ),
              // Set createdBy and lastUpdatedBy to a default employee (e.g., employee ID 1)
              // In a real app, this would be the actual user who created the data
              createdBy: const Value(1),
              lastUpdatedBy: const Value(1),
              farmId: Value(farm.farmId),
              farmUuid: Value(farmUuid as String),
            );

            // Upsert pond (insert or update on conflict)
            // Use insertOne with DoUpdate and target pondCode for unique constraint handling
            await database.fmsMtPonds.insertOne(
              pondCompanion,
              onConflict: DoUpdate(
                (old) => pondCompanion,
                target: [
                  database.fmsMtPonds.pondCode,
                ], // Specify pond_code as conflict target
              ),
            );

            AppLogger.debug(
              '[InitialDataService] Successfully upserted pond: $pondCode',
            );
          } catch (e, stackTrace) {
            AppLogger.error('[InitialDataService] Failed to upsert pond: $e');
            AppLogger.error(
              '[InitialDataService] Pond data that failed: $pondData',
            );
            AppLogger.error('[InitialDataService] Stack trace: $stackTrace');
            // Continue with other ponds even if one fails
          }
        }
      });

      AppLogger.info(
        '[InitialDataService] Initial pond data seeding completed: ${data.length} ponds processed',
      );
      return true;
    } catch (e) {
      AppLogger.error(
        '[InitialDataService] Failed to seed initial pond data from API: $e',
      );
      return false;
    }
  }

  /// Seed initial capacity references data from API using upsert
  /// Returns true if seeding completed successfully
  Future<bool> seedInitialCapacityReferences() async {
    AppLogger.info(
      '[InitialDataService] Starting initial capacity references data seeding from API',
    );

    try {
      // Fetch capacity references from API
      final response = await dio.get('/api/v1/capacity-references?limit=100');

      if (response.statusCode != 200) {
        AppLogger.error(
          '[InitialDataService] Failed to fetch capacity references from API: ${response.statusCode}',
        );
        return false;
      }

      final responseData = response.data as Map<String, dynamic>;
      final data = responseData['data'] as List<dynamic>;

      AppLogger.info(
        '[InitialDataService] Fetched ${data.length} capacity references from API',
      );

      await database.transaction(() async {
        for (final capacityRefJson in data) {
          final capacityRefData = capacityRefJson as Map<String, dynamic>;
          try {
            // Create capacity reference companion - mapping API response to database fields
            final capacityRefCompanion = Fms10CapacityReferencesCompanion(
              capacityRefUuid: Value(capacityRefData['id'] as String),
              commodityCode: Value(capacityRefData['commodity'] as String),
              commodityNameId: Value(
                capacityRefData['commodity'] as String,
              ), // Use commodity as name ID
              commodityNameEn: Value(
                capacityRefData['commodity'] as String,
              ), // Use commodity as name EN
              possibleTechnologyId: const Value(
                'Intensive',
              ), // Default based on culture_system
              possibleTechnologyEn: const Value(
                'Intensive',
              ), // Default based on culture_system
              categoryId: Value(capacityRefData['culture_system'] as String),
              categoryEn: Value(capacityRefData['culture_system'] as String),
              intensityLevelId: Value(
                capacityRefData['culture_system'] as String,
              ),
              intensityLevelEn: Value(
                capacityRefData['culture_system'] as String,
              ),
              maxCapacity: Value(
                (capacityRefData['max_capacity_kg_per_sqm'] as num).toDouble(),
              ),
              maxCapacityUnit: const Value('kg_per_sqm'),
              maxCapacityNotes: Value(
                capacityRefData['description'] as String?,
              ),
              scientificReferences: Value(
                capacityRefData['best_practices'] as String?,
              ),
              referenceUrls: const Value(null), // Not provided in API
              isActive: Value(capacityRefData['is_active'] as bool? ?? true),
              createdDate: Value(
                capacityRefData['created_at'] != null
                    ? DateTime.parse(capacityRefData['created_at'] as String)
                    : DateTime.now(),
              ),
              createdBy: Value(
                capacityRefData['created_by'] != null
                    ? int.tryParse(capacityRefData['created_by'].toString())
                    : null,
              ),
              lastUpdatedDate: Value(
                capacityRefData['updated_at'] != null
                    ? DateTime.parse(capacityRefData['updated_at'] as String)
                    : null,
              ),
              lastUpdatedBy: Value(
                capacityRefData['last_updated_by'] != null
                    ? int.tryParse(
                        capacityRefData['last_updated_by'].toString(),
                      )
                    : null,
              ),
              maxCapacityKgPerSqm: Value(
                capacityRefData['max_capacity_kg_per_sqm'] != null
                    ? (capacityRefData['max_capacity_kg_per_sqm'] as num)
                          .toDouble()
                    : null,
              ),
            );

            // Upsert capacity reference (insert or update on conflict)
            // Use insertOne with DoUpdate and target commodityCode for unique constraint handling
            await database.fms10CapacityReferences.insertOne(
              capacityRefCompanion,
              onConflict: DoUpdate(
                (old) => capacityRefCompanion,
                target: [
                  database.fms10CapacityReferences.commodityCode,
                ], // Specify commodity_code as conflict target
              ),
            );

            AppLogger.debug(
              '[InitialDataService] Successfully upserted capacity reference: ${capacityRefData['commodity_code']}',
            );
          } catch (e, stackTrace) {
            AppLogger.error(
              '[InitialDataService] Failed to upsert capacity reference: $e',
            );
            AppLogger.error(
              '[InitialDataService] Capacity reference data that failed: $capacityRefData',
            );
            AppLogger.error('[InitialDataService] Stack trace: $stackTrace');
            // Continue with other capacity references even if one fails
          }
        }
      });

      AppLogger.info(
        '[InitialDataService] Initial capacity references data seeding completed: ${data.length} capacity references processed',
      );
      return true;
    } catch (e) {
      AppLogger.error(
        '[InitialDataService] Failed to seed initial capacity references data from API: $e',
      );
      return false;
    }
  }

  /// Check if initial farm data has been seeded
  Future<bool> hasInitialFarms() async {
    try {
      final count = await database.fmsMtFarms.count().getSingle();
      return count > 0;
    } catch (e) {
      AppLogger.error('[InitialDataService] Failed to check initial farms: $e');
      return false;
    }
  }

  /// Map API employee role to database format
  /// API sends: "admin", "manager", "ho", "lab_technician"
  /// DB expects: "Admin", "Manager", "HO", "Lab_Technician"
  String? _mapApiEmployeeRoleToDb(String? apiRole) {
    if (apiRole == null) return null;

    switch (apiRole.toLowerCase()) {
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
        AppLogger.warning(
          '[InitialDataService] Unknown employee role from API: $apiRole',
        );
        return null; // Let database handle null values
    }
  }
}
