import 'package:dio/dio.dart';
import 'package:app_mobile_afms/core/config/api_constants.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:app_mobile_afms/core/sync/models/sync_item.dart';

/// Batch sync result for individual item.
class BatchSyncItemResult {
  /// Creates a new instance of [BatchSyncItemResult].
  const BatchSyncItemResult({
    required this.id,
    required this.success,
    this.entityId,
    this.error,
  });

  /// Sync item ID.
  final String id;

  /// Whether sync was successful.
  final bool success;

  /// New entity ID (for create operations).
  final String? entityId;

  /// Error message if failed.
  final String? error;
}

/// Batch sync response.
class BatchSyncResponse {
  /// Creates a new instance of [BatchSyncResponse].
  const BatchSyncResponse({
    required this.batchId,
    required this.accepted,
    this.message,
    this.results,
  });

  /// Batch ID/Job ID from backend for tracking.
  final String batchId;

  /// Whether batch was accepted by backend (queued for processing).
  final bool accepted;

  /// Optional message.
  final String? message;

  /// Individual item results (only available if processing is synchronous
  /// or after polling/SSE notification).
  final List<BatchSyncItemResult>? results;

  /// Get successful items (if results available).
  List<BatchSyncItemResult> get successfulItems =>
      results?.where((r) => r.success).toList() ?? [];

  /// Get failed items (if results available).
  List<BatchSyncItemResult> get failedItems =>
      results?.where((r) => !r.success).toList() ?? [];
}

/// Batch sync service for efficient synchronization.
class BatchSyncService {
  /// Creates a new instance of [BatchSyncService].
  BatchSyncService({
    required Dio dio,
    required String baseUrl,
    this.batchSize = 50,
  }) : _dio = dio,
       _baseUrl = baseUrl;

  final Dio _dio;
  final String _baseUrl;
  final int batchSize;

  /// Sync batch of items grouped by module/entityType.
  ///
  /// Items are grouped by entityType and sent to module-specific endpoints.
  /// Backend will queue and process each batch asynchronously.
  /// Returns combined batchId for tracking.
  Future<BatchSyncResponse> syncBatch(List<SyncItem> items) async {
    if (items.isEmpty) {
      AppLogger.warning('Cannot sync empty batch');
      throw Exception('Cannot sync empty batch');
    }

    // Group items by entityType (module)
    final itemsByModule = <String, List<SyncItem>>{};
    for (final item in items) {
      itemsByModule.putIfAbsent(item.entityType, () => []).add(item);
    }

    AppLogger.info(
      'Syncing ${items.length} items across ${itemsByModule.length} module(s)',
    );

    // Send batches per module
    final batchIds = <String>[];

    for (final entry in itemsByModule.entries) {
      final module = entry.key;
      final moduleItems = entry.value;

      AppLogger.debug(
        'Processing module: $module (${moduleItems.length} items)',
      );

      // Split module items into batches if needed
      final batches = <List<SyncItem>>[];
      for (var i = 0; i < moduleItems.length; i += batchSize) {
        final end = (i + batchSize < moduleItems.length)
            ? i + batchSize
            : moduleItems.length;
        batches.add(moduleItems.sublist(i, end));
      }

      // Send each batch for this module
      for (var i = 0; i < batches.length; i++) {
        final batch = batches[i];
        AppLogger.debug(
          'Sending batch ${i + 1}/${batches.length} for module: $module',
        );

        try {
          final response = await _syncSingleBatch(batch, module);
          batchIds.add(response.batchId);
          AppLogger.info(
            'Module $module batch ${i + 1} accepted with ID: '
            '${response.batchId}',
          );
        } catch (e, stackTrace) {
          AppLogger.error(
            'Batch sync failed for module: $module',
            e,
            stackTrace,
          );
          rethrow;
        }
      }
    }

    // Return first batch ID (or combine if needed)
    // Backend will process and notify via SSE
    return BatchSyncResponse(
      batchId: batchIds.first,
      accepted: true,
      message:
          '${batchIds.length} batch(es) queued across '
          '${itemsByModule.length} module(s)',
    );
  }

  /// Sync single batch for a specific module.
  ///
  /// Backend will queue the batch and return batchId for tracking.
  /// Uses module-specific endpoint: /api/sync/{module}/batch
  Future<BatchSyncResponse> _syncSingleBatch(
    List<SyncItem> items,
    String module,
  ) async {
    // Prepare batch request payload
    final payload = {
      'items': items
          .map(
            (item) => {
              'id': item.id,
              'operation': _operationTypeToString(item.operationType),
              'entityType': item.entityType,
              'entityId': item.entityId,
              'data': item.data,
              if (item.metadata != null) 'metadata': item.metadata,
            },
          )
          .toList(),
    };

    try {
      // Use module-specific endpoint
      final endpoint = ApiConstants.syncBatch(module);
      final response = await _dio.post<Map<String, dynamic>>(
        '$_baseUrl$endpoint',
        data: payload,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode != 202 && response.statusCode != 200) {
        throw Exception(
          'Batch sync failed with status: ${response.statusCode}',
        );
      }

      final data = response.data!;

      // Backend returns batchId/jobId for async processing
      final batchId = data['batchId'] as String? ?? data['jobId'] as String?;
      if (batchId == null) {
        throw Exception('Backend did not return batchId/jobId');
      }

      // Optional: Backend might return immediate results if processing is fast
      List<BatchSyncItemResult>? results;
      if (data['results'] != null) {
        final resultsList = data['results'] as List<dynamic>;
        results = resultsList
            .map(
              (r) {
                final resultMap = r as Map<String, dynamic>;
                return BatchSyncItemResult(
                  id: resultMap['id'] as String,
                  success: resultMap['success'] as bool? ?? false,
                  entityId: resultMap['entityId'] as String?,
                  error: resultMap['error'] as String?,
                );
              },
            )
            .toList();
      }

      return BatchSyncResponse(
        batchId: batchId,
        accepted: data['accepted'] as bool? ?? true,
        message: data['message'] as String?,
        results: results,
      );
    } on DioException catch (e) {
      AppLogger.error('Batch sync DioException: ${e.message}', e, e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('Batch sync error', e, stackTrace);
      rethrow;
    }
  }

  /// Convert operation type to string.
  String _operationTypeToString(SyncOperationType type) {
    switch (type) {
      case SyncOperationType.create:
        return 'create';
      case SyncOperationType.update:
        return 'update';
      case SyncOperationType.delete:
        return 'delete';
    }
  }
}
