import 'package:dio/dio.dart';
import 'package:app_mobile_afms/core/config/app_config.dart';
import 'package:app_mobile_afms/core/di/providers/dio_provider.dart';
import 'package:app_mobile_afms/core/di/providers/secure_storage_provider.dart';
import 'package:app_mobile_afms/core/sync/models/sync_item.dart';
import 'package:app_mobile_afms/core/sync/providers/sync_queue_provider.dart';
import 'package:app_mobile_afms/core/sync/services/sync_queue.dart';
import 'package:app_mobile_afms/core/sync/services/sync_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mock_factories.dart';
import '../../../../helpers/test_helpers.dart';

class MockSyncService extends Mock implements SyncService {}

class MockSyncQueue extends Mock implements SyncQueue {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

class MockDio extends Mock implements Dio {}

void main() {
  group('SyncQueueProvider', () {
    late ProviderContainer container;
    late MockSyncService mockSyncService;
    late MockSyncQueue mockSyncQueue;
    late AppConfig testConfig;

    setUp(() {
      testConfig = TestHelpers.createTestConfig();
      mockSyncQueue = MockSyncQueue();
      mockSyncService = MockSyncService();

      // Setup default mock behavior
      when(() => mockSyncService.queue).thenReturn(mockSyncQueue);
      when(() => mockSyncQueue.items).thenReturn([]);
      when(() => mockSyncQueue.getFailedItems()).thenReturn([]);
      when(() => mockSyncQueue.getPendingItems()).thenReturn([]);

      container = TestHelpers.createContainer(
        appConfig: testConfig,
        overrides: [
          secureStorageProvider.overrideWithValue(MockFlutterSecureStorage()),
          dioProvider.overrideWithValue(MockDio()),
          syncServiceProvider.overrideWith((ref) => mockSyncService),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    group('syncQueueItemsProvider', () {
      test('should return empty list when queue is empty', () {
        // Arrange
        when(() => mockSyncQueue.items).thenReturn([]);

        // Act
        final items = container.read(syncQueueItemsProvider);

        // Assert
        expect(items, isEmpty);
        expect(items, isA<List<SyncItem>>());
        verify(() => mockSyncService.queue).called(1);
      });

      test('should return list of items from queue', () {
        // Arrange
        final item1 = createTestSyncItem(id: 'item-1');
        final item2 = createTestSyncItem(id: 'item-2');
        when(() => mockSyncQueue.items).thenReturn([item1, item2]);

        // Act
        final items = container.read(syncQueueItemsProvider);

        // Assert
        expect(items, hasLength(2));
        expect(items, contains(item1));
        expect(items, contains(item2));
        verify(() => mockSyncService.queue).called(1);
      });

      test('should update when queue items change', () {
        // Arrange
        final item1 = createTestSyncItem(id: 'item-1');
        when(() => mockSyncQueue.items).thenReturn([item1]);

        // Act - First read
        final initialItems = container.read(syncQueueItemsProvider);
        expect(initialItems, hasLength(1));

        // Arrange - Update queue and invalidate provider
        final item2 = createTestSyncItem(id: 'item-2');
        when(() => mockSyncQueue.items).thenReturn([item1, item2]);
        container.invalidate(syncQueueItemsProvider);

        // Act - Read again (should get new items)
        final updatedItems = container.read(syncQueueItemsProvider);

        // Assert
        expect(updatedItems, hasLength(2));
        expect(updatedItems, contains(item1));
        expect(updatedItems, contains(item2));
      });
    });

    group('syncQueueSizeProvider', () {
      test('should return 0 when queue is empty', () {
        // Arrange
        when(() => mockSyncQueue.items).thenReturn([]);

        // Act
        final size = container.read(syncQueueSizeProvider);

        // Assert
        expect(size, equals(0));
      });

      test('should return correct size when queue has items', () {
        // Arrange
        final items = List.generate(
          5,
          (index) => createTestSyncItem(id: 'item-$index'),
        );
        when(() => mockSyncQueue.items).thenReturn(items);

        // Act
        final size = container.read(syncQueueSizeProvider);

        // Assert
        expect(size, equals(5));
      });

      test('should update when queue size changes', () {
        // Arrange
        when(() => mockSyncQueue.items).thenReturn([]);

        // Act - First read
        final initialSize = container.read(syncQueueSizeProvider);
        expect(initialSize, equals(0));

        // Arrange - Add items and invalidate provider
        final items = List.generate(
          3,
          (index) => createTestSyncItem(id: 'item-$index'),
        );
        when(() => mockSyncQueue.items).thenReturn(items);
        container.invalidate(syncQueueItemsProvider);

        // Act - Read again
        final updatedSize = container.read(syncQueueSizeProvider);

        // Assert
        expect(updatedSize, equals(3));
      });
    });

    group('isSyncQueueEmptyProvider', () {
      test('should return true when queue is empty', () {
        // Arrange
        when(() => mockSyncQueue.items).thenReturn([]);

        // Act
        final isEmpty = container.read(isSyncQueueEmptyProvider);

        // Assert
        expect(isEmpty, isTrue);
      });

      test('should return false when queue has items', () {
        // Arrange
        final item = createTestSyncItem(id: 'item-1');
        when(() => mockSyncQueue.items).thenReturn([item]);

        // Act
        final isEmpty = container.read(isSyncQueueEmptyProvider);

        // Assert
        expect(isEmpty, isFalse);
      });

      test('should update when queue becomes empty', () {
        // Arrange
        final item = createTestSyncItem(id: 'item-1');
        when(() => mockSyncQueue.items).thenReturn([item]);

        // Act - First read
        final initialIsEmpty = container.read(isSyncQueueEmptyProvider);
        expect(initialIsEmpty, isFalse);

        // Arrange - Clear queue and invalidate provider
        when(() => mockSyncQueue.items).thenReturn([]);
        container.invalidate(syncQueueItemsProvider);

        // Act - Read again
        final updatedIsEmpty = container.read(isSyncQueueEmptyProvider);

        // Assert
        expect(updatedIsEmpty, isTrue);
      });
    });

    group('failedSyncItemsProvider', () {
      test('should return empty list when no failed items', () {
        // Arrange
        when(() => mockSyncQueue.getFailedItems()).thenReturn([]);

        // Act
        final failedItems = container.read(failedSyncItemsProvider);

        // Assert
        expect(failedItems, isEmpty);
        verify(() => mockSyncService.queue).called(1);
        verify(() => mockSyncQueue.getFailedItems()).called(1);
      });

      test('should return list of failed items', () {
        // Arrange
        final failedItem1 = createTestSyncItem(
          id: 'item-1',
          maxRetries: 3,
        ).copyWith(retryCount: 3);
        final failedItem2 = createTestSyncItem(
          id: 'item-2',
          maxRetries: 3,
        ).copyWith(retryCount: 3);
        when(
          () => mockSyncQueue.getFailedItems(),
        ).thenReturn([failedItem1, failedItem2]);

        // Act
        final failedItems = container.read(failedSyncItemsProvider);

        // Assert
        expect(failedItems, hasLength(2));
        expect(failedItems, contains(failedItem1));
        expect(failedItems, contains(failedItem2));
        verify(() => mockSyncService.queue).called(1);
        verify(() => mockSyncQueue.getFailedItems()).called(1);
      });

      test('should update when failed items change', () {
        // Arrange
        when(() => mockSyncQueue.getFailedItems()).thenReturn([]);

        // Act - First read
        final initialFailed = container.read(failedSyncItemsProvider);
        expect(initialFailed, isEmpty);

        // Arrange - Add failed items and invalidate provider
        final failedItem = createTestSyncItem(
          id: 'item-1',
          maxRetries: 3,
        ).copyWith(retryCount: 3);
        when(() => mockSyncQueue.getFailedItems()).thenReturn([failedItem]);
        container.invalidate(failedSyncItemsProvider);

        // Act - Read again
        final updatedFailed = container.read(failedSyncItemsProvider);

        // Assert
        expect(updatedFailed, hasLength(1));
        expect(updatedFailed, contains(failedItem));
      });
    });

    group('pendingSyncItemsProvider', () {
      test('should return empty list when no pending items', () {
        // Arrange
        when(() => mockSyncQueue.getPendingItems()).thenReturn([]);

        // Act
        final pendingItems = container.read(pendingSyncItemsProvider);

        // Assert
        expect(pendingItems, isEmpty);
        verify(() => mockSyncService.queue).called(1);
        verify(() => mockSyncQueue.getPendingItems()).called(1);
      });

      test('should return list of pending items', () {
        // Arrange
        final pendingItem1 = createTestSyncItem(
          id: 'item-1',
          maxRetries: 3,
        ).copyWith(retryCount: 1);
        final pendingItem2 = createTestSyncItem(
          id: 'item-2',
          maxRetries: 3,
        ).copyWith(retryCount: 2);
        when(
          () => mockSyncQueue.getPendingItems(),
        ).thenReturn([pendingItem1, pendingItem2]);

        // Act
        final pendingItems = container.read(pendingSyncItemsProvider);

        // Assert
        expect(pendingItems, hasLength(2));
        expect(pendingItems, contains(pendingItem1));
        expect(pendingItems, contains(pendingItem2));
        verify(() => mockSyncService.queue).called(1);
        verify(() => mockSyncQueue.getPendingItems()).called(1);
      });

      test('should update when pending items change', () {
        // Arrange
        when(() => mockSyncQueue.getPendingItems()).thenReturn([]);

        // Act - First read
        final initialPending = container.read(pendingSyncItemsProvider);
        expect(initialPending, isEmpty);

        // Arrange - Add pending items and invalidate provider
        final pendingItem = createTestSyncItem(
          id: 'item-1',
          maxRetries: 3,
        ).copyWith(retryCount: 1);
        when(() => mockSyncQueue.getPendingItems()).thenReturn([pendingItem]);
        container.invalidate(pendingSyncItemsProvider);

        // Act - Read again
        final updatedPending = container.read(pendingSyncItemsProvider);

        // Assert
        expect(updatedPending, hasLength(1));
        expect(updatedPending, contains(pendingItem));
      });
    });

    group('provider dependencies', () {
      test('syncQueueSizeProvider should depend on syncQueueItemsProvider', () {
        // Arrange
        final item = createTestSyncItem(id: 'item-1');
        when(() => mockSyncQueue.items).thenReturn([item]);

        // Act
        final size = container.read(syncQueueSizeProvider);
        final items = container.read(syncQueueItemsProvider);

        // Assert
        expect(size, equals(items.length));
        expect(size, equals(1));
      });

      test(
        'isSyncQueueEmptyProvider should depend on syncQueueSizeProvider',
        () {
          // Arrange
          when(() => mockSyncQueue.items).thenReturn([]);

          // Act
          final isEmpty = container.read(isSyncQueueEmptyProvider);
          final size = container.read(syncQueueSizeProvider);

          // Assert
          expect(isEmpty, equals(size == 0));
          expect(isEmpty, isTrue);
        },
      );
    });
  });
}
