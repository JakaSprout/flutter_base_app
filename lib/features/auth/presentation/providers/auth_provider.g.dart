// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRemoteDataSourceHash() =>
    r'5e9897d849be2ea305f997d2223663367fdc5aa0';

/// Provider for Auth remote data source.
///
/// Uses [AppConfig.useMockApi] to determine whether to use mock or real API.
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
String _$refreshTokenHash() => r'104b0d2f8ebf1fea2d184bdbeef3de97819c5073';

/// Provider for RefreshToken use case.
///
/// Copied from [refreshToken].
@ProviderFor(refreshToken)
final refreshTokenProvider = Provider<RefreshToken>.internal(
  refreshToken,
  name: r'refreshTokenProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$refreshTokenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RefreshTokenRef = ProviderRef<RefreshToken>;
String _$logoutUseCaseHash() => r'e2168041009773a33cf4e07ac9a2b2ca23c25e7b';

/// Provider for Logout use case.
///
/// Copied from [logoutUseCase].
@ProviderFor(logoutUseCase)
final logoutUseCaseProvider = Provider<Logout>.internal(
  logoutUseCase,
  name: r'logoutUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$logoutUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LogoutUseCaseRef = ProviderRef<Logout>;
String _$phoneLoginHash() => r'889b0269d63a170598f63b28607a8b49a6cee905';

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

String _$emailLoginHash() => r'2de967d452d159def098636be8fce5fd2480e06c';

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

String _$tokenRefreshHash() => r'a7855c4c7c811ef07635cfaaf5e400ba2abac651';

/// Provider for token refresh.
///
/// Copied from [tokenRefresh].
@ProviderFor(tokenRefresh)
const tokenRefreshProvider = TokenRefreshFamily();

/// Provider for token refresh.
///
/// Copied from [tokenRefresh].
class TokenRefreshFamily extends Family<AsyncValue<LoginResponse>> {
  /// Provider for token refresh.
  ///
  /// Copied from [tokenRefresh].
  const TokenRefreshFamily();

  /// Provider for token refresh.
  ///
  /// Copied from [tokenRefresh].
  TokenRefreshProvider call(String refreshToken) {
    return TokenRefreshProvider(refreshToken);
  }

  @override
  TokenRefreshProvider getProviderOverride(
    covariant TokenRefreshProvider provider,
  ) {
    return call(provider.refreshToken);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'tokenRefreshProvider';
}

/// Provider for token refresh.
///
/// Copied from [tokenRefresh].
class TokenRefreshProvider extends AutoDisposeFutureProvider<LoginResponse> {
  /// Provider for token refresh.
  ///
  /// Copied from [tokenRefresh].
  TokenRefreshProvider(String refreshToken)
    : this._internal(
        (ref) => tokenRefresh(ref as TokenRefreshRef, refreshToken),
        from: tokenRefreshProvider,
        name: r'tokenRefreshProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$tokenRefreshHash,
        dependencies: TokenRefreshFamily._dependencies,
        allTransitiveDependencies:
            TokenRefreshFamily._allTransitiveDependencies,
        refreshToken: refreshToken,
      );

  TokenRefreshProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.refreshToken,
  }) : super.internal();

  final String refreshToken;

  @override
  Override overrideWith(
    FutureOr<LoginResponse> Function(TokenRefreshRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TokenRefreshProvider._internal(
        (ref) => create(ref as TokenRefreshRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        refreshToken: refreshToken,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LoginResponse> createElement() {
    return _TokenRefreshProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TokenRefreshProvider && other.refreshToken == refreshToken;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, refreshToken.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TokenRefreshRef on AutoDisposeFutureProviderRef<LoginResponse> {
  /// The parameter `refreshToken` of this provider.
  String get refreshToken;
}

class _TokenRefreshProviderElement
    extends AutoDisposeFutureProviderElement<LoginResponse>
    with TokenRefreshRef {
  _TokenRefreshProviderElement(super.provider);

  @override
  String get refreshToken => (origin as TokenRefreshProvider).refreshToken;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
