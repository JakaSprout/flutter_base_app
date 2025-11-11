/// Sync operation type.
enum SyncOperationType {
  /// Create operation
  create,

  /// Update operation
  update,

  /// Delete operation
  delete,
}

/// Sync item priority.
enum SyncPriority {
  /// Low priority
  low,

  /// Normal priority
  normal,

  /// High priority
  high,

  /// Critical priority
  critical,
}

/// Sync queue item model.
class SyncItem {
  /// Creates a new instance of [SyncItem].
  const SyncItem({
    required this.id,
    required this.operationType,
    required this.entityType,
    required this.entityId,
    required this.data,
    this.priority = SyncPriority.normal,
    this.retryCount = 0,
    this.maxRetries = 3,
    this.createdAt,
    this.updatedAt,
    this.error,
    this.metadata,
  });

  /// Unique identifier for sync item
  final String id;

  /// Type of sync operation
  final SyncOperationType operationType;

  /// Entity type (e.g., 'user', 'post', 'comment')
  final String entityType;

  /// Entity ID
  final String entityId;

  /// Data to sync (JSON serializable)
  final Map<String, dynamic> data;

  /// Priority of sync operation
  final SyncPriority priority;

  /// Number of retry attempts
  final int retryCount;

  /// Maximum number of retries
  final int maxRetries;

  /// When the sync item was created
  final DateTime? createdAt;

  /// When the sync item was last updated
  final DateTime? updatedAt;

  /// Error message if sync failed
  final String? error;

  /// Additional metadata
  final Map<String, dynamic>? metadata;

  /// Check if item can be retried.
  bool get canRetry => retryCount < maxRetries;

  /// Check if item has exceeded max retries.
  bool get hasExceededMaxRetries => retryCount >= maxRetries;

  /// Create a copy with updated fields.
  SyncItem copyWith({
    String? id,
    SyncOperationType? operationType,
    String? entityType,
    String? entityId,
    Map<String, dynamic>? data,
    SyncPriority? priority,
    int? retryCount,
    int? maxRetries,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? error,
    Map<String, dynamic>? metadata,
  }) {
    return SyncItem(
      id: id ?? this.id,
      operationType: operationType ?? this.operationType,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      data: data ?? this.data,
      priority: priority ?? this.priority,
      retryCount: retryCount ?? this.retryCount,
      maxRetries: maxRetries ?? this.maxRetries,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      error: error ?? this.error,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  String toString() =>
      'SyncItem('
      'id: $id, '
      'operationType: $operationType, '
      'entityType: $entityType, '
      'entityId: $entityId, '
      'retryCount: $retryCount/$maxRetries'
      ')';
}
