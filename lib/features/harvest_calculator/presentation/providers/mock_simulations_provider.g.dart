// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mock_simulations_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mockSimulationsDataHash() =>
    r'9aff3706990a4f4a0273b068bb64ef1f186e5640';

/// Mock provider for testing simulation list screen with sample data.
/// Use this provider instead of savedSimulationsDataProvider for development/testing.
///
/// Copied from [mockSimulationsData].
@ProviderFor(mockSimulationsData)
final mockSimulationsDataProvider =
    AutoDisposeFutureProvider<List<HarvestSimulation>>.internal(
      mockSimulationsData,
      name: r'mockSimulationsDataProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$mockSimulationsDataHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MockSimulationsDataRef =
    AutoDisposeFutureProviderRef<List<HarvestSimulation>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
