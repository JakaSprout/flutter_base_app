import 'package:flutter_base_app/core/sync/models/sync_item.dart';
import 'package:flutter_base_app/core/sync/services/sync_queue.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/mock_factories.dart';

void main() {
  group('SyncQueue', () {
    late SyncQueue queue;

    setUp(() {
      queue = SyncQueue();
    });

    tearDown(() {
      queue.clear();
    });

    group('add', () {
      test('should add item to queue', () {
        // Arrange
        final item = createTestSyncItem();

        // Act
        queue.add(item);

        // Assert
        expect(queue.size, equals(1));
        expect(queue.getById(item.id), equals(item));
      });

      test('should indicate when queue is full', () {
        // Arrange
        // Note: SyncQueue uses AppConstants.maxSyncQueueSize (100)
        // Fill queue to max size
        for (var i = 0; i < 100; i++) {
          queue.add(createTestSyncItem(id: 'item-$i'));
        }

        // Assert
        expect(queue.isFull, isTrue);
        expect(queue.size, equals(100));
      });

      test('should prioritize high priority items', () {
        // Arrange
        final normalItem = createTestSyncItem(
          id: 'normal',
          priority: SyncPriority.normal,
        );
        final highItem = createTestSyncItem(
          id: 'high',
          priority: SyncPriority.high,
        );

        // Act
        queue
          ..add(normalItem)
          ..add(highItem);

        // Assert
        final items = queue.getAllItems();
        expect(items.first.id, equals('high'));
      });
    });

    group('remove', () {
      test('should remove item from queue', () {
        // Arrange
        final item = createTestSyncItem();
        queue.add(item);

        // Act
        queue.remove(item.id);

        // Assert
        expect(queue.size, equals(0));
        expect(queue.getById(item.id), isNull);
      });

      test('should not throw when removing non-existent item', () {
        // Act & Assert
        expect(() => queue.remove('non-existent'), returnsNormally);
      });
    });

    group('getById', () {
      test('should return item by id', () {
        // Arrange
        final item = createTestSyncItem(id: 'test-id');
        queue.add(item);

        // Act
        final result = queue.getById('test-id');

        // Assert
        expect(result, equals(item));
      });

      test('should return null for non-existent item', () {
        // Act
        final result = queue.getById('non-existent');

        // Assert
        expect(result, isNull);
      });
    });

    group('getAllItems', () {
      test('should return all items in priority order', () {
        // Arrange
        final normalItem = createTestSyncItem(
          id: 'normal',
          priority: SyncPriority.normal,
        );
        final highItem = createTestSyncItem(
          id: 'high',
          priority: SyncPriority.high,
        );
        final lowItem = createTestSyncItem(
          id: 'low',
          priority: SyncPriority.low,
        );

        queue
          ..add(normalItem)
          ..add(highItem)
          ..add(lowItem);

        // Act
        final items = queue.getAllItems();

        // Assert
        expect(items.length, equals(3));
        expect(items[0].id, equals('high'));
        expect(items[1].id, equals('normal'));
        expect(items[2].id, equals('low'));
      });
    });

    group('clear', () {
      test('should clear all items from queue', () {
        // Arrange & Act
        queue
          ..add(createTestSyncItem(id: '1'))
          ..add(createTestSyncItem(id: '2'))
          ..clear();

        // Assert
        expect(queue.size, equals(0));
        expect(queue.isEmpty, isTrue);
      });
    });

    group('properties', () {
      test('isEmpty should return true when queue is empty', () {
        // Assert
        expect(queue.isEmpty, isTrue);
      });

      test('isEmpty should return false when queue has items', () {
        // Arrange
        queue.add(createTestSyncItem());

        // Assert
        expect(queue.isEmpty, isFalse);
      });

      test('isFull should return false when queue is not full', () {
        // Assert
        expect(queue.isFull, isFalse);
      });

      test('isFull should return true when queue is full', () {
        // Arrange
        // Fill queue to max size (100)
        for (var i = 0; i < 100; i++) {
          queue.add(createTestSyncItem(id: 'item-$i'));
        }

        // Assert
        expect(queue.isFull, isTrue);
      });
    });
  });
}
