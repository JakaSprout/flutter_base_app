import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/home/domain/entities/dashboard_summary_data.dart';
import 'package:app_mobile_afms/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

/// Use case for getting dashboard summary data.
class GetDashboardSummaryData {
  /// Creates a new instance of [GetDashboardSummaryData].
  const GetDashboardSummaryData(this.repository);

  /// Home repository
  final HomeRepository repository;

  /// Execute the use case.
  ///
  /// Returns [Either] containing [Failure] on error or [DashboardSummaryData] on success.
  Future<Either<Failure, DashboardSummaryData>> call() async {
    return repository.getDashboardSummaryData();
  }
}
