import 'package:dartz/dartz.dart';
import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/auth/domain/entities/login_request.dart';
import 'package:app_mobile_afms/features/auth/domain/entities/login_response.dart';
import 'package:app_mobile_afms/features/auth/domain/repositories/auth_repository.dart';

/// Use case for login with phone number.
class LoginWithPhone {
  /// Creates a new instance of [LoginWithPhone].
  const LoginWithPhone(this._repository);

  final AuthRepository _repository;

  /// Executes the use case.
  ///
  /// Returns [Either] containing [Failure] on error or [LoginResponse] on success.
  Future<Either<Failure, LoginResponse>> call(PhoneLoginRequest request) async {
    return _repository.loginWithPhone(request);
  }
}
