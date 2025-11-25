import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/home/data/datasources/remote/home_remote_datasource.dart';
import 'package:app_mobile_afms/features/home/data/models/banner_model.dart';
import 'package:app_mobile_afms/features/home/data/models/input_data_item_model.dart';
import 'package:app_mobile_afms/features/home/data/models/mappers/home_mapper.dart';
import 'package:app_mobile_afms/features/home/data/models/mappers/pond_mapper.dart';
import 'package:app_mobile_afms/features/home/domain/entities/banner_entity.dart';
import 'package:app_mobile_afms/features/home/domain/entities/banner_list_data.dart';
import 'package:app_mobile_afms/features/home/domain/entities/dashboard_summary_data.dart';
import 'package:app_mobile_afms/features/home/domain/entities/farm_list_data.dart';
import 'package:app_mobile_afms/features/home/domain/entities/header_data.dart';
import 'package:app_mobile_afms/features/home/domain/entities/home_data.dart';
import 'package:app_mobile_afms/features/home/domain/entities/input_data_item_entity.dart';
import 'package:app_mobile_afms/features/home/domain/entities/input_data_list_data.dart';
import 'package:app_mobile_afms/features/home/domain/entities/pond_entity.dart';
import 'package:app_mobile_afms/features/home/domain/entities/pond_list_data.dart';
import 'package:app_mobile_afms/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

/// Repository implementation for Home feature (data layer).
///
/// This implements the [HomeRepository] interface from the domain layer.
class HomeRepositoryImpl implements HomeRepository {
  /// Creates a new instance of [HomeRepositoryImpl].
  HomeRepositoryImpl({required HomeRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final HomeRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, HomeData>> getHomeData() async {
    final result = await _remoteDataSource.getHomeData();
    return result.fold(Left.new, (model) => Right(HomeMapper.toEntity(model)));
  }

  @override
  Future<Either<Failure, DashboardSummaryData>>
  getDashboardSummaryData() async {
    final result = await _remoteDataSource.getDashboardSummaryData();
    return result.fold(
      Left.new,
      (data) => Right(
        DashboardSummaryData(
          activePonds: data['activePonds'] as int,
          estimasiBiomassa: data['estimasiBiomassa'] as String,
          totalPakan: data['totalPakan'] as String,
          biayaPakan: data['biayaPakan'] as String,
          estimasiSR: data['estimasiSR'] as String,
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, PondListData>> getPondListData() async {
    final result = await _remoteDataSource.getPondListData();
    return result.fold(
      Left.new,
      (models) => Right(
        PondListData(
          ponds: models.map<PondEntity>(PondMapper.toEntity).toList(),
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, FarmListData>> getFarmListData() async {
    final result = await _remoteDataSource.getFarmListData();
    return result.fold(
      Left.new,
      (data) => Right(
        FarmListData(
          farms: (data['farms'] as List).cast<String>(),
          selectedFarm: data['selectedFarm'] as String?,
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, HeaderData>> getHeaderData() async {
    final result = await _remoteDataSource.getHeaderData();
    return result.fold(
      Left.new,
      (data) => Right(
        HeaderData(notificationCount: data['notificationCount'] as int),
      ),
    );
  }

  @override
  Future<Either<Failure, BannerListData>> getBannerListData() async {
    final result = await _remoteDataSource.getBannerListData();
    return result.fold(
      Left.new,
      (models) => Right(
        BannerListData(
          banners: models
              .map<BannerEntity>((model) => model.toEntity())
              .toList(),
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, InputDataListData>> getInputDataListData() async {
    final result = await _remoteDataSource.getInputDataListData();
    return result.fold(Left.new, (models) {
      // Sort by order and convert to entities
      final sortedModels = models.toList()
        ..sort((a, b) => a.order.compareTo(b.order));
      return Right(
        InputDataListData(
          items: sortedModels
              .map<InputDataItemEntity>((model) => model.toEntity())
              .toList(),
        ),
      );
    });
  }

  @override
  Future<Either<Failure, FarmListData>> updateSelectedFarm(
    String farm,
  ) async {
    // Get current farm list
    final currentDataResult = await getFarmListData();
    return currentDataResult.fold(
      Left.new,
      (currentData) => Right(
        FarmListData(
          farms: currentData.farms,
          selectedFarm: farm,
        ),
      ),
    );
  }

}
