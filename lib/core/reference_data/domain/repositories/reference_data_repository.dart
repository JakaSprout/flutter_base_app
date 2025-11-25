import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/core/reference_data/domain/entities/reference_data_entities.dart';
import 'package:dartz/dartz.dart';

/// Repository interface for reference data operations.
///
/// Provides access to master data such as farms, ponds, employees, etc.
/// All methods return Either<Failure, Data> for error handling.
abstract class ReferenceDataRepository {
  /// Gets all farms for the given employee.
  ///
  /// [employeeId] The employee ID to filter farms for.
  /// Returns [Either] containing [Failure] on error or [List<FarmSummary>] on success.
  Future<Either<Failure, List<FarmSummary>>> getFarms(String employeeId);

  /// Gets all ponds for the given employee.
  ///
  /// [employeeId] The employee ID to filter ponds for.
  /// Returns [Either] containing [Failure] on error or [List<PondSummary>] on success.
  Future<Either<Failure, List<PondSummary>>> getPonds(String employeeId);

  /// Gets all employees.
  ///
  /// [employeeId] The employee ID (currently unused, kept for consistency).
  /// Returns [Either] containing [Failure] on error or [List<EmployeeSummary>] on success.
  Future<Either<Failure, List<EmployeeSummary>>> getEmployees(String employeeId);

  /// Gets all customers.
  ///
  /// [employeeId] The employee ID (currently unused, kept for consistency).
  /// Returns [Either] containing [Failure] on error or [List<CustomerSummary>] on success.
  Future<Either<Failure, List<CustomerSummary>>> getCustomers(String employeeId);

  /// Gets all lab test types.
  ///
  /// [employeeId] The employee ID (currently unused, kept for consistency).
  /// Returns [Either] containing [Failure] on error or [List<LabTestTypeEntity>] on success.
  Future<Either<Failure, List<LabTestTypeEntity>>> getLabTestTypes(String employeeId);

  /// Gets all capacity references.
  ///
  /// [employeeId] The employee ID (currently unused, kept for consistency).
  /// Returns [Either] containing [Failure] on error or [List<CapacityReference>] on success.
  Future<Either<Failure, List<CapacityReference>>> getCapacityReferences(String employeeId);

  /// Gets all units.
  ///
  /// [employeeId] The employee ID (currently unused, kept for consistency).
  /// Returns [Either] containing [Failure] on error or [List<UnitEntity>] on success.
  Future<Either<Failure, List<UnitEntity>>> getUnits(String employeeId);

  /// Gets all lab parameters.
  ///
  /// [employeeId] The employee ID (currently unused, kept for consistency).
  /// Returns [Either] containing [Failure] on error or [List<LabParameterEntity>] on success.
  Future<Either<Failure, List<LabParameterEntity>>> getLabParameters(String employeeId);

  /// Gets all lab types.
  ///
  /// [employeeId] The employee ID (currently unused, kept for consistency).
  /// Returns [Either] containing [Failure] on error or [List<LabTypeEntity>] on success.
  Future<Either<Failure, List<LabTypeEntity>>> getLabTypes(String employeeId);

  /// Gets all sample lab types.
  ///
  /// [employeeId] The employee ID (currently unused, kept for consistency).
  /// Returns [Either] containing [Failure] on error or [List<SampleLabTypeEntity>] on success.
  Future<Either<Failure, List<SampleLabTypeEntity>>> getSampleLabTypes(String employeeId);
}

