import 'package:app_mobile_afms/core/reference_data/domain/entities/reference_data_entities.dart';
import 'package:app_mobile_afms/core/reference_data/domain/reference_data_type.dart';
import 'package:app_mobile_afms/core/reference_data/domain/value_objects/reference_data_seed_result.dart';

/// Contract for reference data repository.
abstract class ReferenceDataRepository {
  /// Seed all reference data types.
  Future<ReferenceDataSeedSummary> seedAll({
    required String userId,
    bool force = false,
  });

  /// Refresh a specific data type (optionally bypass TTL).
  Future<ReferenceDataSeedResult> refreshType(
    ReferenceDataType type, {
    required String userId,
    bool force = false,
  });

  /// Returns cached Lab Test Types for the user.
  Future<List<LabTestTypeEntity>> getLabTestTypes(String userId);

  Future<List<EmployeeSummary>> getEmployees(String userId);
  Future<List<CustomerSummary>> getCustomers(String userId);
  Future<List<FarmSummary>> getFarms(String userId);
  Future<List<PondSummary>> getPonds(String userId);

  /// Removes cached + persisted data for the specified user.
  Future<void> purgeUserData(String userId);
}
