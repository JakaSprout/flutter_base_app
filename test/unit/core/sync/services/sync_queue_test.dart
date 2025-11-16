import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/core/sync/models/sync_item.dart';
import 'package:flutter_base_app/core/sync/services/sync_queue.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SyncQueue', () {
    late SyncQueue queue;

    setUp(() {
      queue = SyncQueue();
    });

    group('initialization', () {
      test('should create empty queue', () {
        // Assert
        expect(queue.size, equals(0));
        expect(queue.isEmpty, isTrue);
        expect(queue.isNotEmpty, isFalse);
        expect(queue.items, isEmpty);
      });
    });

    group('add', () {
      test('should add item to queue', () {
        // Arrange
        final item = createTestSyncItem(id: 'item-1');

        // Act
        queue.add(item);

        // Assert
        expect(queue.size, equals(1));
        expect(queue.isEmpty, isFalse);
        expect(queue.items, contains(item));
        expect(queue.getById('item-1'), equals(item));
      });

      test('should not add duplicate item', () {
        // Arrange
        final item = createTestSyncItem(id: 'item-1');

        // Act
        queue.add(item);
        queue.add(item); // Try to add again

        // Assert
        expect(queue.size, equals(1));
        expect(queue.getById('item-1'), equals(item));
      });

      test('should sort items by priority when adding', () {
        // Arrange
        final lowPriority = createTestSyncItem(
          id: 'item-1',
          priority: SyncPriority.low,
          createdAt: DateTime(2024, 1, 1),
        );
        final highPriority = createTestSyncItem(
          id: 'item-2',
          priority: SyncPriority.high,
          createdAt: DateTime(2024, 1, 2),
        );
        final normalPriority = createTestSyncItem(
          id: 'item-3',
          priority: SyncPriority.normal,
          createdAt: DateTime(2024, 1, 3),
        );

        // Act
        queue.add(lowPriority);
        queue.add(highPriority);
        queue.add(normalPriority);

        // Assert
        expect(queue.items.first, equals(highPriority));
        expect(queue.items[1], equals(normalPriority));
        expect(queue.items.last, equals(lowPriority));
      });

      test('should sort items by creation time when same priority', () {
        // Arrange
        final item1 = createTestSyncItem(
          id: 'item-1',
          priority: SyncPriority.normal,
          createdAt: DateTime(2024, 1, 1),
        );
        final item2 = createTestSyncItem(
          id: 'item-2',
          priority: SyncPriority.normal,
          createdAt: DateTime(2024, 1, 2),
        );
        final item3 = createTestSyncItem(
          id: 'item-3',
          priority: SyncPriority.normal,
          createdAt: DateTime(2024, 1, 3),
        );

        // Act
        queue.add(item3);
        queue.add(item1);
        queue.add(item2);

        // Assert
        expect(queue.items[0], equals(item1));
        expect(queue.items[1], equals(item2));
        expect(queue.items[2], equals(item3));
      });
    });

    group('remove', () {
      test('should remove item from queue', () {
        // Arrange
        final item = createTestSyncItem(id: 'item-1');
        queue.add(item);

        // Act
        final removed = queue.remove('item-1');

        // Assert
        expect(removed, equals(item));
        expect(queue.size, equals(0));
        expect(queue.getById('item-1'), isNull);
      });

      test('should return null when removing non-existent item', () {
        // Act
        final removed = queue.remove('non-existent');

        // Assert
        expect(removed, isNull);
        expect(queue.size, equals(0));
      });
    });

    group('getById', () {
      test('should return item by id', () {
        // Arrange
        final item = createTestSyncItem(id: 'item-1');
        queue.add(item);

        // Act
        final found = queue.getById('item-1');

        // Assert
        expect(found, equals(item));
      });

      test('should return null for non-existent id', () {
        // Act
        final found = queue.getById('non-existent');

        // Assert
        expect(found, isNull);
      });
    });

    group('peek', () {
      test('should return highest priority item without removing', () {
        // Arrange
        final lowPriority = createTestSyncItem(
          id: 'item-1',
          priority: SyncPriority.low,
        );
        final highPriority = createTestSyncItem(
          id: 'item-2',
          priority: SyncPriority.high,
        );
        queue.add(lowPriority);
        queue.add(highPriority);

        // Act
        final peeked = queue.peek();

        // Assert
        expect(peeked, equals(highPriority));
        expect(queue.size, equals(2));
      });

      test('should return null when queue is empty', () {
        // Act
        final peeked = queue.peek();

        // Assert
        expect(peeked, isNull);
      });
    });

    group('poll', () {
      test('should return and remove highest priority item', () {
        // Arrange
        final lowPriority = createTestSyncItem(
          id: 'item-1',
          priority: SyncPriority.low,
        );
        final highPriority = createTestSyncItem(
          id: 'item-2',
          priority: SyncPriority.high,
        );
        queue.add(lowPriority);
        queue.add(highPriority);

        // Act
        final polled = queue.poll();

        // Assert
        expect(polled, equals(highPriority));
        expect(queue.size, equals(1));
        expect(queue.getById('item-2'), isNull);
        expect(queue.getById('item-1'), equals(lowPriority));
      });

      test('should return null when queue is empty', () {
        // Act
        final polled = queue.poll();

        // Assert
        expect(polled, isNull);
      });
    });

    group('clear', () {
      test('should clear all items from queue', () {
        // Arrange
        queue.add(createTestSyncItem(id: 'item-1'));
        queue.add(createTestSyncItem(id: 'item-2'));
        queue.add(createTestSyncItem(id: 'item-3'));

        // Act
        queue.clear();

        // Assert
        expect(queue.size, equals(0));
        expect(queue.isEmpty, isTrue);
        expect(queue.getById('item-1'), isNull);
        expect(queue.getById('item-2'), isNull);
        expect(queue.getById('item-3'), isNull);
      });
    });

    group('getByEntityType', () {
      test('should return items by entity type', () {
        // Arrange
        queue.add(createTestSyncItem(id: 'item-1', entityType: 'pond'));
        queue.add(createTestSyncItem(id: 'item-2', entityType: 'pond'));
        queue.add(createTestSyncItem(id: 'item-3', entityType: 'user'));

        // Act
        final pondItems = queue.getByEntityType('pond');

        // Assert
        expect(pondItems.length, equals(2));
        expect(pondItems.any((item) => item.id == 'item-1'), isTrue);
        expect(pondItems.any((item) => item.id == 'item-2'), isTrue);
        expect(pondItems.any((item) => item.id == 'item-3'), isFalse);
      });

      test('should return empty list when no items match entity type', () {
        // Arrange
        queue.add(createTestSyncItem(id: 'item-1', entityType: 'pond'));

        // Act
        final userItems = queue.getByEntityType('user');

        // Assert
        expect(userItems, isEmpty);
      });
    });

    group('getByOperationType', () {
      test('should return items by operation type', () {
        // Arrange
        queue.add(createTestSyncItem(
          id: 'item-1',
          operationType: SyncOperationType.create,
        ));
        queue.add(createTestSyncItem(
          id: 'item-2',
          operationType: SyncOperationType.create,
        ));
        queue.add(createTestSyncItem(
          id: 'item-3',
          operationType: SyncOperationType.update,
        ));

        // Act
        final createItems = queue.getByOperationType(SyncOperationType.create);

        // Assert
        expect(createItems.length, equals(2));
        expect(createItems.any((item) => item.id == 'item-1'), isTrue);
        expect(createItems.any((item) => item.id == 'item-2'), isTrue);
        expect(createItems.any((item) => item.id == 'item-3'), isFalse);
      });
    });

    group('getFailedItems', () {
      test('should return items that exceeded max retries', () {
        // Arrange
        queue.add(createTestSyncItem(
          id: 'item-1',
          retryCount: 3,
          maxRetries: 3,
        ));
        queue.add(createTestSyncItem(
          id: 'item-2',
          retryCount: 4,
          maxRetries: 3,
        ));
        queue.add(createTestSyncItem(
          id: 'item-3',
          retryCount: 2,
          maxRetries: 3,
        ));

        // Act
        final failedItems = queue.getFailedItems();

        // Assert
        expect(failedItems.length, equals(2));
        expect(failedItems.any((item) => item.id == 'item-1'), isTrue);
        expect(failedItems.any((item) => item.id == 'item-2'), isTrue);
        expect(failedItems.any((item) => item.id == 'item-3'), isFalse);
      });
    });

    group('getPendingItems', () {
      test('should return items that can be retried', () {
        // Arrange
        queue.add(createTestSyncItem(
          id: 'item-1',
          retryCount: 2,
          maxRetries: 3,
        ));
        queue.add(createTestSyncItem(
          id: 'item-2',
          retryCount: 0,
          maxRetries: 3,
        ));
        queue.add(createTestSyncItem(
          id: 'item-3',
          retryCount: 3,
          maxRetries: 3,
        ));

        // Act
        final pendingItems = queue.getPendingItems();

        // Assert
        expect(pendingItems.length, equals(2));
        expect(pendingItems.any((item) => item.id == 'item-1'), isTrue);
        expect(pendingItems.any((item) => item.id == 'item-2'), isTrue);
        expect(pendingItems.any((item) => item.id == 'item-3'), isFalse);
      });
    });

    group('getAllItems', () {
      test('should return all items sorted by priority', () {
        // Arrange
        final lowPriority = createTestSyncItem(
          id: 'item-1',
          priority: SyncPriority.low,
        );
        final highPriority = createTestSyncItem(
          id: 'item-2',
          priority: SyncPriority.high,
        );
        queue.add(lowPriority);
        queue.add(highPriority);

        // Act
        final allItems = queue.getAllItems();

        // Assert
        expect(allItems.length, equals(2));
        expect(allItems.first, equals(highPriority));
        expect(allItems.last, equals(lowPriority));
      });

      test('should return unmodifiable list', () {
        // Arrange
        queue.add(createTestSyncItem(id: 'item-1'));

        // Act
        final allItems = queue.getAllItems();

        // Assert
        expect(() => allItems.add(createTestSyncItem(id: 'item-2')),
            throwsA(isA<UnsupportedError>()));
      });
    });

    group('update', () {
      test('should update existing item', () {
        // Arrange
        final original = createTestSyncItem(
          id: 'item-1',
          retryCount: 0,
        );
        queue.add(original);

        // Act
        final updated = original.copyWith(
          retryCount: 1,
          error: 'Test error',
        );
        queue.update(updated);

        // Assert
        final found = queue.getById('item-1');
        expect(found?.retryCount, equals(1));
        expect(found?.error, equals('Test error'));
        expect(queue.size, equals(1));
      });

      test('should not update non-existent item', () {
        // Arrange
        final item = createTestSyncItem(id: 'item-1');

        // Act
        queue.update(item);

        // Assert
        expect(queue.size, equals(0));
        expect(queue.getById('item-1'), isNull);
      });

      test('should maintain priority order after update', () {
        // Arrange
        final item1 = createTestSyncItem(
          id: 'item-1',
          priority: SyncPriority.normal,
        );
        final item2 = createTestSyncItem(
          id: 'item-2',
          priority: SyncPriority.high,
        );
        queue.add(item1);
        queue.add(item2);

        // Act
        final updated = item1.copyWith(priority: SyncPriority.critical);
        queue.update(updated);

        // Assert
        expect(queue.items.first.id, equals('item-1'));
        expect(queue.items.last.id, equals('item-2'));
      });
    });

    group('isFull', () {
      test('should return false when queue is not full', () {
        // Arrange
        for (var i = 0; i < AppConstants.maxSyncQueueSize - 1; i++) {
          queue.add(createTestSyncItem(id: 'item-$i'));
        }

        // Act & Assert
        expect(queue.isFull, isFalse);
      });

      test('should return true when queue reaches max size', () {
        // Arrange
        for (var i = 0; i < AppConstants.maxSyncQueueSize; i++) {
          queue.add(createTestSyncItem(id: 'item-$i'));
        }

        // Act & Assert
        expect(queue.isFull, isTrue);
      });
    });

    group('priority ordering', () {
      test('should order by priority: critical > high > normal > low', () {
        // Arrange
        final normal = createTestSyncItem(
          id: 'normal',
          priority: SyncPriority.normal,
        );
        final critical = createTestSyncItem(
          id: 'critical',
          priority: SyncPriority.critical,
        );
        final low = createTestSyncItem(
          id: 'low',
          priority: SyncPriority.low,
        );
        final high = createTestSyncItem(
          id: 'high',
          priority: SyncPriority.high,
        );

        // Act
        queue.add(normal);
        queue.add(critical);
        queue.add(low);
        queue.add(high);

        // Assert
        expect(queue.items[0].id, equals('critical'));
        expect(queue.items[1].id, equals('high'));
        expect(queue.items[2].id, equals('normal'));
        expect(queue.items[3].id, equals('low'));
      });
    });
  });
}

/// Helper function to create test sync items.
SyncItem createTestSyncItem({
  String? id,
  SyncOperationType? operationType,
  String? entityType,
  String? entityId,
  Map<String, dynamic>? data,
  SyncPriority? priority,
  int? retryCount,
  int? maxRetries,
  DateTime? createdAt,
}) {
  return SyncItem(
    id: id ?? 'test-id',
    operationType: operationType ?? SyncOperationType.create,
    entityType: entityType ?? 'test_entity',
    entityId: entityId ?? 'test-entity-id',
    data: data ?? {'test': 'data'},
    priority: priority ?? SyncPriority.normal,
    retryCount: retryCount ?? 0,
    maxRetries: maxRetries ?? 3,
    createdAt: createdAt ?? DateTime.now(),
  );
}

