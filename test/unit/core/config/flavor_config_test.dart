import 'package:flutter_base_app/core/config/app_config.dart';
import 'package:flutter_base_app/core/config/flavor_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlavorConfig', () {
    group('getApiBaseUrl', () {
      test('should return dev API URL for dev flavor', () {
        // Act
        final url = FlavorConfig.getApiBaseUrl(AppFlavor.dev);

        // Assert
        expect(url, equals('https://jsonplaceholder.typicode.com'));
      });

      test('should return staging API URL for staging flavor', () {
        // Act
        final url = FlavorConfig.getApiBaseUrl(AppFlavor.staging);

        // Assert
        expect(url, equals('https://api-staging.example.com'));
      });

      test('should return prod API URL for prod flavor', () {
        // Act
        final url = FlavorConfig.getApiBaseUrl(AppFlavor.prod);

        // Assert
        expect(url, equals('https://api.example.com'));
      });
    });

    group('getApiTimeout', () {
      test('should return 60 seconds for dev flavor', () {
        // Act
        final timeout = FlavorConfig.getApiTimeout(AppFlavor.dev);

        // Assert
        expect(timeout, equals(60));
      });

      test('should return 30 seconds for staging flavor', () {
        // Act
        final timeout = FlavorConfig.getApiTimeout(AppFlavor.staging);

        // Assert
        expect(timeout, equals(30));
      });

      test('should return 20 seconds for prod flavor', () {
        // Act
        final timeout = FlavorConfig.getApiTimeout(AppFlavor.prod);

        // Assert
        expect(timeout, equals(20));
      });
    });

    group('useMockApi', () {
      test('should return true for dev flavor', () {
        // Act
        final useMock = FlavorConfig.useMockApi(AppFlavor.dev);

        // Assert
        expect(useMock, isTrue);
      });

      test('should return false for staging flavor', () {
        // Act
        final useMock = FlavorConfig.useMockApi(AppFlavor.staging);

        // Assert
        expect(useMock, isFalse);
      });

      test('should return false for prod flavor', () {
        // Act
        final useMock = FlavorConfig.useMockApi(AppFlavor.prod);

        // Assert
        expect(useMock, isFalse);
      });
    });

    group('getMockApiDelay', () {
      test('should return 2000ms for dev flavor', () {
        // Act
        final delay = FlavorConfig.getMockApiDelay(AppFlavor.dev);

        // Assert
        expect(delay, equals(2000));
      });

      test('should return 1000ms for staging flavor', () {
        // Act
        final delay = FlavorConfig.getMockApiDelay(AppFlavor.staging);

        // Assert
        expect(delay, equals(1000));
      });

      test('should return 0ms for prod flavor', () {
        // Act
        final delay = FlavorConfig.getMockApiDelay(AppFlavor.prod);

        // Assert
        expect(delay, equals(0));
      });
    });
  });
}

