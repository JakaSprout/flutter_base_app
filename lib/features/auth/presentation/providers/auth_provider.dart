import 'package:flutter_base_app/core/config/flavor_config.dart';
import 'package:flutter_base_app/core/di/providers/dio_provider.dart';
import 'package:flutter_base_app/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:flutter_base_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_base_app/features/auth/domain/entities/country_code.dart';
import 'package:flutter_base_app/features/auth/domain/entities/login_request.dart';
import 'package:flutter_base_app/features/auth/domain/entities/login_response.dart';
import 'package:flutter_base_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_base_app/features/auth/domain/usecases/get_country_codes.dart';
import 'package:flutter_base_app/features/auth/domain/usecases/login_with_email.dart';
import 'package:flutter_base_app/features/auth/domain/usecases/login_with_phone.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

/// Provider for Auth remote data source.
///
/// Uses [FlavorConfig.useMockApi] to determine whether to use mock or real API.
@Riverpod(keepAlive: true)
AuthRemoteDataSource authRemoteDataSource(AuthRemoteDataSourceRef ref) {
  final config = ref.watch(appConfigProvider);

  // Use mock API if configured for current flavor
  if (FlavorConfig.useMockApi(config.flavor)) {
    return AuthRemoteDataSourceMock(config: config);
  }

  // TODO: Return real API implementation when available
  // return AuthRemoteDataSourceImpl(config: config, dio: ref.watch(dioProvider));

  // Fallback to mock for now
  return AuthRemoteDataSourceMock(config: config);
}

/// Provider for Auth repository.
@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(remoteDataSource: remoteDataSource);
}

/// Provider for GetCountryCodes use case.
@Riverpod(keepAlive: true)
GetCountryCodes getCountryCodes(GetCountryCodesRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return GetCountryCodes(repository);
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

/// Provider for country codes list.
@riverpod
Future<List<CountryCode>> countryCodes(CountryCodesRef ref) async {
  final getCountryCodes = ref.read(getCountryCodesProvider);
  final result = await getCountryCodes();

  return result.fold<List<CountryCode>>(
    (failure) => throw failure,
    (data) => data,
  );
}

/// Provider for phone login.
@riverpod
Future<LoginResponse> phoneLogin(
  PhoneLoginRef ref,
  PhoneLoginRequest request,
) async {
  final loginWithPhone = ref.read(loginWithPhoneProvider);
  final result = await loginWithPhone(request);

  return result.fold<LoginResponse>((failure) => throw failure, (data) => data);
}

/// Provider for email login.
@riverpod
Future<LoginResponse> emailLogin(
  EmailLoginRef ref,
  EmailLoginRequest request,
) async {
  final loginWithEmail = ref.read(loginWithEmailProvider);
  final result = await loginWithEmail(request);

  return result.fold<LoginResponse>((failure) => throw failure, (data) => data);
}
