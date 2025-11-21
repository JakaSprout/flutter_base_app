import 'package:app_mobile_afms/core/config/app_config.dart' show AppConfig;
import 'package:app_mobile_afms/core/di/providers/dio_provider.dart';
import 'package:app_mobile_afms/core/di/providers/secure_storage_provider.dart';
import 'package:app_mobile_afms/core/utils/either_extensions.dart';
import 'package:app_mobile_afms/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:app_mobile_afms/features/auth/data/datasources/remote/auth_remote_datasource_impl.dart';
import 'package:app_mobile_afms/features/auth/data/datasources/remote/auth_remote_datasource_mock.dart';
import 'package:app_mobile_afms/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:app_mobile_afms/features/auth/domain/entities/login_request.dart';
import 'package:app_mobile_afms/features/auth/domain/entities/login_response.dart';
import 'package:app_mobile_afms/features/auth/domain/repositories/auth_repository.dart';
import 'package:app_mobile_afms/features/auth/domain/usecases/login_with_email.dart';
import 'package:app_mobile_afms/features/auth/domain/usecases/login_with_phone.dart';
import 'package:app_mobile_afms/features/auth/domain/usecases/logout.dart';
import 'package:app_mobile_afms/features/auth/domain/usecases/refresh_token.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

/// Provider for Auth remote data source.
///
/// Uses [AppConfig.useMockApi] to determine whether to use mock or real API.
@Riverpod(keepAlive: true)
AuthRemoteDataSource authRemoteDataSource(AuthRemoteDataSourceRef ref) {
  final config = ref.watch(appConfigProvider);

  final secureStorage = ref.watch(secureStorageProvider);

  // Use mock API if configured for current flavor
  if (config.useMockApi) {
    return AuthRemoteDataSourceMock(
      config: config,
      secureStorage: secureStorage,
    );
  }

  final dio = ref.watch(dioProvider);

  // Return real API implementation
  return AuthRemoteDataSourceImpl(
    config: config,
    dio: dio,
    secureStorage: secureStorage,
  );
}

/// Provider for Auth repository.
@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(remoteDataSource: remoteDataSource);
}

/// Provider for LoginWithPhone use case.
@Riverpod(keepAlive: true)
LoginWithPhone loginWithPhone(LoginWithPhoneRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginWithPhone(repository);
}

/// Provider for LoginWithEmail use case.
@Riverpod(keepAlive: true)
LoginWithEmail loginWithEmail(LoginWithEmailRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginWithEmail(repository);
}

/// Provider for RefreshToken use case.
@Riverpod(keepAlive: true)
RefreshToken refreshToken(RefreshTokenRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RefreshToken(repository);
}

/// Provider for Logout use case.
@Riverpod(keepAlive: true)
Logout logoutUseCase(LogoutUseCaseRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return Logout(repository);
}

/// Provider for phone login.
@riverpod
Future<LoginResponse> phoneLogin(
  PhoneLoginRef ref,
  PhoneLoginRequest request,
) async {
  final loginWithPhone = ref.read(loginWithPhoneProvider);
  final result = await loginWithPhone(request);
  return result.toFuture();
}

/// Provider for email login.
@riverpod
Future<LoginResponse> emailLogin(
  EmailLoginRef ref,
  EmailLoginRequest request,
) async {
  final loginWithEmail = ref.read(loginWithEmailProvider);
  final result = await loginWithEmail(request);
  return result.toFuture();
}

/// Provider for token refresh.
@riverpod
Future<LoginResponse> tokenRefresh(
  TokenRefreshRef ref,
  String refreshToken,
) async {
  final refreshTokenUseCase = ref.read(refreshTokenProvider);
  final result = await refreshTokenUseCase(refreshToken);
  return result.toFuture();
}
