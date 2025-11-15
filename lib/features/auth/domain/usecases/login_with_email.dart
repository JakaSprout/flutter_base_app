import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/auth/domain/entities/login_request.dart';
import 'package:flutter_base_app/features/auth/domain/entities/login_response.dart';
import 'package:flutter_base_app/features/auth/domain/repositories/auth_repository.dart';

/// Use case for login with email.
class LoginWithEmail {
  /// Creates a new instance of [LoginWithEmail].
  const LoginWithEmail(this._repository);

  final AuthRepository _repository;

  /// Executes the use case.
  ///
  /// Returns [Either] containing [Failure] on error or [LoginResponse] on success.
  Future<Either<Failure, LoginResponse>> call(
    EmailLoginRequest request,
  ) async {
    return await _repository.loginWithEmail(request);
  }
}


