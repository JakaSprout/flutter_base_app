// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_timeout_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sessionTimeoutMonitorHash() =>
    r'6749fddb64bedd6ae6b1bb503b05bb8a7802e6f3';

/// Provider for session timeout monitoring.
///
/// This provider monitors session expiration and automatically
/// logs out users when session expires.
///
/// Copied from [SessionTimeoutMonitor].
@ProviderFor(SessionTimeoutMonitor)
final sessionTimeoutMonitorProvider =
    AutoDisposeAsyncNotifierProvider<SessionTimeoutMonitor, void>.internal(
      SessionTimeoutMonitor.new,
      name: r'sessionTimeoutMonitorProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sessionTimeoutMonitorHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SessionTimeoutMonitor = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
