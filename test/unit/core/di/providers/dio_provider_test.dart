import 'package:dio/dio.dart';
import 'package:app_mobile_afms/core/config/app_config.dart';
import 'package:app_mobile_afms/core/di/providers/dio_provider.dart';
import 'package:app_mobile_afms/core/network/dio_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../helpers/test_helpers.dart';

void main() {
  group('DioProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = TestHelpers.createContainer();
    });

    tearDown(() {
      container.dispose();
    });

    group('appConfigProvider', () {
      test('should return AppConfig instance', () {
        // Act
        final config = container.read(appConfigProvider);

        // Assert
        expect(config, isA<AppConfig>());
        expect(config.flavor, equals(AppFlavor.dev));
      });

      test('should return same instance when read multiple times', () {
        // Act
        final config1 = container.read(appConfigProvider);
        final config2 = container.read(appConfigProvider);

        // Assert
        expect(config1, same(config2));
      });
    });

    group('dioClientProvider', () {
      test('should return DioClient instance', () {
        // Act
        final dioClient = container.read(dioClientProvider);

        // Assert
        expect(dioClient, isA<DioClient>());
      });

      test('should use appConfigProvider', () {
        // Act
        final config = container.read(appConfigProvider);
        final dioClient = container.read(dioClientProvider);

        // Assert
        expect(dioClient, isA<DioClient>());
        // DioClient should be initialized with the config
        expect(config, isA<AppConfig>());
      });

      test('should return same instance when read multiple times', () {
        // Act
        final dioClient1 = container.read(dioClientProvider);
        final dioClient2 = container.read(dioClientProvider);

        // Assert
        expect(dioClient1, same(dioClient2));
      });
    });

    group('dioProvider', () {
      test('should return Dio instance', () {
        // Act
        final dio = container.read(dioProvider);

        // Assert
        expect(dio, isA<Dio>());
      });

      test('should use dioClientProvider', () {
        // Act
        final dioClient = container.read(dioClientProvider);
        final dio = container.read(dioProvider);

        // Assert
        expect(dio, isA<Dio>());
        expect(dioClient.instance, same(dio));
      });

      test('should return same instance when read multiple times', () {
        // Act
        final dio1 = container.read(dioProvider);
        final dio2 = container.read(dioProvider);

        // Assert
        expect(dio1, same(dio2));
      });
    });

    group('provider dependencies', () {
      test('should maintain dependency chain', () {
        // Act
        final config = container.read(appConfigProvider);
        final dioClient = container.read(dioClientProvider);
        final dio = container.read(dioProvider);

        // Assert
        expect(config, isA<AppConfig>());
        expect(dioClient, isA<DioClient>());
        expect(dio, isA<Dio>());
        expect(dioClient.instance, same(dio));
      });

      test('should update when appConfigProvider changes', () {
        // Arrange
        final originalConfig = container.read(appConfigProvider);
        final originalDioClient = container.read(dioClientProvider);

        // Act - Override appConfigProvider
        final newContainer = ProviderContainer(
          overrides: [
            appConfigProvider.overrideWithValue(AppConfig.staging),
          ],
        );

        final newConfig = newContainer.read(appConfigProvider);
        final newDioClient = newContainer.read(dioClientProvider);

        // Assert
        expect(newConfig.flavor, equals(AppFlavor.staging));
        expect(newConfig.flavor, isNot(equals(originalConfig.flavor)));
        expect(newDioClient, isA<DioClient>());
        // DioClient should be recreated with new config
        expect(newDioClient, isNot(same(originalDioClient)));

        // Cleanup
        newContainer.dispose();
      });
    });
  });
}

