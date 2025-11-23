import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:app_mobile_afms/features/auth/data/models/login_response_model.dart';
import 'package:app_mobile_afms/features/auth/domain/entities/login_request.dart';
import 'package:app_mobile_afms/features/auth/domain/entities/login_response.dart';
import 'package:app_mobile_afms/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

/// Repository implementation for Auth feature (data layer).
///
/// This implements the [AuthRepository] interface from the domain layer.
class AuthRepositoryImpl implements AuthRepository {
  /// Creates a new instance of [AuthRepositoryImpl].
  AuthRepositoryImpl({required AuthRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final AuthRemoteDataSource _remoteDataSource;

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

  @override
  Future<Either<Failure, LoginResponse>> refreshToken(
    String refreshToken,
  ) async {
    final result = await _remoteDataSource.refreshToken(refreshToken);
    return result.fold(Left.new, (model) => Right(model.toEntity()));
  }

  @override
  Future<Either<Failure, void>> logout() async {
    final result = await _remoteDataSource.logout();
    return result;
  }
}
