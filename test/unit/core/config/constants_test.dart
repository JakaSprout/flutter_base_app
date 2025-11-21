import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppConstants', () {
    test('should have correct API timeout configuration', () {
      // Assert
      expect(AppConstants.apiTimeoutSeconds, equals(30));
      expect(AppConstants.apiRetryAttempts, equals(3));
      expect(AppConstants.apiRetryDelayMs, equals(1000));
    });

    test('should have correct database configuration', () {
      // Assert
      expect(AppConstants.databaseName, equals('flutter_base_app.db'));
      expect(AppConstants.databaseVersion, equals(1));
    });

    test('should have correct storage keys', () {
      // Assert
      expect(AppConstants.storageAuthToken, equals('auth_token'));
      expect(AppConstants.storageRefreshToken, equals('refresh_token'));
      expect(AppConstants.storageUserData, equals('user_data'));
      expect(AppConstants.storageThemeMode, equals('theme_mode'));
    });

    test('should have correct network configuration', () {
      // Assert
      expect(AppConstants.maxConcurrentRequests, equals(5));
      expect(AppConstants.connectionTimeoutSeconds, equals(10));
      expect(AppConstants.receiveTimeoutSeconds, equals(30));
    });

    test('should have correct sync configuration', () {
      // Assert
      expect(AppConstants.maxSyncQueueSize, equals(100));
      expect(AppConstants.syncRetryAttempts, equals(3));
      expect(AppConstants.syncRetryDelayMs, equals(2000));
      expect(AppConstants.batchSyncSize, equals(50));
      expect(AppConstants.sseReconnectDelaySeconds, equals(3));
      expect(AppConstants.sseMaxReconnectAttempts, equals(10));
    });

    test('should have correct pagination configuration', () {
      // Assert
      expect(AppConstants.defaultPageSize, equals(20));
      expect(AppConstants.maxPageSize, equals(100));
    });

    test('should have correct typography configuration', () {
      // Assert
      expect(AppConstants.fontFamily, equals('Open Sans'));
    });
  });
}

