import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/home/domain/entities/farm_list_data.dart';
import 'package:app_mobile_afms/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

/// Use case for updating selected farm.
class UpdateSelectedFarm {
  /// Creates a new instance of [UpdateSelectedFarm].
  const UpdateSelectedFarm(this.repository);

  /// Home repository
  final HomeRepository repository;

  /// Execute the use case.
  ///
  /// [farm] The farm name to select.
  /// Returns [Either] containing [Failure] on error or [FarmListData] on success.
  Future<Either<Failure, FarmListData>> call(String farm) async {
    // This is implemented in the provider using real API data
    // The actual implementation is in home_provider.dart
    throw UnimplementedError('Use provider implementation instead');
  }
}

