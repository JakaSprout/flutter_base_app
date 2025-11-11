import 'dart:async';
import 'dart:math';

import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/core/logging/logger.dart';
import 'package:flutter_base_app/core/sync/models/sync_item.dart';

/// Sync operation callback type.
typedef SyncOperation = Future<void> Function(SyncItem item);

/// Sync executor with retry logic.
class SyncExecutor {
  /// Creates a new instance of [SyncExecutor].
  SyncExecutor({
    this.maxRetries = AppConstants.syncRetryAttempts,
    this.retryDelay = const Duration(
      milliseconds: AppConstants.syncRetryDelayMs,
    ),
  });

  /// Maximum number of retry attempts
  final int maxRetries;

  /// Base delay between retries
  final Duration retryDelay;

  /// Execute sync operation with retry logic.
  Future<bool> execute(SyncItem item, SyncOperation operation) async {
    var attempts = 0;

    while (attempts <= maxRetries) {
      try {
        AppLogger.info(
          'Executing sync operation: ${item.id} '
          '(attempt ${attempts + 1}/${maxRetries + 1})',
        );

        await operation(item);

        AppLogger.info('Sync operation succeeded: ${item.id}');
        return true;
      } catch (e, stackTrace) {
        attempts++;

        if (attempts > maxRetries) {
          AppLogger.error(
            'Sync operation failed after $maxRetries retries: ${item.id}',
            e,
            stackTrace,
          );
          return false;
        }

        // Exponential backoff
        final exponentialDelay = Duration(
          milliseconds: (retryDelay.inMilliseconds * pow(2, attempts - 1))
              .round(),
        );

        AppLogger.warning(
          'Sync operation failed, retrying in '
          '${exponentialDelay.inMilliseconds}ms: ${item.id}',
        );

        await Future<void>.delayed(exponentialDelay);
      }
    }

    return false;
  }

  /// Calculate retry delay with exponential backoff.
  Duration calculateRetryDelay(int attempt) {
    final exponentialDelay = Duration(
      milliseconds: (retryDelay.inMilliseconds * pow(2, attempt - 1)).round(),
    );
    return exponentialDelay;
  }
}
