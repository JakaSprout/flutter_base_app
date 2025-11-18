import 'package:flutter_base_app/core/config/app_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppFlavor', () {
    test('should have all three flavors', () {
      // Assert
      expect(AppFlavor.values, hasLength(3));
      expect(AppFlavor.values, contains(AppFlavor.dev));
      expect(AppFlavor.values, contains(AppFlavor.staging));
      expect(AppFlavor.values, contains(AppFlavor.prod));
    });
  });

  group('AppConfig', () {
    group('constructor', () {
      test('should create config with all required properties', () {
        // Act
        const config = AppConfig(
          flavor: AppFlavor.dev,
          appName: 'Test App',
          apiBaseUrl: 'https://api.test.com',
          enableLogging: true,
          enableCrashReporting: false,
        );

        // Assert
        expect(config.flavor, equals(AppFlavor.dev));
        expect(config.appName, equals('Test App'));
        expect(config.apiBaseUrl, equals('https://api.test.com'));
        expect(config.enableLogging, isTrue);
        expect(config.enableCrashReporting, isFalse);
      });
    });

    group('static configs', () {
      test('dev config should have correct values', () {
        // Assert
        expect(AppConfig.dev.flavor, equals(AppFlavor.dev));
        expect(AppConfig.dev.appName, equals('Flutter Base App Dev'));
        expect(
          AppConfig.dev.apiBaseUrl,
          equals('https://39ed3fab6852.ngrok-free.app'),
        );
        expect(AppConfig.dev.enableLogging, isTrue);
        expect(AppConfig.dev.enableCrashReporting, isFalse);
      });

      test('staging config should have correct values', () {
        // Assert
        expect(AppConfig.staging.flavor, equals(AppFlavor.staging));
        expect(AppConfig.staging.appName, equals('Flutter Base App Staging'));
        expect(
          AppConfig.staging.apiBaseUrl,
          equals('https://api-staging.example.com'),
        );
        expect(AppConfig.staging.enableLogging, isTrue);
        expect(AppConfig.staging.enableCrashReporting, isTrue);
      });

      test('prod config should have correct values', () {
        // Assert
        expect(AppConfig.prod.flavor, equals(AppFlavor.prod));
        expect(AppConfig.prod.appName, equals('Flutter Base App'));
        expect(AppConfig.prod.apiBaseUrl, equals('https://api.example.com'));
        expect(AppConfig.prod.enableLogging, isFalse);
        expect(AppConfig.prod.enableCrashReporting, isTrue);
      });
    });

    group('fromFlavor', () {
      test('should return dev config for dev flavor', () {
        // Act
        final config = AppConfig.fromFlavor(AppFlavor.dev);

        // Assert
        expect(config, equals(AppConfig.dev));
        expect(config.flavor, equals(AppFlavor.dev));
      });

      test('should return staging config for staging flavor', () {
        // Act
        final config = AppConfig.fromFlavor(AppFlavor.staging);

        // Assert
        expect(config, equals(AppConfig.staging));
        expect(config.flavor, equals(AppFlavor.staging));
      });

      test('should return prod config for prod flavor', () {
        // Act
        final config = AppConfig.fromFlavor(AppFlavor.prod);

        // Assert
        expect(config, equals(AppConfig.prod));
        expect(config.flavor, equals(AppFlavor.prod));
      });
    });
  });
}
