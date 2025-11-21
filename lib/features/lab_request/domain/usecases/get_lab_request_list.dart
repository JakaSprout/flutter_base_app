import 'package:dartz/dartz.dart';
import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/lab_request/domain/entities/lab_request_list_data.dart';
import 'package:app_mobile_afms/features/lab_request/domain/repositories/lab_request_repository.dart';

/// Use case for getting list of lab requests.
class GetLabRequestList {
  /// Creates a new instance of [GetLabRequestList].
  GetLabRequestList(this._repository);

  final LabRequestRepository _repository;

  /// Execute the use case.
  ///
  /// Returns [Either] containing [Failure] on error or
  /// [LabRequestListData] on success.
  Future<Either<Failure, LabRequestListData>> call({
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return _repository.getLabRequestList(
      startDate: startDate,
      endDate: endDate,
    );
  }
}
