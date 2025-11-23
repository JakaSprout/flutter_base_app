// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registered_ponds_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$registeredPondOptionsHash() =>
    r'c6e127c6fa9508dd7abd346d40df10c99f5b12db';

/// Loads pond options from the reference data repository for the active user.
/// Optionally filters by selected farm ID from home screen.
///
/// Copied from [registeredPondOptions].
@ProviderFor(registeredPondOptions)
final registeredPondOptionsProvider =
    AutoDisposeFutureProvider<List<PondOption>>.internal(
      registeredPondOptions,
      name: r'registeredPondOptionsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$registeredPondOptionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RegisteredPondOptionsRef =
    AutoDisposeFutureProviderRef<List<PondOption>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
