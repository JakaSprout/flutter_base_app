// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lab_request_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$labRequestRemoteDataSourceHash() =>
    r'f30041bf88960fb128915d71f62ea6a3bfa9e582';

/// Provider for Lab Request remote data source.
///
/// Uses [AppConfig.useMockApi] to determine whether to use mock or real API.
///
/// Copied from [labRequestRemoteDataSource].
@ProviderFor(labRequestRemoteDataSource)
final labRequestRemoteDataSourceProvider =
    Provider<LabRequestRemoteDataSource>.internal(
      labRequestRemoteDataSource,
      name: r'labRequestRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$labRequestRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LabRequestRemoteDataSourceRef = ProviderRef<LabRequestRemoteDataSource>;
String _$labRequestRepositoryHash() =>
    r'fcd45427e7fd01680f9615d08d344c22c7295415';

/// Provider for Lab Request repository.
///
/// Copied from [labRequestRepository].
@ProviderFor(labRequestRepository)
final labRequestRepositoryProvider = Provider<LabRequestRepository>.internal(
  labRequestRepository,
  name: r'labRequestRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$labRequestRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LabRequestRepositoryRef = ProviderRef<LabRequestRepository>;
String _$createLabRequestHash() => r'32e39b6933eff879fc6ba3c0b9a8d50ac668394f';

/// Provider for CreateLabRequest use case.
///
/// Copied from [createLabRequest].
@ProviderFor(createLabRequest)
final createLabRequestProvider = Provider<CreateLabRequest>.internal(
  createLabRequest,
  name: r'createLabRequestProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$createLabRequestHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CreateLabRequestRef = ProviderRef<CreateLabRequest>;
String _$getLabRequestListHash() => r'd1d79ff2da64653764582e7eb737cdf83b66a3a9';

/// Provider for GetLabRequestList use case.
///
/// Copied from [getLabRequestList].
@ProviderFor(getLabRequestList)
final getLabRequestListProvider = Provider<GetLabRequestList>.internal(
  getLabRequestList,
  name: r'getLabRequestListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getLabRequestListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetLabRequestListRef = ProviderRef<GetLabRequestList>;
String _$submitLabRequestHash() => r'0fbc372d789aedb52ae7496e27ba8bde6fa2ce0f';

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

/// Provider for creating a lab request.
///
/// This is a family provider that takes a [LabRequest] as parameter.
///
/// Copied from [submitLabRequest].
@ProviderFor(submitLabRequest)
const submitLabRequestProvider = SubmitLabRequestFamily();

/// Provider for creating a lab request.
///
/// This is a family provider that takes a [LabRequest] as parameter.
///
/// Copied from [submitLabRequest].
class SubmitLabRequestFamily extends Family<AsyncValue<LabRequest>> {
  /// Provider for creating a lab request.
  ///
  /// This is a family provider that takes a [LabRequest] as parameter.
  ///
  /// Copied from [submitLabRequest].
  const SubmitLabRequestFamily();

  /// Provider for creating a lab request.
  ///
  /// This is a family provider that takes a [LabRequest] as parameter.
  ///
  /// Copied from [submitLabRequest].
  SubmitLabRequestProvider call(LabRequest request) {
    return SubmitLabRequestProvider(request);
  }

  @override
  SubmitLabRequestProvider getProviderOverride(
    covariant SubmitLabRequestProvider provider,
  ) {
    return call(provider.request);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'submitLabRequestProvider';
}

/// Provider for creating a lab request.
///
/// This is a family provider that takes a [LabRequest] as parameter.
///
/// Copied from [submitLabRequest].
class SubmitLabRequestProvider extends AutoDisposeFutureProvider<LabRequest> {
  /// Provider for creating a lab request.
  ///
  /// This is a family provider that takes a [LabRequest] as parameter.
  ///
  /// Copied from [submitLabRequest].
  SubmitLabRequestProvider(LabRequest request)
    : this._internal(
        (ref) => submitLabRequest(ref as SubmitLabRequestRef, request),
        from: submitLabRequestProvider,
        name: r'submitLabRequestProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$submitLabRequestHash,
        dependencies: SubmitLabRequestFamily._dependencies,
        allTransitiveDependencies:
            SubmitLabRequestFamily._allTransitiveDependencies,
        request: request,
      );

  SubmitLabRequestProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.request,
  }) : super.internal();

  final LabRequest request;

  @override
  Override overrideWith(
    FutureOr<LabRequest> Function(SubmitLabRequestRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SubmitLabRequestProvider._internal(
        (ref) => create(ref as SubmitLabRequestRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        request: request,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LabRequest> createElement() {
    return _SubmitLabRequestProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SubmitLabRequestProvider && other.request == request;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, request.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SubmitLabRequestRef on AutoDisposeFutureProviderRef<LabRequest> {
  /// The parameter `request` of this provider.
  LabRequest get request;
}

class _SubmitLabRequestProviderElement
    extends AutoDisposeFutureProviderElement<LabRequest>
    with SubmitLabRequestRef {
  _SubmitLabRequestProviderElement(super.provider);

  @override
  LabRequest get request => (origin as SubmitLabRequestProvider).request;
}

String _$labRequestListDataHash() =>
    r'0d35ceb340821740685b407d5812a986beaf7559';

/// Provider for getting lab request list.
///
/// This provider can be refreshed to reload the list.
/// Uses a family provider to accept optional date filters.
///
/// Copied from [labRequestListData].
@ProviderFor(labRequestListData)
const labRequestListDataProvider = LabRequestListDataFamily();

/// Provider for getting lab request list.
///
/// This provider can be refreshed to reload the list.
/// Uses a family provider to accept optional date filters.
///
/// Copied from [labRequestListData].
class LabRequestListDataFamily extends Family<AsyncValue<LabRequestListData>> {
  /// Provider for getting lab request list.
  ///
  /// This provider can be refreshed to reload the list.
  /// Uses a family provider to accept optional date filters.
  ///
  /// Copied from [labRequestListData].
  const LabRequestListDataFamily();

  /// Provider for getting lab request list.
  ///
  /// This provider can be refreshed to reload the list.
  /// Uses a family provider to accept optional date filters.
  ///
  /// Copied from [labRequestListData].
  LabRequestListDataProvider call({DateTime? startDate, DateTime? endDate}) {
    return LabRequestListDataProvider(startDate: startDate, endDate: endDate);
  }

  @override
  LabRequestListDataProvider getProviderOverride(
    covariant LabRequestListDataProvider provider,
  ) {
    return call(startDate: provider.startDate, endDate: provider.endDate);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'labRequestListDataProvider';
}

/// Provider for getting lab request list.
///
/// This provider can be refreshed to reload the list.
/// Uses a family provider to accept optional date filters.
///
/// Copied from [labRequestListData].
class LabRequestListDataProvider
    extends AutoDisposeFutureProvider<LabRequestListData> {
  /// Provider for getting lab request list.
  ///
  /// This provider can be refreshed to reload the list.
  /// Uses a family provider to accept optional date filters.
  ///
  /// Copied from [labRequestListData].
  LabRequestListDataProvider({DateTime? startDate, DateTime? endDate})
    : this._internal(
        (ref) => labRequestListData(
          ref as LabRequestListDataRef,
          startDate: startDate,
          endDate: endDate,
        ),
        from: labRequestListDataProvider,
        name: r'labRequestListDataProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$labRequestListDataHash,
        dependencies: LabRequestListDataFamily._dependencies,
        allTransitiveDependencies:
            LabRequestListDataFamily._allTransitiveDependencies,
        startDate: startDate,
        endDate: endDate,
      );

  LabRequestListDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.startDate,
    required this.endDate,
  }) : super.internal();

  final DateTime? startDate;
  final DateTime? endDate;

  @override
  Override overrideWith(
    FutureOr<LabRequestListData> Function(LabRequestListDataRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LabRequestListDataProvider._internal(
        (ref) => create(ref as LabRequestListDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        startDate: startDate,
        endDate: endDate,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LabRequestListData> createElement() {
    return _LabRequestListDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LabRequestListDataProvider &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, startDate.hashCode);
    hash = _SystemHash.combine(hash, endDate.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LabRequestListDataRef
    on AutoDisposeFutureProviderRef<LabRequestListData> {
  /// The parameter `startDate` of this provider.
  DateTime? get startDate;

  /// The parameter `endDate` of this provider.
  DateTime? get endDate;
}

class _LabRequestListDataProviderElement
    extends AutoDisposeFutureProviderElement<LabRequestListData>
    with LabRequestListDataRef {
  _LabRequestListDataProviderElement(super.provider);

  @override
  DateTime? get startDate => (origin as LabRequestListDataProvider).startDate;
  @override
  DateTime? get endDate => (origin as LabRequestListDataProvider).endDate;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
