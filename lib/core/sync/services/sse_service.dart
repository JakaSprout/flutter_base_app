import 'dart:async';
import 'dart:convert';

import 'package:eventsource/eventsource.dart';
import 'package:app_mobile_afms/core/config/api_constants.dart';
import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/core/logging/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Server-Sent Events (SSE) event model.
class SSEEvent {
  /// Creates a new instance of [SSEEvent].
  const SSEEvent({
    required this.event,
    required this.data,
    this.id,
    this.retry,
  });

  /// Event type (e.g., 'create', 'update', 'delete').
  final String? event;

  /// Event data (JSON string).
  final String data;

  /// Event ID.
  final String? id;

  /// Retry interval in milliseconds.
  final int? retry;

  /// Parse event data as JSON.
  Map<String, dynamic> get dataAsJson {
    try {
      return jsonDecode(data) as Map<String, dynamic>;
    } catch (e) {
      AppLogger.warning('Failed to parse SSE event data as JSON: $e');
      return <String, dynamic>{};
    }
  }
}

/// SSE connection status.
enum SSEConnectionStatus {
  /// Not connected
  disconnected,

  /// Connecting
  connecting,

  /// Connected
  connected,

  /// Reconnecting
  reconnecting,

  /// Error
  error,
}

/// Server-Sent Events (SSE) service for real-time updates.
///
/// Uses the `eventsource` package for SSE connection management.
class SSEService {
  /// Creates a new instance of [SSEService].
  SSEService({
    required FlutterSecureStorage secureStorage,
    required String baseUrl,
    this.reconnectDelay = const Duration(
      seconds: AppConstants.sseReconnectDelaySeconds,
    ),
    this.maxReconnectAttempts = AppConstants.sseMaxReconnectAttempts,
  }) : _secureStorage = secureStorage,
       _baseUrl = baseUrl;

  final FlutterSecureStorage _secureStorage;
  final String _baseUrl;
  final Duration reconnectDelay;
  final int maxReconnectAttempts;

  /// Stream controller for SSE events.
  final _eventController = StreamController<SSEEvent>.broadcast();

  /// Stream controller for connection status.
  final _statusController = StreamController<SSEConnectionStatus>.broadcast();

  /// Stream of SSE events.
  Stream<SSEEvent> get onEvent => _eventController.stream;

  /// Stream of connection status changes.
  Stream<SSEConnectionStatus> get onStatusChanged => _statusController.stream;

  /// Current connection status.
  SSEConnectionStatus _status = SSEConnectionStatus.disconnected;

  /// Get current connection status.
  SSEConnectionStatus get status => _status;

  /// EventSource instance.
  EventSource? _eventSource;

  /// Stream subscription for EventSource.
  StreamSubscription<Event>? _subscription;

  /// Reconnect attempt count.
  int _reconnectAttempts = 0;

  /// Reconnect timer.
  Timer? _reconnectTimer;

  /// Whether service is disposed.
  bool _isDisposed = false;

  /// Connect to SSE endpoint.
  Future<void> connect() async {
    if (_isDisposed) {
      AppLogger.warning('SSE Service is disposed, cannot connect');
      return;
    }

    if (_status == SSEConnectionStatus.connected ||
        _status == SSEConnectionStatus.connecting) {
      AppLogger.info('SSE already connected or connecting');
      return;
    }

    _updateStatus(SSEConnectionStatus.connecting);
    _reconnectAttempts = 0;

    await _establishConnection();
  }

  /// Establish SSE connection using eventsource package.
  Future<void> _establishConnection() async {
    try {
      // Get auth token
      final token = await _secureStorage.read(
        key: AppConstants.storageAuthToken,
      );

      if (token == null || token.isEmpty) {
        AppLogger.warning('No auth token available for SSE connection');
        _updateStatus(SSEConnectionStatus.error);
        return;
      }

      final url = Uri.parse('$_baseUrl${ApiConstants.syncEvents}');
      AppLogger.info('Connecting to SSE endpoint: $url');

      // Create headers with authentication
      final headers = <String, String>{
        'Authorization': 'Bearer $token',
        'Accept': 'text/event-stream',
        'Cache-Control': 'no-cache',
        'Connection': 'keep-alive',
      };

      // Connect using eventsource package
      _eventSource = await EventSource.connect(
        url.toString(),
        headers: headers,
      );

      _updateStatus(SSEConnectionStatus.connected);
      _reconnectAttempts = 0;

      // Listen to events
      _subscription = _eventSource!.listen(
        (event) {
          // Convert EventSource Event to SSEEvent
          final sseEvent = SSEEvent(
            event: event.event ?? 'message', // Default to 'message' if null
            data: event.data ?? '', // Ensure data is not null
            id: event.id ?? '',
          );

          _eventController.add(sseEvent);
          AppLogger.debug('Received SSE event: ${sseEvent.event}');
        },
        onError: (Object error, StackTrace stackTrace) {
          AppLogger.error('SSE stream error', error, stackTrace);
          _updateStatus(SSEConnectionStatus.error);
          _scheduleReconnect();
        },
        onDone: () {
          AppLogger.info('SSE stream closed');
          if (!_isDisposed) {
            _scheduleReconnect();
          }
        },
        cancelOnError: false,
      );
    } catch (e, stackTrace) {
      AppLogger.error('SSE connection error', e, stackTrace);
      _updateStatus(SSEConnectionStatus.error);
      _scheduleReconnect();
    }
  }

  /// Schedule reconnection with exponential backoff.
  void _scheduleReconnect() {
    if (_isDisposed) return;

    _reconnectTimer?.cancel();

    if (_reconnectAttempts >= maxReconnectAttempts) {
      AppLogger.error('Max reconnect attempts reached: $maxReconnectAttempts');
      _updateStatus(SSEConnectionStatus.error);
      return;
    }

    _reconnectAttempts++;
    _updateStatus(SSEConnectionStatus.reconnecting);

    // Exponential backoff: delay * 2^(attempts - 1)
    final delay = Duration(
      milliseconds:
          (reconnectDelay.inMilliseconds * (1 << (_reconnectAttempts - 1)))
              .clamp(0, reconnectDelay.inMilliseconds * 60), // Max 60x delay
    );

    AppLogger.info(
      'Scheduling SSE reconnect attempt $_reconnectAttempts/$maxReconnectAttempts '
      'in ${delay.inSeconds}s',
    );

    _reconnectTimer = Timer(delay, () {
      if (!_isDisposed) {
        _establishConnection();
      }
    });
  }

  /// Update connection status.
  void _updateStatus(SSEConnectionStatus newStatus) {
    if (_status != newStatus) {
      _status = newStatus;
      _statusController.add(newStatus);
      AppLogger.debug('SSE status changed: $newStatus');
    }
  }

  /// Disconnect from SSE endpoint.
  Future<void> disconnect() async {
    AppLogger.info('Disconnecting SSE service');
    _reconnectTimer?.cancel();
    await _subscription?.cancel();
    _eventSource = null;
    _subscription = null;
    _updateStatus(SSEConnectionStatus.disconnected);
    _reconnectAttempts = 0;
  }

  /// Dispose resources.
  Future<void> dispose() async {
    _isDisposed = true;
    await disconnect();
    await _eventController.close();
    await _statusController.close();
  }
}
