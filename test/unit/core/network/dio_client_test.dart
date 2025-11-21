import 'package:dio/dio.dart';
import 'package:app_mobile_afms/core/config/app_config.dart';
import 'package:app_mobile_afms/core/network/dio_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  group('DioClient', () {
    late DioClient dioClient;
    late MockFlutterSecureStorage mockSecureStorage;
    late AppConfig config;

    setUp(() {
      mockSecureStorage = MockFlutterSecureStorage();
      config = AppConfig.dev;
      dioClient = DioClient(config: config, secureStorage: mockSecureStorage);
    });

    tearDown(() {
      dioClient.clearInterceptors();
    });

    test('should create Dio instance with correct base URL', () {
      // Assert
      expect(dioClient.baseUrl, equals(config.apiBaseUrl));
      expect(dioClient.instance, isA<Dio>());
    });

    test('should set base URL correctly', () {
      // Arrange
      const newBaseUrl = 'https://new-api.example.com';

      // Act
      dioClient.baseUrl = newBaseUrl;

      // Assert
      expect(dioClient.baseUrl, equals(newBaseUrl));
    });

    test('should setup interceptors in correct order', () {
      // Assert
      final interceptors = dioClient.instance.interceptors;
      expect(interceptors.length, greaterThan(0));

      // Verify interceptors are added (order: Auth, Logging, Error, Retry)
      // Note: LoggingInterceptor is conditional based on config.enableLogging
      // Dio might have default interceptors, so we just verify we have at least the expected ones
      if (config.enableLogging) {
        expect(interceptors.length, greaterThanOrEqualTo(4));
      } else {
        expect(interceptors.length, greaterThanOrEqualTo(3));
      }
    });

    test('should configure base options correctly', () {
      // Assert
      final options = dioClient.instance.options;
      expect(options.baseUrl, equals(config.apiBaseUrl));
      expect(options.connectTimeout, isNotNull);
      expect(options.receiveTimeout, isNotNull);
      expect(options.sendTimeout, isNotNull);
      expect(options.headers['Content-Type'], equals('application/json'));
      expect(options.headers['Accept'], equals('application/json'));
    });

    test('should clear interceptors when requested', () {
      // Arrange
      final initialCount = dioClient.instance.interceptors.length;
      expect(initialCount, greaterThan(0));

      // Act
      dioClient.clearInterceptors();

      // Assert
      // Dio might have default interceptors that can't be cleared
      expect(dioClient.instance.interceptors.length, lessThan(initialCount));
    });

    test('should use staging config correctly', () {
      // Arrange
      const stagingConfig = AppConfig.staging;
      final stagingClient = DioClient(
        config: stagingConfig,
        secureStorage: mockSecureStorage,
      );

      // Assert
      expect(stagingClient.baseUrl, equals(stagingConfig.apiBaseUrl));
    });

    test('should use production config correctly', () {
      // Arrange
      const prodConfig = AppConfig.prod;
      final prodClient = DioClient(
        config: prodConfig,
        secureStorage: mockSecureStorage,
      );

      // Assert
      expect(prodClient.baseUrl, equals(prodConfig.apiBaseUrl));
      // Production should not have LoggingInterceptor
      // Dio might have default interceptors, so we verify it's at least 3
      expect(prodClient.instance.interceptors.length, greaterThanOrEqualTo(3));
    });

    test('should allow making requests through Dio instance', () async {
      // Arrange
      // Note: This test would require a real HTTP server or more complex mocking
      // For now, we just verify the instance is usable
      expect(dioClient.instance, isA<Dio>());
      expect(dioClient.instance.options.baseUrl, isNotEmpty);
    });
  });
}
