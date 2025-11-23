import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/core/reference_data/domain/repositories/reference_data_repository.dart';
import 'package:app_mobile_afms/features/home/domain/entities/company_list_data.dart';
import 'package:dartz/dartz.dart';

/// Use case for getting company list data from farms reference data.
class GetCompanyListData {
  /// Creates a new instance of [GetCompanyListData].
  const GetCompanyListData({
    required this.referenceDataRepository,
    required this.employeeId,
  });

  /// Reference data repository
  final ReferenceDataRepository referenceDataRepository;

  /// Employee ID to scope the farms query
  final String employeeId;

  /// Execute the use case.
  ///
  /// Returns [Either] containing [Failure] on error or [CompanyListData] on success.
  Future<Either<Failure, CompanyListData>> call() async {
    try {
      final farms = await referenceDataRepository.getFarms(employeeId);

      // Map farms to company names (farm names)
      final activeFarms = farms.where((farm) => farm.isActive).toList()
        ..sort((a, b) => a.name.compareTo(b.name)); // Sort alphabetically

      final companies = activeFarms.map((farm) => farm.name).toList();

      // If no farms found, return empty list with no selected company
      if (companies.isEmpty) {
        return Right(
          const CompanyListData(
            companies: [],
            selectedCompany: null,
            selectedFarmId: null,
          ),
        );
      }

      // Use first farm as default selected company
      final firstFarm = activeFarms.first;
      return Right(
        CompanyListData(
          companies: companies,
          selectedCompany: firstFarm.name,
          selectedFarmId: firstFarm.id,
        ),
      );
    } catch (e) {
      return Left(
        NetworkFailure.serverError('Failed to load company list: $e'),
      );
    }
  }
}

