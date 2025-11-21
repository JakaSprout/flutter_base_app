import 'package:dartz/dartz.dart';
import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/home/domain/entities/banner_list_data.dart';
import 'package:app_mobile_afms/features/home/domain/repositories/home_repository.dart';

/// Use case for getting banner list data.
class GetBannerListData {
  /// Creates a new instance of [GetBannerListData].
  const GetBannerListData(this.repository);

  /// Home repository
  final HomeRepository repository;

  /// Execute the use case.
  ///
  /// Returns [Either] containing [Failure] on error or [BannerListData] on success.
  Future<Either<Failure, BannerListData>> call() async {
    return repository.getBannerListData();
  }
}

