// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_simulations_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$savedSimulationsDataHash() =>
    r'29cb50ca2668eba9f3e5551c602faafeb676253d';

/// Provider that fetches saved simulations with API-first strategy.
/// Similar to farmListData in home page: API first when online, local DB fallback.
///
/// Copied from [savedSimulationsData].
@ProviderFor(savedSimulationsData)
final savedSimulationsDataProvider =
    AutoDisposeFutureProvider<List<HarvestSimulation>>.internal(
      savedSimulationsData,
      name: r'savedSimulationsDataProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$savedSimulationsDataHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SavedSimulationsDataRef =
    AutoDisposeFutureProviderRef<List<HarvestSimulation>>;
String _$savedSimulationsHash() => r'df3a0ae98f54949d68d9a04082a3290a025d6a7a';

/// State provider for managing saved harvest simulations.
/// Uses API-first strategy like home page when online.
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
