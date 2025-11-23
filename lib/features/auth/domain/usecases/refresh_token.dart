import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/auth/domain/entities/login_response.dart';
import 'package:app_mobile_afms/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

/// Use case for refreshing access token.
class RefreshToken {
  /// Creates a new instance of [RefreshToken].
  RefreshToken(this._repository);

  final AuthRepository _repository;

  /// Execute token refresh.
  ///
  /// Returns [Either] containing [Failure] on error or [LoginResponse] on success.
  Future<Either<Failure, LoginResponse>> call(String refreshToken) async {
    return _repository.refreshToken(refreshToken);
  }
}
