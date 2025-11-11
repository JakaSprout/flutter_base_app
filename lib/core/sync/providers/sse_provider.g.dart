// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sse_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sseServiceHash() => r'd1781b9f185fe35e965db1d76fdf73ef04b7edca';

/// Provider for SSE service.
///
/// This provider provides access to the SSE service for real-time updates.
/// The service is automatically disposed when the provider is disposed.
///
/// Copied from [sseService].
@ProviderFor(sseService)
final sseServiceProvider = AutoDisposeProvider<SSEService>.internal(
  sseService,
  name: r'sseServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sseServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SseServiceRef = AutoDisposeProviderRef<SSEService>;
String _$sseConnectionStatusHash() =>
    r'b346c765e987944978b48057171bb081ba0655f3';

/// Provider for SSE connection status.
///
/// This provider provides a stream of SSE connection status changes.
///
/// Copied from [sseConnectionStatus].
@ProviderFor(sseConnectionStatus)
final sseConnectionStatusProvider =
    AutoDisposeStreamProvider<SSEConnectionStatus>.internal(
      sseConnectionStatus,
      name: r'sseConnectionStatusProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sseConnectionStatusHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SseConnectionStatusRef =
    AutoDisposeStreamProviderRef<SSEConnectionStatus>;
String _$sseEventsHash() => r'9ac1fdc3e63b94ab3b0398053b4e9b142068615d';

/// Provider for SSE events.
///
/// This provider provides a stream of SSE events from the server.
///
/// Copied from [sseEvents].
@ProviderFor(sseEvents)
final sseEventsProvider = AutoDisposeStreamProvider<SSEEvent>.internal(
  sseEvents,
  name: r'sseEventsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sseEventsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SseEventsRef = AutoDisposeStreamProviderRef<SSEEvent>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
