/// Sync status enum.
enum SyncStatus {
  /// Sync is idle (no sync in progress)
  idle,

  /// Sync is in progress
  syncing,

  /// Sync completed successfully
  success,

  /// Sync failed
  failed,

  /// Sync is paused
  paused,
}

/// Sync status model.
class SyncStatusModel {
  /// Creates a new instance of [SyncStatusModel].
  const SyncStatusModel({
    required this.status,
    this.progress,
    this.totalItems,
    this.syncedItems,
    this.failedItems,
    this.message,
    this.lastSyncTime,
    this.error,
  });

  /// Current sync status
  final SyncStatus status;

  /// Sync progress (0.0 to 1.0)
  final double? progress;

  /// Total items to sync
  final int? totalItems;

  /// Number of items synced successfully
  final int? syncedItems;

  /// Number of items that failed to sync
  final int? failedItems;

  /// Status message
  final String? message;

  /// Last sync time
  final DateTime? lastSyncTime;

  /// Error message if sync failed
  final String? error;

  /// Check if sync is in progress.
  bool get isSyncing => status == SyncStatus.syncing;

  /// Check if sync is idle.
  bool get isIdle => status == SyncStatus.idle;

  /// Check if sync completed successfully.
  bool get isSuccess => status == SyncStatus.success;

  /// Check if sync failed.
  bool get isFailed => status == SyncStatus.failed;

  /// Check if sync is paused.
  bool get isPaused => status == SyncStatus.paused;

  /// Create a copy with updated fields.
  SyncStatusModel copyWith({
    SyncStatus? status,
    double? progress,
    int? totalItems,
    int? syncedItems,
    int? failedItems,
    String? message,
    DateTime? lastSyncTime,
    String? error,
  }) {
    return SyncStatusModel(
      status: status ?? this.status,
      progress: progress ?? this.progress,
      totalItems: totalItems ?? this.totalItems,
      syncedItems: syncedItems ?? this.syncedItems,
      failedItems: failedItems ?? this.failedItems,
      message: message ?? this.message,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
      error: error ?? this.error,
    );
  }

  @override
  String toString() =>
      'SyncStatusModel('
      'status: $status, '
      'progress: $progress, '
      'totalItems: $totalItems, '
      'syncedItems: $syncedItems, '
      'failedItems: $failedItems'
      ')';
}
