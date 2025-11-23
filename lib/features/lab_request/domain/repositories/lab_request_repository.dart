import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/lab_request/domain/entities/lab_request.dart';
import 'package:app_mobile_afms/features/lab_request/domain/entities/lab_request_list_data.dart';
import 'package:dartz/dartz.dart';

/// Repository interface for Lab Request feature (domain layer).
///
/// This defines the contract for lab request operations.
/// Implementation is in the data layer.
abstract class LabRequestRepository {
  /// Create a new lab request.
  ///
  /// Returns [Either] containing [Failure] on error or [LabRequest] on success.
  Future<Either<Failure, LabRequest>> createLabRequest(LabRequest request);

  /// Get list of submitted lab requests.
  ///
  /// Returns [Either] containing [Failure] on error or
  /// [LabRequestListData] on success.
  Future<Either<Failure, LabRequestListData>> getLabRequestList({
    DateTime? startDate,
    DateTime? endDate,
  });
}
