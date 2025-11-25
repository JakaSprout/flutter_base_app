// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'harvest_simulation_sync_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$harvestSimulationSyncServiceHash() =>
    r'2562a6a81dae927ab36224119425830ad16bf567';

/// Provider for harvest simulation sync service.
///
/// Copied from [harvestSimulationSyncService].
@ProviderFor(harvestSimulationSyncService)
final harvestSimulationSyncServiceProvider =
    Provider<HarvestSimulationSyncService>.internal(
      harvestSimulationSyncService,
      name: r'harvestSimulationSyncServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$harvestSimulationSyncServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HarvestSimulationSyncServiceRef =
    ProviderRef<HarvestSimulationSyncService>;
String _$harvestSimulationSyncHash() =>
    r'dd7b071bd44b14b43160419569ba75b8a85ac119';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider for harvest simulation sync operation.
///
/// This provider triggers sync when watched and returns the sync result.
/// Use this to sync harvest simulations when needed.
///
/// Copied from [harvestSimulationSync].
@ProviderFor(harvestSimulationSync)
const harvestSimulationSyncProvider = HarvestSimulationSyncFamily();

/// Provider for harvest simulation sync operation.
///
/// This provider triggers sync when watched and returns the sync result.
/// Use this to sync harvest simulations when needed.
///
/// Copied from [harvestSimulationSync].
class HarvestSimulationSyncFamily
    extends Family<AsyncValue<HarvestSimulationSyncResult>> {
  /// Provider for harvest simulation sync operation.
  ///
  /// This provider triggers sync when watched and returns the sync result.
  /// Use this to sync harvest simulations when needed.
  ///
  /// Copied from [harvestSimulationSync].
  const HarvestSimulationSyncFamily();

  /// Provider for harvest simulation sync operation.
  ///
  /// This provider triggers sync when watched and returns the sync result.
  /// Use this to sync harvest simulations when needed.
  ///
  /// Copied from [harvestSimulationSync].
  HarvestSimulationSyncProvider call({required String employeeId}) {
    return HarvestSimulationSyncProvider(employeeId: employeeId);
  }

  @override
  HarvestSimulationSyncProvider getProviderOverride(
    covariant HarvestSimulationSyncProvider provider,
  ) {
    return call(employeeId: provider.employeeId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'harvestSimulationSyncProvider';
}

/// Provider for harvest simulation sync operation.
///
/// This provider triggers sync when watched and returns the sync result.
/// Use this to sync harvest simulations when needed.
///
/// Copied from [harvestSimulationSync].
class HarvestSimulationSyncProvider
    extends AutoDisposeFutureProvider<HarvestSimulationSyncResult> {
  /// Provider for harvest simulation sync operation.
  ///
  /// This provider triggers sync when watched and returns the sync result.
  /// Use this to sync harvest simulations when needed.
  ///
  /// Copied from [harvestSimulationSync].
  HarvestSimulationSyncProvider({required String employeeId})
    : this._internal(
        (ref) => harvestSimulationSync(
          ref as HarvestSimulationSyncRef,
          employeeId: employeeId,
        ),
        from: harvestSimulationSyncProvider,
        name: r'harvestSimulationSyncProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$harvestSimulationSyncHash,
        dependencies: HarvestSimulationSyncFamily._dependencies,
        allTransitiveDependencies:
            HarvestSimulationSyncFamily._allTransitiveDependencies,
        employeeId: employeeId,
      );

  HarvestSimulationSyncProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.employeeId,
  }) : super.internal();

  final String employeeId;

  @override
  Override overrideWith(
    FutureOr<HarvestSimulationSyncResult> Function(
      HarvestSimulationSyncRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HarvestSimulationSyncProvider._internal(
        (ref) => create(ref as HarvestSimulationSyncRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        employeeId: employeeId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<HarvestSimulationSyncResult>
  createElement() {
    return _HarvestSimulationSyncProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HarvestSimulationSyncProvider &&
        other.employeeId == employeeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, employeeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HarvestSimulationSyncRef
    on AutoDisposeFutureProviderRef<HarvestSimulationSyncResult> {
  /// The parameter `employeeId` of this provider.
  String get employeeId;
}

class _HarvestSimulationSyncProviderElement
    extends AutoDisposeFutureProviderElement<HarvestSimulationSyncResult>
    with HarvestSimulationSyncRef {
  _HarvestSimulationSyncProviderElement(super.provider);

  @override
  String get employeeId => (origin as HarvestSimulationSyncProvider).employeeId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
