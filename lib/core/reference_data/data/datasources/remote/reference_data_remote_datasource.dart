import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/core/reference_data/domain/entities/reference_data_entities.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

/// Remote data source for fetching reference data from backend API.
abstract class ReferenceDataRemoteDatasource {
  /// Fetch all farms for the current user.
  Future<Either<Failure, List<FarmSummary>>> getFarms();

  /// Fetch all ponds for the current user.
  Future<Either<Failure, List<PondSummary>>> getPonds();

  /// Fetch all employees (for admin users).
  Future<Either<Failure, List<EmployeeSummary>>> getEmployees();

  /// Fetch all customers.
  Future<Either<Failure, List<CustomerSummary>>> getCustomers();

  /// Fetch all lab test types.
  Future<Either<Failure, List<LabTestTypeEntity>>> getLabTestTypes();

  /// Fetch all capacity references.
  Future<Either<Failure, List<CapacityReference>>> getCapacityReferences();

  /// Fetch all units.
  Future<Either<Failure, List<UnitEntity>>> getUnits();

  /// Fetch all lab parameters.
  Future<Either<Failure, List<LabParameterEntity>>> getLabParameters();

  /// Fetch all lab types.
  Future<Either<Failure, List<LabTypeEntity>>> getLabTypes();

  /// Fetch all sample lab types.
  Future<Either<Failure, List<SampleLabTypeEntity>>> getSampleLabTypes();
}

