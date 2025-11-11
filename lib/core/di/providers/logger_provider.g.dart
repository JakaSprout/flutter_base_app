// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logger_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loggerHash() => r'5cc0ee669d8437ad891a275a866a7dd433d80304';

/// Provider for Talker logger instance.
///
/// This provider provides access to the AppLogger singleton instance.
/// The logger is initialized during app startup with the appropriate
/// configuration based on the flavor.
///
/// Copied from [logger].
@ProviderFor(logger)
final loggerProvider = Provider<Talker>.internal(
  logger,
  name: r'loggerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loggerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LoggerRef = ProviderRef<Talker>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
