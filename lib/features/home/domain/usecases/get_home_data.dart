import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/home/domain/entities/home_data.dart';
import 'package:flutter_base_app/features/home/domain/repositories/home_repository.dart';

/// Use case for getting home screen data.
class GetHomeData {
  /// Creates a new instance of [GetHomeData].
  const GetHomeData(this.repository);

  /// Home repository
  final HomeRepository repository;

  /// Execute the use case.
  ///
  /// Returns [Either] containing [Failure] on error or [HomeData] on success.
  Future<Either<Failure, HomeData>> call() async {
    return repository.getHomeData();
  }
}