/// Implementation of ReferenceDataRemoteDatasource using Dio.
class ReferenceDataRemoteDatasourceImpl
    implements ReferenceDataRemoteDatasource {
  const ReferenceDataRemoteDatasourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<Either<Failure, List<FarmSummary>>> getFarms() async {
    try {
      final response = await dio.get('/api/v1/farms?limit=100');

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final data = responseData['data'] as List<dynamic>;
        final farms = data
            .map((json) => FarmSummary.fromJson(json as Map<String, dynamic>))
            .toList();
        return Right(farms);
      } else {
        return Left(
          NetworkFailure(
            message: 'Failed to fetch farms: ${response.statusMessage}',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        NetworkFailure(
          message: 'Network error while fetching farms: ${e.message}',
        ),
      );
    } catch (e) {
      return Left(
        NetworkFailure(message: 'Unexpected error while fetching farms: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<PondSummary>>> getPonds() async {
    try {
      final response = await dio.get('/api/v1/ponds?limit=100');

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final data = responseData['data'] as List<dynamic>;
        final ponds = data
            .map((json) => PondSummary.fromJson(json as Map<String, dynamic>))
            .toList();
        return Right(ponds);
      } else {
        return Left(
          NetworkFailure(
            message: 'Failed to fetch ponds: ${response.statusMessage}',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        NetworkFailure(
          message: 'Network error while fetching ponds: ${e.message}',
        ),
      );
    } catch (e) {
      return Left(
        NetworkFailure(message: 'Unexpected error while fetching ponds: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<EmployeeSummary>>> getEmployees() async {
    try {
      final response = await dio.get('/api/v1/employees?limit=100');

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final data = responseData['data'] as List<dynamic>;
        final employees = data
            .map(
              (json) => EmployeeSummary.fromJson(json as Map<String, dynamic>),
            )
            .toList();
        return Right(employees);
      } else {
        return Left(
          NetworkFailure(
            message: 'Failed to fetch employees: ${response.statusMessage}',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        NetworkFailure(
          message: 'Network error while fetching employees: ${e.message}',
        ),
      );
    } catch (e) {
      return Left(
        NetworkFailure(
          message: 'Unexpected error while fetching employees: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<CustomerSummary>>> getCustomers() async {
    try {
      final response = await dio.get('/api/v1/customers?limit=100');

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final data = responseData['data'] as List<dynamic>;
        final customers = data
            .map(
              (json) => CustomerSummary.fromJson(json as Map<String, dynamic>),
            )
            .toList();
        return Right(customers);
      } else {
        return Left(
          NetworkFailure(
            message: 'Failed to fetch customers: ${response.statusMessage}',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        NetworkFailure(
          message: 'Network error while fetching customers: ${e.message}',
        ),
      );
    } catch (e) {
      return Left(
        NetworkFailure(
          message: 'Unexpected error while fetching customers: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<LabTestTypeEntity>>> getLabTestTypes() async {
    try {
      final response = await dio.get(
        '/api/v1/request-lab/lab-test-types?limit=100',
      );

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        // Handle both response formats: with/without success wrapper
        final data =
            responseData.containsKey('data') && responseData['data'] is List
            ? responseData['data'] as List<dynamic>
            : responseData['data'] != null && responseData['data'] is List
            ? responseData['data'] as List<dynamic>
            : responseData as List<dynamic>;

        final labTestTypes = data.map((item) {
          if (item is Map<String, dynamic>) {
            // Full object format (as per documentation)
            return LabTestTypeEntity.fromJson(item);
          } else if (item is String) {
            // Simple string format (current API implementation)
            return LabTestTypeEntity(
              code: item,
              name: _getTestTypeName(item),
              description: _getTestTypeDescription(item),
              category: _getTestTypeCategory(item),
              turnaroundDays: _getTestTypeTurnaroundDays(item),
            );
          } else {
            throw FormatException('Unexpected lab test type format: $item');
          }
        }).toList();

        return Right(labTestTypes);
      } else {
        return Left(
          NetworkFailure(
            message:
                'Failed to fetch lab test types: ${response.statusMessage}',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        NetworkFailure(
          message: 'Network error while fetching lab test types: ${e.message}',
        ),
      );
    } catch (e) {
      return Left(
        NetworkFailure(
          message: 'Unexpected error while fetching lab test types: $e',
        ),
      );
    }
  }

  // Helper methods for mapping test type codes to full information
  String _getTestTypeName(String code) {
    const nameMap = {
      'pcr_konvensional': 'PCR Conventional',
      'pcr_pockit': 'PCR Pockit',
      'pcr_realtime': 'PCR Real-time',
      'water_quality': 'Water Quality Analysis',
    };
    return nameMap[code] ?? code; // Fallback to code if not found
  }

  String _getTestTypeDescription(String code) {
    const descriptionMap = {
      'pcr_konvensional': 'Conventional PCR testing for pathogen detection',
      'pcr_pockit': 'Rapid PCR testing using portable Pockit device',
      'pcr_realtime': 'Quantitative real-time PCR analysis',
      'water_quality': 'Comprehensive water quality parameter testing',
    };
    return descriptionMap[code] ?? 'Laboratory test for aquaculture samples';
  }

  String _getTestTypeCategory(String code) {
    if (code.startsWith('pcr_')) {
      return 'molecular';
    } else if (code == 'water_quality') {
      return 'chemical';
    }
    return 'molecular'; // Default category
  }

  int _getTestTypeTurnaroundDays(String code) {
    const turnaroundMap = {
      'pcr_konvensional': 3,
      'pcr_pockit': 1,
      'pcr_realtime': 2,
      'water_quality': 2,
    };
    return turnaroundMap[code] ?? 2; // Default 2 days
  }

  @override
  Future<Either<Failure, List<CapacityReference>>>
  getCapacityReferences() async {
    try {
      final response = await dio.get('/api/v1/capacity-references?limit=100');

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final data = responseData['data'] as List<dynamic>;
        final capacityReferences = data
            .map(
              (json) =>
                  CapacityReference.fromJson(json as Map<String, dynamic>),
            )
            .toList();
        return Right(capacityReferences);
      } else {
        return Left(
          NetworkFailure(
            message:
                'Failed to fetch capacity references: ${response.statusMessage}',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        NetworkFailure(
          message:
              'Network error while fetching capacity references: ${e.message}',
        ),
      );
    } catch (e) {
      return Left(
        NetworkFailure(
          message: 'Unexpected error while fetching capacity references: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<UnitEntity>>> getUnits() async {
    try {
      final response = await dio.get('/api/v1/units?limit=100');

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final data = responseData['data'] as List<dynamic>;
        final units = data
            .map((json) => UnitEntity.fromJson(json as Map<String, dynamic>))
            .toList();
        return Right(units);
      } else {
        return Left(
          NetworkFailure(
            message: 'Failed to fetch units: ${response.statusMessage}',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        NetworkFailure(
          message: 'Network error while fetching units: ${e.message}',
        ),
      );
    } catch (e) {
      return Left(
        NetworkFailure(message: 'Unexpected error while fetching units: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<LabParameterEntity>>> getLabParameters() async {
    try {
      final response = await dio.get('/api/v1/lab-parameters?limit=100');

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final data = responseData['data'] as List<dynamic>;
        final labParameters = data
            .map(
              (json) =>
                  LabParameterEntity.fromJson(json as Map<String, dynamic>),
            )
            .toList();
        return Right(labParameters);
      } else {
        return Left(
          NetworkFailure(
            message:
                'Failed to fetch lab parameters: ${response.statusMessage}',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        NetworkFailure(
          message: 'Network error while fetching lab parameters: ${e.message}',
        ),
      );
    } catch (e) {
      return Left(
        NetworkFailure(
          message: 'Unexpected error while fetching lab parameters: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<LabTypeEntity>>> getLabTypes() async {
    try {
      final response = await dio.get('/api/v1/lab-types?limit=100');

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final data = responseData['data'] as List<dynamic>;
        final labTypes = data
            .map((json) => LabTypeEntity.fromJson(json as Map<String, dynamic>))
            .toList();
        return Right(labTypes);
      } else {
        return Left(
          NetworkFailure(
            message: 'Failed to fetch lab types: ${response.statusMessage}',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        NetworkFailure(
          message: 'Network error while fetching lab types: ${e.message}',
        ),
      );
    } catch (e) {
      return Left(
        NetworkFailure(
          message: 'Unexpected error while fetching lab types: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<SampleLabTypeEntity>>> getSampleLabTypes() async {
    try {
      final response = await dio.get('/api/v1/sample-lab-types?limit=100');

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final data = responseData['data'] as List<dynamic>;
        final sampleLabTypes = data
            .map(
              (json) =>
                  SampleLabTypeEntity.fromJson(json as Map<String, dynamic>),
            )
            .toList();
        return Right(sampleLabTypes);
      } else {
        return Left(
          NetworkFailure(
            message:
                'Failed to fetch sample lab types: ${response.statusMessage}',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        NetworkFailure(
          message:
              'Network error while fetching sample lab types: ${e.message}',
        ),
      );
    } catch (e) {
      return Left(
        NetworkFailure(
          message: 'Unexpected error while fetching sample lab types: $e',
        ),
      );
    }
  }
}
