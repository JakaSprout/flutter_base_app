import 'package:flutter_base_app/core/sync/models/sync_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SyncItem', () {
    test('should create sync item with required fields', () {
      // Arrange
      const id = 'test-id';
      const operationType = SyncOperationType.create;
      const entityType = 'pond';
      const entityId = 'pond-123';
      const data = {'name': 'Test Pond'};

      // Act
      const item = SyncItem(
        id: id,
        operationType: operationType,
        entityType: entityType,
        entityId: entityId,
        data: data,
      );

      // Assert
      expect(item.id, equals(id));
      expect(item.operationType, equals(operationType));
      expect(item.entityType, equals(entityType));
      expect(item.entityId, equals(entityId));
      expect(item.data, equals(data));
      expect(item.priority, equals(SyncPriority.normal));
      expect(item.retryCount, equals(0));
      expect(item.maxRetries, equals(3));
      expect(item.createdAt, isNull);
      expect(item.updatedAt, isNull);
      expect(item.error, isNull);
      expect(item.metadata, isNull);
    });

    test('should create sync item with all fields', () {
      // Arrange
      final createdAt = DateTime(2024);
      final updatedAt = DateTime(2024, 1, 2);
      const metadata = {'source': 'mobile'};

      // Act
      final item = SyncItem(
        id: 'test-id',
        operationType: SyncOperationType.update,
        entityType: 'pond',
        entityId: 'pond-123',
        data: {'name': 'Test Pond'},
        priority: SyncPriority.high,
        retryCount: 1,
        maxRetries: 5,
        createdAt: createdAt,
        updatedAt: updatedAt,
        error: 'Test error',
        metadata: metadata,
      );

      // Assert
      expect(item.priority, equals(SyncPriority.high));
      expect(item.retryCount, equals(1));
      expect(item.maxRetries, equals(5));
      expect(item.createdAt, equals(createdAt));
      expect(item.updatedAt, equals(updatedAt));
      expect(item.error, equals('Test error'));
      expect(item.metadata, equals(metadata));
    });

    test('canRetry should return true when retryCount is less than maxRetries', () {
      // Arrange
      const item = SyncItem(
        id: 'test-id',
        operationType: SyncOperationType.create,
        entityType: 'pond',
        entityId: 'pond-123',
        data: {},
        retryCount: 1,
      );

      // Act & Assert
      expect(item.canRetry, isTrue);
    });

    test('canRetry should return false when retryCount equals maxRetries', () {
      // Arrange
      const item = SyncItem(
        id: 'test-id',
        operationType: SyncOperationType.create,
        entityType: 'pond',
        entityId: 'pond-123',
        data: {},
        retryCount: 3,
      );

      // Act & Assert
      expect(item.canRetry, isFalse);
    });

    test('canRetry should return false when retryCount exceeds maxRetries', () {
      // Arrange
      const item = SyncItem(
        id: 'test-id',
        operationType: SyncOperationType.create,
        entityType: 'pond',
        entityId: 'pond-123',
        data: {},
        retryCount: 4,
      );

      // Act & Assert
      expect(item.canRetry, isFalse);
    });

    test('hasExceededMaxRetries should return false when retryCount is less than maxRetries', () {
      // Arrange
      const item = SyncItem(
        id: 'test-id',
        operationType: SyncOperationType.create,
        entityType: 'pond',
        entityId: 'pond-123',
        data: {},
        retryCount: 1,
      );

      // Act & Assert
      expect(item.hasExceededMaxRetries, isFalse);
    });

    test('hasExceededMaxRetries should return true when retryCount equals maxRetries', () {
      // Arrange
      const item = SyncItem(
        id: 'test-id',
        operationType: SyncOperationType.create,
        entityType: 'pond',
        entityId: 'pond-123',
        data: {},
        retryCount: 3,
      );

      // Act & Assert
      expect(item.hasExceededMaxRetries, isTrue);
    });

    test('hasExceededMaxRetries should return true when retryCount exceeds maxRetries', () {
      // Arrange
      const item = SyncItem(
        id: 'test-id',
        operationType: SyncOperationType.create,
        entityType: 'pond',
        entityId: 'pond-123',
        data: {},
        retryCount: 4,
      );

      // Act & Assert
      expect(item.hasExceededMaxRetries, isTrue);
    });

    test('copyWith should create new instance with updated fields', () {
      // Arrange
      const original = SyncItem(
        id: 'test-id',
        operationType: SyncOperationType.create,
        entityType: 'pond',
        entityId: 'pond-123',
        data: {'name': 'Original'},
      );

      // Act
      final updated = original.copyWith(
        operationType: SyncOperationType.update,
        data: {'name': 'Updated'},
        priority: SyncPriority.high,
        retryCount: 1,
        error: 'Test error',
      );

      // Assert
      expect(updated.id, equals(original.id));
      expect(updated.operationType, equals(SyncOperationType.update));
      expect(updated.data, equals({'name': 'Updated'}));
      expect(updated.priority, equals(SyncPriority.high));
      expect(updated.retryCount, equals(1));
      expect(updated.error, equals('Test error'));
      expect(updated.maxRetries, equals(original.maxRetries));
      expect(updated.entityType, equals(original.entityType));
      expect(updated.entityId, equals(original.entityId));
    });

    test('copyWith should keep original values when fields are not provided', () {
      // Arrange
      const original = SyncItem(
        id: 'test-id',
        operationType: SyncOperationType.create,
        entityType: 'pond',
        entityId: 'pond-123',
        data: {'name': 'Original'},
        priority: SyncPriority.high,
        retryCount: 2,
        maxRetries: 5,
      );

      // Act
      final updated = original.copyWith(
        error: 'New error',
      );

      // Assert
      expect(updated.id, equals(original.id));
      expect(updated.operationType, equals(original.operationType));
      expect(updated.data, equals(original.data));
      expect(updated.priority, equals(original.priority));
      expect(updated.retryCount, equals(original.retryCount));
      expect(updated.maxRetries, equals(original.maxRetries));
      expect(updated.error, equals('New error'));
    });

    test('toString should return formatted string', () {
      // Arrange
      const item = SyncItem(
        id: 'test-id',
        operationType: SyncOperationType.create,
        entityType: 'pond',
        entityId: 'pond-123',
        data: {},
        retryCount: 1,
      );

      // Act
      final result = item.toString();

      // Assert
      expect(result, contains('test-id'));
      expect(result, contains('create'));
      expect(result, contains('pond'));
      expect(result, contains('pond-123'));
      expect(result, contains('1/3'));
    });

    group('SyncOperationType', () {
      test('should have all operation types', () {
        expect(SyncOperationType.values.length, equals(3));
        expect(SyncOperationType.values, contains(SyncOperationType.create));
        expect(SyncOperationType.values, contains(SyncOperationType.update));
        expect(SyncOperationType.values, contains(SyncOperationType.delete));
      });
    });

    group('SyncPriority', () {
      test('should have all priority levels', () {
        expect(SyncPriority.values.length, equals(4));
        expect(SyncPriority.values, contains(SyncPriority.low));
        expect(SyncPriority.values, contains(SyncPriority.normal));
        expect(SyncPriority.values, contains(SyncPriority.high));
        expect(SyncPriority.values, contains(SyncPriority.critical));
      });
    });
  });
}

