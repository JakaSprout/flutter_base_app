import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/error/failures.dart';
import 'package:flutter_base_app/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:flutter_base_app/features/auth/data/models/country_code_model.dart';
import 'package:flutter_base_app/features/auth/data/models/login_response_model.dart';
import 'package:flutter_base_app/features/auth/domain/entities/country_code.dart';
import 'package:flutter_base_app/features/auth/domain/entities/login_request.dart';
import 'package:flutter_base_app/features/auth/domain/entities/login_response.dart';
import 'package:flutter_base_app/features/auth/domain/repositories/auth_repository.dart';

/// Repository implementation for Auth feature (data layer).
///
/// This implements the [AuthRepository] interface from the domain layer.
class AuthRepositoryImpl implements AuthRepository {
  /// Creates a new instance of [AuthRepositoryImpl].
  AuthRepositoryImpl({required AuthRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<CountryCode>>> getCountryCodes() async {
    final result = await _remoteDataSource.getCountryCodes();
    return result.fold(
      Left.new,
      (models) => Right(
        models.map((model) => model.toEntity()).toList(),
      ),
    );
  }

  @override
  Future<Either<Failure, LoginResponse>> loginWithPhone(
    PhoneLoginRequest request,
  ) async {
    final result = await _remoteDataSource.loginWithPhone(request);
    return result.fold(Left.new, (model) => Right(model.toEntity()));
  }

  @override
  Future<Either<Failure, LoginResponse>> loginWithEmail(
    EmailLoginRequest request,
  ) async {
    final result = await _remoteDataSource.loginWithEmail(request);
    return result.fold(Left.new, (model) => Right(model.toEntity()));
  }
}




