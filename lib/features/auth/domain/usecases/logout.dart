import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

/// Use case for logging out.
class Logout {
  /// Creates a new instance of [Logout].
  Logout(this._repository);

  final AuthRepository _repository;

  /// Execute logout.
  ///
  /// Returns [Either] containing [Failure] on error or void on success.
  Future<Either<Failure, void>> call() async {
    return _repository.logout();
  }
}
