import 'dart:async';

import 'package:flutter_base_app/core/config/app_config.dart';
import 'package:flutter_base_app/core/di/providers/connectivity_provider.dart';
import 'package:flutter_base_app/core/di/providers/dio_provider.dart';
import 'package:flutter_base_app/core/logging/logger.dart';
import 'package:flutter_base_app/core/sync/models/sync_item.dart';
import 'package:flutter_base_app/core/sync/models/sync_status.dart';
import 'package:flutter_base_app/core/sync/services/batch_sync_service.dart';
import 'package:flutter_base_app/core/sync/services/sse_service.dart';
import 'package:flutter_base_app/core/sync/services/sync_queue.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

/// Main sync service for offline-first architecture.
class SyncService {
  /// Creates a new instance of [SyncService].
  SyncService({
    required Ref ref,
    required AppConfig config,
    required FlutterSecureStorage secureStorage,
    SyncQueue? queue,
  }) : _ref = ref,
       _config = config,
       _secureStorage = secureStorage,
       _queue = queue ?? SyncQueue() {
    _init();
  }

  final Ref _ref;
  final AppConfig _config;
  final FlutterSecureStorage _secureStorage;
  final SyncQueue _queue;
  late final BatchSyncService _batchSyncService;
  late final SSEService _sseService;
  final _uuid = const Uuid();

  /// Stream controller for sync status changes.
  final _statusController = StreamController<SyncStatusModel>.broadcast();

  /// Stream of sync status changes.
  Stream<SyncStatusModel> get onStatusChanged => _statusController.stream;

  /// Current sync status.
  SyncStatusModel _currentStatus = const SyncStatusModel(
    status: SyncStatus.idle,
  );

  /// Get current sync status.
  SyncStatusModel get currentStatus => _currentStatus;

  /// Get sync queue.
  SyncQueue get queue => _queue;

  /// Initialize sync service.
  void _init() {
    // Initialize batch sync service
    final dio = _ref.read(dioProvider);
    _batchSyncService = BatchSyncService(dio: dio, baseUrl: _config.apiBaseUrl);

    // Initialize SSE service
    _sseService = SSEService(
      secureStorage: _secureStorage,
      baseUrl: _config.apiBaseUrl,
    );
    _setupSSEListener();

    // Listen to connectivity changes
    _ref.read(connectivityStatusProvider).whenData((status) {
      if (status.isConnected) {
        AppLogger.info('Connectivity restored, triggering sync');
        sync();
        _sseService.connect();
      } else {
        _sseService.disconnect();
      }
    });
  }

  /// Setup SSE event listener.
  void _setupSSEListener() {
    _sseService.onEvent.listen((event) {
      AppLogger.info('Received SSE event: ${event.event}');

      try {
        final data = event.dataAsJson;

        // Handle batch sync completion event
        if (event.event == 'batch_sync_complete' ||
            event.event == 'sync_complete') {
          final batchId = data['batchId'] as String?;
          final results = data['results'] as List<dynamic>?;

          if (results != null) {
            AppLogger.info(
              'Batch sync completed: batchId=$batchId, '
              'items=${results.length}',
            );

            final batchResults = results
                .map(
                  (r) => BatchSyncItemResult(
                    id: r['id'] as String,
                    success: r['success'] as bool? ?? false,
                    entityId: r['entityId'] as String?,
                    error: r['error'] as String?,
                  ),
                )
                .toList();

            _processBatchResults(batchResults);
          }
        } else {
          // Handle other SSE events (create, update, delete)
          // TODO(team): Process SSE events and update local database
          // This should be handled by feature-specific handlers
          AppLogger.debug('Processing SSE event: ${event.event}');
        }
      } catch (e, stackTrace) {
        AppLogger.error('Error processing SSE event', e, stackTrace);
      }
    });

    _sseService.onStatusChanged.listen((status) {
      AppLogger.debug('SSE connection status: $status');
    });
  }

  /// Add item to sync queue.
  String addToQueue({
    required SyncOperationType operationType,
    required String entityType,
    required String entityId,
    required Map<String, dynamic> data,
    SyncPriority priority = SyncPriority.normal,
    int maxRetries = 3,
    Map<String, dynamic>? metadata,
  }) {
    if (_queue.isFull) {
      AppLogger.warning('Sync queue is full, cannot add new item');
      throw Exception('Sync queue is full');
    }

    final id = _uuid.v4();
    final item = SyncItem(
      id: id,
      operationType: operationType,
      entityType: entityType,
      entityId: entityId,
      data: data,
      priority: priority,
      maxRetries: maxRetries,
      createdAt: DateTime.now(),
      metadata: metadata,
    );

    _queue.add(item);
    AppLogger.info('Added item to sync queue: $id');

    // Trigger sync if online
    final isConnected = _ref.read(isConnectedProvider);
    if (isConnected) {
      sync();
    }

    return id;
  }

