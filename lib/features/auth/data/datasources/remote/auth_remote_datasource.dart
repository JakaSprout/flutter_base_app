import 'package:dartz/dartz.dart';
import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/auth/data/models/login_response_model.dart';
import 'package:app_mobile_afms/features/auth/domain/entities/login_request.dart';

/// Remote data source interface for Auth feature.
///
/// This interface defines the contract for authentication-related remote data
/// operations. Implementations should handle API calls to the backend.
abstract class AuthRemoteDataSource {
  /// Login with phone number.
  Future<Either<Failure, LoginResponseModel>> loginWithPhone(
    PhoneLoginRequest request,
  );

  /// Login with email and password.
  Future<Either<Failure, LoginResponseModel>> loginWithEmail(
    EmailLoginRequest request,
  );

  /// Refresh access token using refresh token.
  Future<Either<Failure, LoginResponseModel>> refreshToken(String refreshToken);

  /// Logout from the server.
  ///
  /// Invalidates the current session on the server.
  Future<Either<Failure, void>> logout();
}
