// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$databaseHash() => r'c6f0b4de576e4b86eae70819d443c9560af58793';

/// Provider for the application database instance.
///
/// This provider creates a singleton database instance that can be used
/// throughout the application. The database is automatically disposed when
/// the provider is disposed.
///
/// Copied from [database].
@ProviderFor(database)
final databaseProvider = AutoDisposeProvider<AppDatabase>.internal(
  database,
  name: r'databaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$databaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DatabaseRef = AutoDisposeProviderRef<AppDatabase>;
String _$databaseStatusHash() => r'509453bfd4b003ee84c0a16df23226f64eef1b42';

/// Provider for database connection status.
///
/// This can be used to monitor database health and connection status.
/// Returns true if database is available, false otherwise.
///
/// Copied from [databaseStatus].
@ProviderFor(databaseStatus)
final databaseStatusProvider = AutoDisposeProvider<bool>.internal(
  databaseStatus,
  name: r'databaseStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$databaseStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DatabaseStatusRef = AutoDisposeProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
