import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/home/domain/entities/company_list_data.dart';
import 'package:flutter_base_app/features/home/domain/repositories/home_repository.dart';

/// Use case for getting company list data.
class GetCompanyListData {
  /// Creates a new instance of [GetCompanyListData].
  const GetCompanyListData(this.repository);

  /// Home repository
  final HomeRepository repository;

  /// Execute the use case.
  ///
  /// Returns [Either] containing [Failure] on error or [CompanyListData] on success.
  Future<Either<Failure, CompanyListData>> call() async {
    return repository.getCompanyListData();
  }
}

