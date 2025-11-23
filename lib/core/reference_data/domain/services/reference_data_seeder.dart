import 'package:app_mobile_afms/core/reference_data/domain/reference_data_type.dart';
import 'package:app_mobile_afms/core/reference_data/domain/repositories/reference_data_repository.dart';
import 'package:app_mobile_afms/core/reference_data/domain/value_objects/reference_data_seed_result.dart';

/// Facade used by presentation layer to trigger seeding logic.
class ReferenceDataSeeder {
  const ReferenceDataSeeder(this._repository);

  final ReferenceDataRepository _repository;

  Future<ReferenceDataSeedSummary> seedAll({
    required String userId,
    bool force = false,
  }) {
    return _repository.seedAll(userId: userId, force: force);
  }

  Future<ReferenceDataSeedResult> seedType(
    ReferenceDataType type, {
    required String userId,
    bool force = false,
  }) {
    return _repository.refreshType(type, userId: userId, force: force);
  }
}

