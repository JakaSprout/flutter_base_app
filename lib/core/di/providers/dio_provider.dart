import 'package:app_mobile_afms/core/config/app_config.dart';
import 'package:app_mobile_afms/core/di/providers/secure_storage_provider.dart';
import 'package:app_mobile_afms/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

/// Provider for AppConfig.
///
/// This provider provides the application configuration based on the current
/// flavor. In production, this should be set during app initialization.
@Riverpod(keepAlive: true)
AppConfig appConfig(AppConfigRef ref) {
  // TODO(team): Get from environment or flavor during app initialization
  return AppConfig.dev;
}

/// Provider for DioClient instance.
///
/// This provider creates a DioClient instance with all interceptors configured.
/// The DioClient depends on AppConfig and FlutterSecureStorage.
@Riverpod(keepAlive: true)
DioClient dioClient(DioClientRef ref) {
  final config = ref.watch(appConfigProvider);
  final secureStorage = ref.watch(secureStorageProvider);

  return DioClient(config: config, secureStorage: secureStorage);
}

/// Provider for Dio instance.
///
/// This provider provides direct access to the Dio instance from DioClient.
/// Use this when you need the Dio instance directly.
@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final dioClient = ref.watch(dioClientProvider);
  return dioClient.instance;
}
