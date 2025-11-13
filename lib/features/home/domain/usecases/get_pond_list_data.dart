import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/home/domain/entities/pond_list_data.dart';
import 'package:flutter_base_app/features/home/domain/repositories/home_repository.dart';

/// Use case for getting pond list data.
class GetPondListData {
  /// Creates a new instance of [GetPondListData].
  const GetPondListData(this.repository);

  /// Home repository
  final HomeRepository repository;

  /// Execute the use case.
  ///
  /// Returns [Either] containing [Failure] on error or [PondListData] on success.
  Future<Either<Failure, PondListData>> call() async {
    return repository.getPondListData();
  }
}

