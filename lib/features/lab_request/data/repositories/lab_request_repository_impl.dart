import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/lab_request/data/datasources/remote/lab_request_remote_datasource.dart';
import 'package:flutter_base_app/features/lab_request/data/models/lab_request_model.dart';
import 'package:flutter_base_app/features/lab_request/domain/entities/lab_request.dart';
import 'package:flutter_base_app/features/lab_request/domain/entities/lab_request_list_data.dart';
import 'package:flutter_base_app/features/lab_request/domain/repositories/lab_request_repository.dart';

/// Repository implementation for Lab Request feature (data layer).
///
/// This implements the [LabRequestRepository] interface from the domain layer.
class LabRequestRepositoryImpl implements LabRequestRepository {
  /// Creates a new instance of [LabRequestRepositoryImpl].
  LabRequestRepositoryImpl({
    required LabRequestRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final LabRequestRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, LabRequest>> createLabRequest(
    LabRequest request,
  ) async {
    final model = request.toModel();
    final result = await _remoteDataSource.createLabRequest(model);
    return result.fold(
      Left.new,
      (createdModel) => Right(createdModel.toEntity()),
    );
  }

  @override
  Future<Either<Failure, LabRequestListData>> getLabRequestList({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final result = await _remoteDataSource.getLabRequestList(
      startDate: startDate,
      endDate: endDate,
    );
    return result.fold(
      Left.new,
      (models) => Right(
        LabRequestListData(
          requests: models.map((model) => model.toEntity()).toList(),
        ),
      ),
    );
  }
}


