import 'package:flutter_base_app/core/connectivity/connectivity_models.dart';
import 'package:flutter_base_app/core/connectivity/connectivity_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_provider.g.dart';

/// Provider for connectivity service.
///
/// This provider creates a singleton ConnectivityService instance that
/// monitors network connectivity changes. The service is automatically
/// disposed when the provider is disposed.
@riverpod
ConnectivityService connectivityService(ConnectivityServiceRef ref) {
  final service = ConnectivityService();
  ref.onDispose(service.dispose);
  return service;
}

/// Provider for current connectivity status stream.
///
/// This provider provides a stream of connectivity status changes.
/// Use this when you need to react to connectivity changes in real-time.
@riverpod
Stream<AppConnectivityResult> connectivityStatus(ConnectivityStatusRef ref) {
  final service = ref.watch(connectivityServiceProvider);
  return service.onStatusChanged;
}

/// Provider for current connectivity status (synchronous).
///
/// This provider provides the current connectivity status synchronously.
/// Use this when you need the current status without listening to changes.
@riverpod
AppConnectivityResult? connectivityStatusSync(ConnectivityStatusSyncRef ref) {
  final asyncStatus = ref.watch(connectivityStatusProvider);
  return asyncStatus.valueOrNull;
}

/// Provider to check if device is connected.
///
/// This provider provides a boolean indicating whether the device is
/// currently connected to the internet.
@riverpod
bool isConnected(IsConnectedRef ref) {
  final status = ref.watch(connectivityStatusSyncProvider);
  return status?.isConnected ?? false;
}
