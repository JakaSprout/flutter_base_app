import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/home/domain/entities/banner_list_data.dart';
import 'package:app_mobile_afms/features/home/domain/entities/farm_list_data.dart';
import 'package:app_mobile_afms/features/home/domain/entities/dashboard_summary_data.dart';
import 'package:app_mobile_afms/features/home/domain/entities/header_data.dart';
import 'package:app_mobile_afms/features/home/domain/entities/home_data.dart';
import 'package:app_mobile_afms/features/home/domain/entities/input_data_list_data.dart';
import 'package:app_mobile_afms/features/home/domain/entities/pond_list_data.dart';
import 'package:dartz/dartz.dart';

/// Repository interface for Home feature (domain layer).
///
/// This defines the contract for home data operations.
/// Implementation is in the data layer.
abstract class HomeRepository {
  /// Get home screen data (all sections).
  ///
  /// Returns [Either] containing [Failure] on error or [HomeData] on success.
  Future<Either<Failure, HomeData>> getHomeData();

  /// Get dashboard summary data.
  ///
  /// Returns [Either] containing [Failure] on error or [DashboardSummaryData] on success.
  Future<Either<Failure, DashboardSummaryData>> getDashboardSummaryData();

  /// Get pond list data.
  ///
  /// Returns [Either] containing [Failure] on error or [PondListData] on success.
  Future<Either<Failure, PondListData>> getPondListData();

  /// Get farm list data.
  ///
  /// Returns [Either] containing [Failure] on error or [FarmListData] on success.
  Future<Either<Failure, FarmListData>> getFarmListData();

  /// Get header data (notification count, etc).
  ///
  /// Returns [Either] containing [Failure] on error or [HeaderData] on success.
  Future<Either<Failure, HeaderData>> getHeaderData();

  /// Get banner list data.
  ///
  /// Returns [Either] containing [Failure] on error or [BannerListData] on success.
  Future<Either<Failure, BannerListData>> getBannerListData();

  /// Get input data list (with custom order).
  ///
  /// Returns [Either] containing [Failure] on error or [InputDataListData] on success.
  Future<Either<Failure, InputDataListData>> getInputDataListData();

  /// Update selected farm.
  ///
  /// Returns [Either] containing [Failure] on error or [FarmListData] on success.
  Future<Either<Failure, FarmListData>> updateSelectedFarm(
    String farm,
  );

}
