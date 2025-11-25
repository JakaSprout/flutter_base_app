import 'dart:async';

import 'package:app_mobile_afms/core/connectivity/connectivity_models.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:connectivity_plus/connectivity_plus.dart' as connectivity_plus;

/// Service for monitoring network connectivity.
class ConnectivityService {
  /// Creates a new instance of [ConnectivityService].
  ConnectivityService({connectivity_plus.Connectivity? connectivity})
    : _connectivity = connectivity ?? connectivity_plus.Connectivity() {
    _init();
  }

  final connectivity_plus.Connectivity _connectivity;

  /// Stream controller for connectivity status.
  final _statusController = StreamController<AppConnectivityResult>.broadcast();

  /// Stream of connectivity status changes.
  Stream<AppConnectivityResult> get onStatusChanged => _statusController.stream;

  /// Current connectivity status.
  AppConnectivityResult? _currentStatus;

  /// Get current connectivity status.
  AppConnectivityResult? get currentStatus => _currentStatus;

  /// Flag to track if service has been disposed.
  bool _isDisposed = false;

  /// Initialize connectivity monitoring.
  void _init() {
    // Listen to connectivity changes
    _connectivity.onConnectivityChanged.listen(
      _handleConnectivityChange,
      onError: (Object error, StackTrace stackTrace) {
        AppLogger.error('Connectivity stream error', error, stackTrace);
      },
    );

    // Get initial status
    checkConnectivity();
  }

  /// Handle connectivity change.
  Future<void> _handleConnectivityChange(
    List<connectivity_plus.ConnectivityResult> results,
  ) async {
    if (_isDisposed) {
      return; // Don't process changes if disposed
    }

    final result = await _mapConnectivityResult(results);
    _updateStatus(result);
  }

  /// Check current connectivity status.
  Future<AppConnectivityResult> checkConnectivity() async {
    if (_isDisposed) {
      AppLogger.debug('ConnectivityService already disposed, returning unknown status');
      return const AppConnectivityResult(
        status: ConnectivityStatus.unknown,
        message: 'Service disposed',
      );
    }

    try {
      final results = await _connectivity.checkConnectivity();
      final result = await _mapConnectivityResult(results);
      _updateStatus(result);
      return result;
    } catch (e) {
      AppLogger.error('Error checking connectivity', e);
      const errorResult = AppConnectivityResult(
        status: ConnectivityStatus.unknown,
        message: 'Error checking connectivity',
      );
      _updateStatus(errorResult);
      return errorResult;
    }
  }

  /// Map ConnectivityResult to our AppConnectivityResult model.
  Future<AppConnectivityResult> _mapConnectivityResult(
    List<connectivity_plus.ConnectivityResult> results,
  ) async {
    if (results.isEmpty) {
      return const AppConnectivityResult(
        status: ConnectivityStatus.disconnected,
      );
    }

    // Check if any result indicates connection
    final hasConnection = results.any(
      (result) => result != connectivity_plus.ConnectivityResult.none,
    );

    if (!hasConnection) {
      return const AppConnectivityResult(
        status: ConnectivityStatus.disconnected,
      );
    }

    // Get the first active connection type
    final activeResult = results.firstWhere(
      (result) => result != connectivity_plus.ConnectivityResult.none,
      orElse: () => connectivity_plus.ConnectivityResult.none,
    );

    return AppConnectivityResult(
      status: ConnectivityStatus.connected,
      type: activeResult.toString().split('.').last,
    );
  }

  /// Update connectivity status and notify listeners.
  void _updateStatus(AppConnectivityResult result) {
    if (_currentStatus?.status != result.status) {
      _currentStatus = result;
      AppLogger.info('Connectivity status changed: ${result.status}');

      // Check if controller is still open before adding events
      if (!_statusController.isClosed) {
        try {
          _statusController.add(result);
        } catch (e) {
          // Controller might be closed, ignore the error
          AppLogger.debug('Failed to add connectivity status to closed stream: $e');
        }
      }
    }
  }

  /// Dispose resources.
  void dispose() {
    if (_isDisposed) {
      return; // Already disposed
    }

    _isDisposed = true;
    AppLogger.debug('Disposing ConnectivityService');
    _statusController.close();
  }
}
