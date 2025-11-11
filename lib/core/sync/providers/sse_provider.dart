import 'package:flutter_base_app/core/di/providers/dio_provider.dart';
import 'package:flutter_base_app/core/di/providers/secure_storage_provider.dart';
import 'package:flutter_base_app/core/sync/services/sse_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sse_provider.g.dart';

/// Provider for SSE service.
///
/// This provider provides access to the SSE service for real-time updates.
/// The service is automatically disposed when the provider is disposed.
@riverpod
SSEService sseService(SseServiceRef ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  final config = ref.watch(appConfigProvider);

  final service = SSEService(
    secureStorage: secureStorage,
    baseUrl: config.apiBaseUrl,
  );

  ref.onDispose(service.dispose);

  return service;
}

/// Provider for SSE connection status.
///
/// This provider provides a stream of SSE connection status changes.
@riverpod
Stream<SSEConnectionStatus> sseConnectionStatus(SseConnectionStatusRef ref) {
  final sseService = ref.watch(sseServiceProvider);
  return sseService.onStatusChanged;
}

/// Provider for SSE events.
///
/// This provider provides a stream of SSE events from the server.
@riverpod
Stream<SSEEvent> sseEvents(SseEventsRef ref) {
  final sseService = ref.watch(sseServiceProvider);
  return sseService.onEvent;
}