  /// Remove item from sync queue.
  void removeFromQueue(String id) {
    _queue.remove(id);
    AppLogger.info('Removed item from sync queue: $id');
  }

  /// Execute sync operation using batch sync.
  Future<void> sync() async {
    if (_currentStatus.isSyncing) {
      AppLogger.warning('Sync already in progress');
      return;
    }

    final isConnected = _ref.read(isConnectedProvider);
    if (!isConnected) {
      AppLogger.warning('Cannot sync: device is offline');
      _updateStatus(
        _currentStatus.copyWith(
          status: SyncStatus.idle,
          message: 'Device is offline',
        ),
      );
      return;
    }

    if (_queue.isEmpty) {
      AppLogger.info('Sync queue is empty');
      _updateStatus(
        _currentStatus.copyWith(
          status: SyncStatus.idle,
          message: 'No items to sync',
        ),
      );
      return;
    }

    _updateStatus(
      _currentStatus.copyWith(
        status: SyncStatus.syncing,
        totalItems: _queue.size,
        syncedItems: 0,
        failedItems: 0,
        message: 'Syncing...',
      ),
    );

    // Get all pending items
    final pendingItems = _queue.getAllItems();
    if (pendingItems.isEmpty) {
      _updateStatus(
        _currentStatus.copyWith(
          status: SyncStatus.idle,
          message: 'No items to sync',
        ),
      );
      return;
    }

    try {
      // Send batch to backend (backend will queue and process)
      final response = await _batchSyncService.syncBatch(pendingItems);

      AppLogger.info(
        'Batch sync accepted by backend with ID: ${response.batchId}',
      );

      // Backend is processing the batch asynchronously
      // Results will be received via SSE events
      // For now, mark items as "syncing" (they will be removed when SSE confirms)
      _updateStatus(
        _currentStatus.copyWith(
          status: SyncStatus.syncing,
          message: 'Batch queued for processing (ID: ${response.batchId})',
        ),
      );

      // If backend returns immediate results (synchronous processing),
      // process them now
      if (response.results != null && response.results!.isNotEmpty) {
        _processBatchResults(response.results!);
      }
    } catch (e, stackTrace) {
      AppLogger.error('Batch sync error', e, stackTrace);
      _updateStatus(
        _currentStatus.copyWith(
          status: SyncStatus.failed,
          message: 'Sync failed: $e',
        ),
      );
    }
  }

  /// Process batch sync results from backend.
  ///
  /// This is called when backend sends batch completion via SSE or
  /// when immediate results are available.
  void _processBatchResults(List<BatchSyncItemResult> results) {
    var syncedCount = 0;
    var failedCount = 0;

    for (final result in results) {
      final item = _queue.getById(result.id);
      if (item == null) continue;

      if (result.success) {
        _queue.remove(result.id);
        syncedCount++;
        AppLogger.info('Successfully synced item: ${result.id}');
      } else {
        final updatedItem = item.copyWith(
          retryCount: item.retryCount + 1,
          updatedAt: DateTime.now(),
          error: result.error ?? 'Sync failed',
        );

        if (updatedItem.canRetry) {
          _queue.update(updatedItem);
          AppLogger.warning('Sync failed, will retry: ${result.id}');
        } else {
          _queue.remove(result.id);
          failedCount++;
          AppLogger.error('Sync failed, exceeded max retries: ${result.id}');
        }
      }
    }

    _updateStatus(
      _currentStatus.copyWith(
        status: failedCount > 0 ? SyncStatus.failed : SyncStatus.success,
        syncedItems: syncedCount,
        failedItems: failedCount,
        lastSyncTime: DateTime.now(),
        message: failedCount > 0
            ? 'Sync completed with $failedCount failures'
            : 'Sync completed successfully',
      ),
    );
  }

  /// Update sync status and notify listeners.
  void _updateStatus(SyncStatusModel status) {
    _currentStatus = status;
    _statusController.add(status);
  }

  /// Pause sync.
  void pause() {
    _updateStatus(
      _currentStatus.copyWith(
        status: SyncStatus.paused,
        message: 'Sync paused',
      ),
    );
    AppLogger.info('Sync paused');
  }

  /// Resume sync.
  void resume() {
    if (_currentStatus.isPaused) {
      sync();
    }
  }

  /// Clear sync queue.
  void clearQueue() {
    _queue.clear();
    _updateStatus(
      _currentStatus.copyWith(
        status: SyncStatus.idle,
        message: 'Sync queue cleared',
      ),
    );
    AppLogger.info('Sync queue cleared');
  }

  /// Dispose resources.
  Future<void> dispose() async {
    await _sseService.dispose();
    _statusController.close();
  }
}
