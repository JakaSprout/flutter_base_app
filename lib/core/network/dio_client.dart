import 'package:dio/dio.dart';
import 'package:flutter_base_app/core/config/app_config.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/core/network/interceptors/auth_interceptor.dart';
import 'package:flutter_base_app/core/network/interceptors/error_interceptor.dart';
import 'package:flutter_base_app/core/network/interceptors/logging_interceptor.dart';
import 'package:flutter_base_app/core/network/interceptors/retry_interceptor.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Dio client setup with interceptors.
class DioClient {
  /// Creates a new instance of [DioClient].
  DioClient({
    required AppConfig config,
    required FlutterSecureStorage secureStorage,
  }) : _config = config,
       _secureStorage = secureStorage {
    _dio = Dio(_createBaseOptions());
    _setupInterceptors();
  }

  final AppConfig _config;
  final FlutterSecureStorage _secureStorage;
  late final Dio _dio;

  /// Get Dio instance.
  Dio get instance => _dio;

  /// Get base URL.
  String get baseUrl => _dio.options.baseUrl;

  /// Set base URL (useful for testing or dynamic config).
  set baseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  /// Create base options for Dio.
  BaseOptions _createBaseOptions() {
    return BaseOptions(
      baseUrl: _config.apiBaseUrl,
      connectTimeout: const Duration(
        seconds: AppConstants.connectionTimeoutSeconds,
      ),
      receiveTimeout: const Duration(
        seconds: AppConstants.receiveTimeoutSeconds,
      ),
      sendTimeout: const Duration(
        seconds: AppConstants.connectionTimeoutSeconds,
      ),
      headers: const {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }

  /// Setup interceptors.
  void _setupInterceptors() {
    _dio.interceptors.addAll([
      // Order matters: Auth first, then logging, then error, then retry
      AuthInterceptor(secureStorage: _secureStorage),
      if (_config.enableLogging) LoggingInterceptor(),
      ErrorInterceptor(),
      RetryInterceptor(dio: _dio),
    ]);
  }

  /// Clear interceptors (useful for testing).
  void clearInterceptors() {
    _dio.interceptors.clear();
  }
}
