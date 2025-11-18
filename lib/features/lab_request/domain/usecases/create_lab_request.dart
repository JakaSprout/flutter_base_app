import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/lab_request/domain/entities/lab_request.dart';
import 'package:flutter_base_app/features/lab_request/domain/repositories/lab_request_repository.dart';

/// Use case for creating a lab request.
class CreateLabRequest {
  /// Creates a new instance of [CreateLabRequest].
  CreateLabRequest(this._repository);

  final LabRequestRepository _repository;

  /// Execute the use case.
  ///
  /// Returns [Either] containing [Failure] on error or [LabRequest] on success.
  Future<Either<Failure, LabRequest>> call(LabRequest request) {
    return _repository.createLabRequest(request);
  }
}
