import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/core/logging/logger.dart';
import 'package:flutter_base_app/core/sync/models/sync_item.dart';

/// Queue manager for pending sync operations.
class SyncQueue {
  /// Creates a new instance of [SyncQueue].
  SyncQueue() : _items = [];

  final List<SyncItem> _items;
  final Map<String, SyncItem> _itemsById = {};

  /// Get all items in queue (sorted by priority).
  List<SyncItem> get items {
    _sortItems();
    return List<SyncItem>.unmodifiable(_items);
  }

  /// Get queue size.
  int get size => _items.length;

  /// Check if queue is empty.
  bool get isEmpty => _items.isEmpty;

  /// Check if queue is not empty.
  bool get isNotEmpty => _items.isNotEmpty;

  /// Add item to queue.
  void add(SyncItem item) {
    if (_itemsById.containsKey(item.id)) {
      AppLogger.warning('SyncItem with id ${item.id} already exists');
      return;
    }

    _items.add(item);
    _itemsById[item.id] = item;
    _sortItems();
    AppLogger.debug('Added sync item to queue: ${item.id}');
  }

  /// Remove item from queue.
  SyncItem? remove(String id) {
    final item = _itemsById.remove(id);
    if (item != null) {
      _items.remove(item);
      AppLogger.debug('Removed sync item from queue: $id');
    }
    return item;
  }

  /// Get item by ID.
  SyncItem? getById(String id) => _itemsById[id];

  /// Get next item to process (highest priority).
  SyncItem? peek() {
    if (_items.isEmpty) return null;
    _sortItems();
    return _items.first;
  }

  /// Remove and return next item to process.
  SyncItem? poll() {
    if (_items.isEmpty) return null;

    _sortItems();
    final item = _items.removeAt(0);
    _itemsById.remove(item.id);
    AppLogger.debug('Polled sync item from queue: ${item.id}');
    return item;
  }

  /// Clear all items from queue.
  void clear() {
    _items.clear();
    _itemsById.clear();
    AppLogger.info('Sync queue cleared');
  }

  /// Get items by entity type.
  List<SyncItem> getByEntityType(String entityType) {
    return _itemsById.values
        .where((item) => item.entityType == entityType)
        .toList();
  }

  /// Get items by operation type.
  List<SyncItem> getByOperationType(SyncOperationType operationType) {
    return _itemsById.values
        .where((item) => item.operationType == operationType)
        .toList();
  }

  /// Get failed items (exceeded max retries).
  List<SyncItem> getFailedItems() {
    return _itemsById.values
        .where((item) => item.hasExceededMaxRetries)
        .toList();
  }

  /// Get pending items (can be retried).
  List<SyncItem> getPendingItems() {
    return _itemsById.values.where((item) => item.canRetry).toList();
  }

  /// Get all items in queue (sorted by priority).
  List<SyncItem> getAllItems() {
    _sortItems();
    return List<SyncItem>.unmodifiable(_items);
  }

  /// Update item in queue.
  void update(SyncItem updatedItem) {
    final existingItem = _itemsById[updatedItem.id];
    if (existingItem == null) {
      AppLogger.warning('SyncItem with id ${updatedItem.id} not found');
      return;
    }

    final index = _items.indexOf(existingItem);
    if (index != -1) {
      _items[index] = updatedItem;
    }
    _itemsById[updatedItem.id] = updatedItem;
    _sortItems();
    AppLogger.debug('Updated sync item in queue: ${updatedItem.id}');
  }

  /// Check if queue has reached max size.
  bool get isFull => size >= AppConstants.maxSyncQueueSize;

  /// Sort items by priority.
  void _sortItems() {
    _items.sort(_comparePriority);
  }

  /// Compare priority for queue ordering.
  /// Higher priority items come first.
  static int _comparePriority(SyncItem a, SyncItem b) {
    final priorityOrder = {
      SyncPriority.critical: 4,
      SyncPriority.high: 3,
      SyncPriority.normal: 2,
      SyncPriority.low: 1,
    };

    final aPriority = priorityOrder[a.priority] ?? 2;
    final bPriority = priorityOrder[b.priority] ?? 2;

    // Higher priority first
    if (aPriority != bPriority) {
      return bPriority.compareTo(aPriority);
    }

    // If same priority, earlier created items first (FIFO)
    final aTime = a.createdAt ?? DateTime.now();
    final bTime = b.createdAt ?? DateTime.now();
    return aTime.compareTo(bTime);
  }
}
