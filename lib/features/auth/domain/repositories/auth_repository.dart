import 'package:dartz/dartz.dart';
import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/auth/domain/entities/login_request.dart';
import 'package:app_mobile_afms/features/auth/domain/entities/login_response.dart';

/// Repository interface for Auth feature (domain layer).
///
/// This defines the contract for authentication operations.
/// Implementation is in the data layer.
abstract class AuthRepository {
  /// Login with phone number.
  ///
  /// Returns [Either] containing [Failure] on error or [LoginResponse] on success.
  Future<Either<Failure, LoginResponse>> loginWithPhone(
    PhoneLoginRequest request,
  );

  /// Login with email and password.
  ///
  /// Returns [Either] containing [Failure] on error or [LoginResponse] on success.
  Future<Either<Failure, LoginResponse>> loginWithEmail(
    EmailLoginRequest request,
  );

  /// Refresh access token using refresh token.
  ///
  /// Returns [Either] containing [Failure] on error or [LoginResponse] on success.
  Future<Either<Failure, LoginResponse>> refreshToken(String refreshToken);

  /// Logout from the server.
  ///
  /// Invalidates the current session on the server.
  /// Returns [Either] containing [Failure] on error or void on success.
  Future<Either<Failure, void>> logout();
}
