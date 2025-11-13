import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/home/domain/entities/header_data.dart';
import 'package:flutter_base_app/features/home/domain/repositories/home_repository.dart';

/// Use case for getting header data.
class GetHeaderData {
  /// Creates a new instance of [GetHeaderData].
  const GetHeaderData(this.repository);

  /// Home repository
  final HomeRepository repository;

  /// Execute the use case.
  ///
  /// Returns [Either] containing [Failure] on error or [HeaderData] on success.
  Future<Either<Failure, HeaderData>> call() async {
    return repository.getHeaderData();
  }
}

