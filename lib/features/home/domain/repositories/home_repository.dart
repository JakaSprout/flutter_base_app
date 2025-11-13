import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/home/domain/entities/banner_list_data.dart';
import 'package:flutter_base_app/features/home/domain/entities/company_list_data.dart';
import 'package:flutter_base_app/features/home/domain/entities/dashboard_summary_data.dart';
import 'package:flutter_base_app/features/home/domain/entities/header_data.dart';
import 'package:flutter_base_app/features/home/domain/entities/home_data.dart';
import 'package:flutter_base_app/features/home/domain/entities/input_data_list_data.dart';
import 'package:flutter_base_app/features/home/domain/entities/pond_list_data.dart';

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

  /// Get company list data.
  ///
  /// Returns [Either] containing [Failure] on error or [CompanyListData] on success.
  Future<Either<Failure, CompanyListData>> getCompanyListData();

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

  /// Update selected company.
  ///
  /// Returns [Either] containing [Failure] on error or [CompanyListData] on success.
  Future<Either<Failure, CompanyListData>> updateSelectedCompany(
    String company,
  );

  /// Update selected company (legacy method for backward compatibility).
  ///
  /// Returns [Either] containing [Failure] on error or [HomeData] on success.
  @Deprecated('Use updateSelectedCompany instead')
  Future<Either<Failure, HomeData>> updateSelectedCompanyLegacy(String company);
}
