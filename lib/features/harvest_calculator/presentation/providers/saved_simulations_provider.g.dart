// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_simulations_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$savedSimulationsHash() => r'24a3532051b5911c5b6c3f858b0f2207be7dd5bd';

/// State provider for managing saved harvest simulations.
///
/// Copied from [SavedSimulations].
@ProviderFor(SavedSimulations)
final savedSimulationsProvider =
    AutoDisposeAsyncNotifierProvider<
      SavedSimulations,
      List<HarvestSimulation>
    >.internal(
      SavedSimulations.new,
      name: r'savedSimulationsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$savedSimulationsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SavedSimulations = AutoDisposeAsyncNotifier<List<HarvestSimulation>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
