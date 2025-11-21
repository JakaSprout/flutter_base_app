import 'package:flutter_base_app/core/sync/models/sync_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SyncStatusModel', () {
    test('should create sync status with required fields', () {
      // Arrange & Act
      const status = SyncStatusModel(
        status: SyncStatus.idle,
      );

      // Assert
      expect(status.status, equals(SyncStatus.idle));
      expect(status.progress, isNull);
      expect(status.totalItems, isNull);
      expect(status.syncedItems, isNull);
      expect(status.failedItems, isNull);
      expect(status.message, isNull);
      expect(status.lastSyncTime, isNull);
      expect(status.error, isNull);
    });

    test('should create sync status with all fields', () {
      // Arrange
      final lastSyncTime = DateTime(2024);

      // Act
      final status = SyncStatusModel(
        status: SyncStatus.syncing,
        progress: 0.5,
        totalItems: 100,
        syncedItems: 50,
        failedItems: 5,
        message: 'Syncing...',
        lastSyncTime: lastSyncTime,
        error: 'Test error',
      );

      // Assert
      expect(status.status, equals(SyncStatus.syncing));
      expect(status.progress, equals(0.5));
      expect(status.totalItems, equals(100));
      expect(status.syncedItems, equals(50));
      expect(status.failedItems, equals(5));
      expect(status.message, equals('Syncing...'));
      expect(status.lastSyncTime, equals(lastSyncTime));
      expect(status.error, equals('Test error'));
    });

    test('isSyncing should return true when status is syncing', () {
      // Arrange
      const status = SyncStatusModel(status: SyncStatus.syncing);

      // Act & Assert
      expect(status.isSyncing, isTrue);
    });

    test('isSyncing should return false when status is not syncing', () {
      // Arrange
      const status = SyncStatusModel(status: SyncStatus.idle);

      // Act & Assert
      expect(status.isSyncing, isFalse);
    });

    test('isIdle should return true when status is idle', () {
      // Arrange
      const status = SyncStatusModel(status: SyncStatus.idle);

      // Act & Assert
      expect(status.isIdle, isTrue);
    });

    test('isIdle should return false when status is not idle', () {
      // Arrange
      const status = SyncStatusModel(status: SyncStatus.syncing);

      // Act & Assert
      expect(status.isIdle, isFalse);
    });

    test('isSuccess should return true when status is success', () {
      // Arrange
      const status = SyncStatusModel(status: SyncStatus.success);

      // Act & Assert
      expect(status.isSuccess, isTrue);
    });

    test('isSuccess should return false when status is not success', () {
      // Arrange
      const status = SyncStatusModel(status: SyncStatus.idle);

      // Act & Assert
      expect(status.isSuccess, isFalse);
    });

    test('isFailed should return true when status is failed', () {
      // Arrange
      const status = SyncStatusModel(status: SyncStatus.failed);

      // Act & Assert
      expect(status.isFailed, isTrue);
    });

    test('isFailed should return false when status is not failed', () {
      // Arrange
      const status = SyncStatusModel(status: SyncStatus.idle);

      // Act & Assert
      expect(status.isFailed, isFalse);
    });

    test('isPaused should return true when status is paused', () {
      // Arrange
      const status = SyncStatusModel(status: SyncStatus.paused);

      // Act & Assert
      expect(status.isPaused, isTrue);
    });

    test('isPaused should return false when status is not paused', () {
      // Arrange
      const status = SyncStatusModel(status: SyncStatus.idle);

      // Act & Assert
      expect(status.isPaused, isFalse);
    });

    test('copyWith should create new instance with updated fields', () {
      // Arrange
      const original = SyncStatusModel(
        status: SyncStatus.idle,
        totalItems: 100,
        syncedItems: 50,
      );

      // Act
      final updated = original.copyWith(
        status: SyncStatus.syncing,
        syncedItems: 75,
        message: 'Updated',
      );

      // Assert
      expect(updated.status, equals(SyncStatus.syncing));
      expect(updated.totalItems, equals(100));
      expect(updated.syncedItems, equals(75));
      expect(updated.message, equals('Updated'));
      expect(updated.failedItems, equals(original.failedItems));
    });

    test('copyWith should keep original values when fields are not provided', () {
      // Arrange
      const original = SyncStatusModel(
        status: SyncStatus.syncing,
        totalItems: 100,
        syncedItems: 50,
        failedItems: 5,
      );

      // Act
      final updated = original.copyWith(
        message: 'New message',
      );

      // Assert
      expect(updated.status, equals(original.status));
      expect(updated.totalItems, equals(original.totalItems));
      expect(updated.syncedItems, equals(original.syncedItems));
      expect(updated.failedItems, equals(original.failedItems));
      expect(updated.message, equals('New message'));
    });

    test('toString should return formatted string', () {
      // Arrange
      const status = SyncStatusModel(
        status: SyncStatus.syncing,
        totalItems: 100,
        syncedItems: 50,
        failedItems: 5,
      );

      // Act
      final result = status.toString();

      // Assert
      expect(result, contains('syncing'));
      expect(result, contains('100'));
      expect(result, contains('50'));
      expect(result, contains('5'));
    });

    group('SyncStatus', () {
      test('should have all status values', () {
        expect(SyncStatus.values.length, equals(5));
        expect(SyncStatus.values, contains(SyncStatus.idle));
        expect(SyncStatus.values, contains(SyncStatus.syncing));
        expect(SyncStatus.values, contains(SyncStatus.success));
        expect(SyncStatus.values, contains(SyncStatus.failed));
        expect(SyncStatus.values, contains(SyncStatus.paused));
      });
    });
  });
}

