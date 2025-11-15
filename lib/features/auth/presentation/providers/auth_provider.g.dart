// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRemoteDataSourceHash() =>
    r'f97ca22763905e7a2addc87af64a5a5709c3af62';

/// Provider for Auth remote data source.
///
/// Uses [FlavorConfig.useMockApi] to determine whether to use mock or real API.
///
/// Copied from [authRemoteDataSource].
@ProviderFor(authRemoteDataSource)
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>.internal(
  authRemoteDataSource,
  name: r'authRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRemoteDataSourceRef = ProviderRef<AuthRemoteDataSource>;
String _$authRepositoryHash() => r'b0b3d9d8a95dac0efcdd7bec48e3f84cae42e2f9';

/// Provider for Auth repository.
///
/// Copied from [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = Provider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRepositoryRef = ProviderRef<AuthRepository>;
String _$getCountryCodesHash() => r'eba05c54f62b387d7fb241796bf87787abc3e6c0';

/// Provider for GetCountryCodes use case.
///
/// Copied from [getCountryCodes].
@ProviderFor(getCountryCodes)
final getCountryCodesProvider = Provider<GetCountryCodes>.internal(
  getCountryCodes,
  name: r'getCountryCodesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getCountryCodesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetCountryCodesRef = ProviderRef<GetCountryCodes>;
String _$loginWithPhoneHash() => r'eab2d9b0e564ae38282a3d0d29380c8bba7316fb';

/// Provider for LoginWithPhone use case.
///
/// Copied from [loginWithPhone].
@ProviderFor(loginWithPhone)
final loginWithPhoneProvider = Provider<LoginWithPhone>.internal(
  loginWithPhone,
  name: r'loginWithPhoneProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loginWithPhoneHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LoginWithPhoneRef = ProviderRef<LoginWithPhone>;
String _$loginWithEmailHash() => r'bb2eb3f18764b5e21b3fc0badf8bf4c9b49c6a60';

/// Provider for LoginWithEmail use case.
///
/// Copied from [loginWithEmail].
@ProviderFor(loginWithEmail)
final loginWithEmailProvider = Provider<LoginWithEmail>.internal(
  loginWithEmail,
  name: r'loginWithEmailProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loginWithEmailHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LoginWithEmailRef = ProviderRef<LoginWithEmail>;
String _$countryCodesHash() => r'd308fbfecf2bb8d024b3584e42c804eb53277525';

/// Provider for country codes list.
///
/// Copied from [countryCodes].
@ProviderFor(countryCodes)
final countryCodesProvider =
    AutoDisposeFutureProvider<List<CountryCode>>.internal(
      countryCodes,
      name: r'countryCodesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$countryCodesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CountryCodesRef = AutoDisposeFutureProviderRef<List<CountryCode>>;
String _$phoneLoginHash() => r'9ca323930ed007c1d3c6a53017cae0d8c631cced';

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

/// Provider for phone login.
///
/// Copied from [phoneLogin].
@ProviderFor(phoneLogin)
const phoneLoginProvider = PhoneLoginFamily();

/// Provider for phone login.
///
/// Copied from [phoneLogin].
class PhoneLoginFamily extends Family<AsyncValue<LoginResponse>> {
  /// Provider for phone login.
  ///
  /// Copied from [phoneLogin].
  const PhoneLoginFamily();

  /// Provider for phone login.
  ///
  /// Copied from [phoneLogin].
  PhoneLoginProvider call(PhoneLoginRequest request) {
    return PhoneLoginProvider(request);
  }

  @override
  PhoneLoginProvider getProviderOverride(
    covariant PhoneLoginProvider provider,
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
  String? get name => r'phoneLoginProvider';
}

/// Provider for phone login.
///
/// Copied from [phoneLogin].
class PhoneLoginProvider extends AutoDisposeFutureProvider<LoginResponse> {
  /// Provider for phone login.
  ///
  /// Copied from [phoneLogin].
  PhoneLoginProvider(PhoneLoginRequest request)
    : this._internal(
        (ref) => phoneLogin(ref as PhoneLoginRef, request),
        from: phoneLoginProvider,
        name: r'phoneLoginProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$phoneLoginHash,
        dependencies: PhoneLoginFamily._dependencies,
        allTransitiveDependencies: PhoneLoginFamily._allTransitiveDependencies,
        request: request,
      );

  PhoneLoginProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.request,
  }) : super.internal();

  final PhoneLoginRequest request;

  @override
  Override overrideWith(
    FutureOr<LoginResponse> Function(PhoneLoginRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PhoneLoginProvider._internal(
        (ref) => create(ref as PhoneLoginRef),
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
  AutoDisposeFutureProviderElement<LoginResponse> createElement() {
    return _PhoneLoginProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PhoneLoginProvider && other.request == request;
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
mixin PhoneLoginRef on AutoDisposeFutureProviderRef<LoginResponse> {
  /// The parameter `request` of this provider.
  PhoneLoginRequest get request;
}

class _PhoneLoginProviderElement
    extends AutoDisposeFutureProviderElement<LoginResponse>
    with PhoneLoginRef {
  _PhoneLoginProviderElement(super.provider);

  @override
  PhoneLoginRequest get request => (origin as PhoneLoginProvider).request;
}

String _$emailLoginHash() => r'3efe4ca7b2140e24c0bce74d608adf483fd0790b';

/// Provider for email login.
///
/// Copied from [emailLogin].
@ProviderFor(emailLogin)
const emailLoginProvider = EmailLoginFamily();

/// Provider for email login.
///
/// Copied from [emailLogin].
class EmailLoginFamily extends Family<AsyncValue<LoginResponse>> {
  /// Provider for email login.
  ///
  /// Copied from [emailLogin].
  const EmailLoginFamily();

  /// Provider for email login.
  ///
  /// Copied from [emailLogin].
  EmailLoginProvider call(EmailLoginRequest request) {
    return EmailLoginProvider(request);
  }

  @override
  EmailLoginProvider getProviderOverride(
    covariant EmailLoginProvider provider,
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
  String? get name => r'emailLoginProvider';
}

/// Provider for email login.
///
/// Copied from [emailLogin].
class EmailLoginProvider extends AutoDisposeFutureProvider<LoginResponse> {
  /// Provider for email login.
  ///
  /// Copied from [emailLogin].
  EmailLoginProvider(EmailLoginRequest request)
    : this._internal(
        (ref) => emailLogin(ref as EmailLoginRef, request),
        from: emailLoginProvider,
        name: r'emailLoginProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$emailLoginHash,
        dependencies: EmailLoginFamily._dependencies,
        allTransitiveDependencies: EmailLoginFamily._allTransitiveDependencies,
        request: request,
      );

  EmailLoginProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.request,
  }) : super.internal();

  final EmailLoginRequest request;

  @override
  Override overrideWith(
    FutureOr<LoginResponse> Function(EmailLoginRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EmailLoginProvider._internal(
        (ref) => create(ref as EmailLoginRef),
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
  AutoDisposeFutureProviderElement<LoginResponse> createElement() {
    return _EmailLoginProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EmailLoginProvider && other.request == request;
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
mixin EmailLoginRef on AutoDisposeFutureProviderRef<LoginResponse> {
  /// The parameter `request` of this provider.
  EmailLoginRequest get request;
}

class _EmailLoginProviderElement
    extends AutoDisposeFutureProviderElement<LoginResponse>
    with EmailLoginRef {
  _EmailLoginProviderElement(super.provider);

  @override
  EmailLoginRequest get request => (origin as EmailLoginProvider).request;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
