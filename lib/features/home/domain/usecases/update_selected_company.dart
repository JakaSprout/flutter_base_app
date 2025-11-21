import 'package:dartz/dartz.dart';
import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/home/domain/entities/company_list_data.dart';
import 'package:app_mobile_afms/features/home/domain/repositories/home_repository.dart';

/// Use case for updating selected company.
class UpdateSelectedCompany {
  /// Creates a new instance of [UpdateSelectedCompany].
  const UpdateSelectedCompany(this.repository);

  /// Home repository
  final HomeRepository repository;

  /// Execute the use case.
  ///
  /// [company] The company name to select.
  /// Returns [Either] containing [Failure] on error or [CompanyListData] on success.
  Future<Either<Failure, CompanyListData>> call(String company) async {
    return repository.updateSelectedCompany(company);
  }
}
