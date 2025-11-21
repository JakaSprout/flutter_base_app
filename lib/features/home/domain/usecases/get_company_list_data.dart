import 'package:dartz/dartz.dart';
import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/home/domain/entities/company_list_data.dart';
import 'package:app_mobile_afms/features/home/domain/repositories/home_repository.dart';

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

