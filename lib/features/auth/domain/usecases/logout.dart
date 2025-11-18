import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/auth/domain/repositories/auth_repository.dart';

/// Use case for logging out.
class Logout {
  /// Creates a new instance of [Logout].
  Logout(this._repository);

  final AuthRepository _repository;

  /// Execute logout.
  ///
  /// Returns [Either] containing [Failure] on error or void on success.
  Future<Either<Failure, void>> call() async {
    return await _repository.logout();
  }
}
