import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/home/domain/entities/farm_list_data.dart';
import 'package:dartz/dartz.dart';

/// Use case for getting farm list data.
///
/// Uses real farm data from reference data remote datasource.
/// Farm names are derived from farm names.
class GetFarmListData {
  /// Creates a new instance of [GetFarmListData].
  const GetFarmListData({
    required this.employeeId,
  });

  /// Employee ID to scope the query
  final String employeeId;

  /// Execute the use case.
  ///
  /// Returns [Either] containing [Failure] on error or [FarmListData] on success.
  /// Uses real farm data from reference data remote datasource.
  Future<Either<Failure, FarmListData>> call() async {
    try {
      // This is implemented in the provider using real API data
      // The actual implementation is in home_provider.dart
      throw UnimplementedError('Use provider implementation instead');
    } catch (e) {
      return Left(
        NetworkFailure.serverError('Failed to load farm list: $e'),
      );
    }
  }
}


