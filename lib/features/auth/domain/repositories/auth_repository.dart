import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/auth/domain/entities/country_code.dart';
import 'package:flutter_base_app/features/auth/domain/entities/login_request.dart';
import 'package:flutter_base_app/features/auth/domain/entities/login_response.dart';

/// Repository interface for Auth feature (domain layer).
///
/// This defines the contract for authentication operations.
/// Implementation is in the data layer.
abstract class AuthRepository {
  /// Get list of supported country codes.
  ///
  /// Returns [Either] containing [Failure] on error or [List<CountryCode>] on success.
  Future<Either<Failure, List<CountryCode>>> getCountryCodes();

  /// Login with phone number and password.
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
}




