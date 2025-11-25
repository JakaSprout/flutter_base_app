import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:app_mobile_afms/core/reference_data/data/datasources/remote/reference_data_remote_datasource.dart';
import 'package:app_mobile_afms/core/reference_data/domain/entities/reference_data_entities.dart';
import 'package:app_mobile_afms/core/reference_data/domain/repositories/reference_data_repository.dart';
import 'package:dartz/dartz.dart';

/// Implementation of ReferenceDataRepository.
class ReferenceDataRepositoryImpl implements ReferenceDataRepository {
  const ReferenceDataRepositoryImpl({required this.remoteDatasource});

  final ReferenceDataRemoteDatasource remoteDatasource;

  @override
  Future<Either<Failure, List<FarmSummary>>> getFarms(String employeeId) async {
    try {
      AppLogger.debug(
        '[ReferenceDataRepository] Fetching farms for employee: $employeeId',
      );

      final result = await remoteDatasource.getFarms();

      return result.fold(
        (failure) {
          AppLogger.error(
            '[ReferenceDataRepository] Failed to fetch farms: $failure',
          );
          return Left(failure);
        },
        (farms) {
          AppLogger.debug(
            '[ReferenceDataRepository] Successfully fetched ${farms.length} farms',
          );
          return Right(farms);
        },
      );
    } catch (e, st) {
      AppLogger.error(
        '[ReferenceDataRepository] Unexpected error fetching farms',
        e,
        st,
      );
      return Left(
        NetworkFailure(message: 'Unexpected error while fetching farms: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<PondSummary>>> getPonds(String employeeId) async {
    try {
      AppLogger.debug(
        '[ReferenceDataRepository] Fetching ponds for employee: $employeeId',
      );

      final result = await remoteDatasource.getPonds();

      return result.fold(
        (failure) {
          AppLogger.error(
            '[ReferenceDataRepository] Failed to fetch ponds: $failure',
          );
          return Left(failure);
        },
        (ponds) {
          AppLogger.debug(
            '[ReferenceDataRepository] Successfully fetched ${ponds.length} ponds',
          );
          return Right(ponds);
        },
      );
    } catch (e, st) {
      AppLogger.error(
        '[ReferenceDataRepository] Unexpected error fetching ponds',
        e,
        st,
      );
      return Left(
        NetworkFailure(message: 'Unexpected error while fetching ponds: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<EmployeeSummary>>> getEmployees(
    String employeeId,
  ) async {
    try {
      AppLogger.debug('[ReferenceDataRepository] Fetching employees');

      final result = await remoteDatasource.getEmployees();

      return result.fold(
        (failure) {
          AppLogger.error(
            '[ReferenceDataRepository] Failed to fetch employees: $failure',
          );
          return Left(failure);
        },
        (employees) {
          AppLogger.debug(
            '[ReferenceDataRepository] Successfully fetched ${employees.length} employees',
          );
          return Right(employees);
        },
      );
    } catch (e, st) {
      AppLogger.error(
        '[ReferenceDataRepository] Unexpected error fetching employees',
        e,
        st,
      );
      return Left(
        NetworkFailure(
          message: 'Unexpected error while fetching employees: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<CustomerSummary>>> getCustomers(
    String employeeId,
  ) async {
    try {
      AppLogger.debug('[ReferenceDataRepository] Fetching customers');

      final result = await remoteDatasource.getCustomers();

      return result.fold(
        (failure) {
          AppLogger.error(
            '[ReferenceDataRepository] Failed to fetch customers: $failure',
          );
          return Left(failure);
        },
        (customers) {
          AppLogger.debug(
            '[ReferenceDataRepository] Successfully fetched ${customers.length} customers',
          );
          return Right(customers);
        },
      );
    } catch (e, st) {
      AppLogger.error(
        '[ReferenceDataRepository] Unexpected error fetching customers',
        e,
        st,
      );
      return Left(
        NetworkFailure(
          message: 'Unexpected error while fetching customers: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<LabTestTypeEntity>>> getLabTestTypes(
    String employeeId,
  ) async {
    try {
      AppLogger.debug('[ReferenceDataRepository] Fetching lab test types');

      final result = await remoteDatasource.getLabTestTypes();

      return result.fold(
        (failure) {
          AppLogger.error(
            '[ReferenceDataRepository] Failed to fetch lab test types: $failure',
          );
          return Left(failure);
        },
        (labTestTypes) {
          AppLogger.debug(
            '[ReferenceDataRepository] Successfully fetched ${labTestTypes.length} lab test types',
          );
          return Right(labTestTypes);
        },
      );
    } catch (e, st) {
      AppLogger.error(
        '[ReferenceDataRepository] Unexpected error fetching lab test types',
        e,
        st,
      );
      return Left(
        NetworkFailure(
          message: 'Unexpected error while fetching lab test types: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<CapacityReference>>> getCapacityReferences(String employeeId) async {
    try {
      AppLogger.debug('[ReferenceDataRepository] Fetching capacity references');

      final result = await remoteDatasource.getCapacityReferences();

      return result.fold(
        (failure) {
          AppLogger.error(
            '[ReferenceDataRepository] Failed to fetch capacity references: $failure',
          );
          return Left(failure);
        },
        (capacityReferences) {
          AppLogger.debug(
            '[ReferenceDataRepository] Successfully fetched ${capacityReferences.length} capacity references',
          );
          return Right(capacityReferences);
        },
      );
    } catch (e, st) {
      AppLogger.error(
        '[ReferenceDataRepository] Unexpected error fetching capacity references',
        e,
        st,
      );
      return Left(
        NetworkFailure(
          message: 'Unexpected error while fetching capacity references: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<UnitEntity>>> getUnits(String employeeId) async {
    try {
      AppLogger.debug('[ReferenceDataRepository] Fetching units');

      final result = await remoteDatasource.getUnits();

      return result.fold(
        (failure) {
          AppLogger.error(
            '[ReferenceDataRepository] Failed to fetch units: $failure',
          );
          return Left(failure);
        },
        (units) {
          AppLogger.debug(
            '[ReferenceDataRepository] Successfully fetched ${units.length} units',
          );
          return Right(units);
        },
      );
    } catch (e, st) {
      AppLogger.error(
        '[ReferenceDataRepository] Unexpected error fetching units',
        e,
        st,
      );
      return Left(
        NetworkFailure(
          message: 'Unexpected error while fetching units: $e',
        ),
      );
    }
  }
}
