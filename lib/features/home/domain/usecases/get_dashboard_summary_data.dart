import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/home/domain/entities/dashboard_summary_data.dart';
import 'package:flutter_base_app/features/home/domain/repositories/home_repository.dart';

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

