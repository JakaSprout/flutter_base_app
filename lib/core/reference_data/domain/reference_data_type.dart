import 'package:collection/collection.dart';

/// Supported reference data types that can be cached locally.
enum ReferenceDataType {
  /// Lab test type definitions (diagnostics vs screening, etc.).
  labTestTypes,

  /// Employee lookup (PIC) data.
  employees,

  /// Customer lookup data.
  customers,

  /// Farm lookup data.
  farms,

  /// Pond lookup data (used by Harvest Calculator & Lab Request).
  ponds,
}

extension ReferenceDataTypeX on ReferenceDataType {
  /// Unique key used for metadata table.
  String get key => name;

  /// Human-friendly label for logging / debug.
  String get label {
    switch (this) {
      case ReferenceDataType.labTestTypes:
        return 'Lab Test Types';
      case ReferenceDataType.employees:
        return 'Employees';
      case ReferenceDataType.customers:
        return 'Customers';
      case ReferenceDataType.farms:
        return 'Farms';
      case ReferenceDataType.ponds:
        return 'Ponds';
    }
  }
}

/// Utility helper for reference-data specific configuration (TTL, priority).
class ReferenceDataConfig {
  const ReferenceDataConfig._();

  /// Default TTL per data type (aligned with documentation).
  static const Map<ReferenceDataType, Duration> defaultTtls = {
    ReferenceDataType.labTestTypes: Duration(hours: 24),
    ReferenceDataType.employees: Duration(hours: 6),
    ReferenceDataType.customers: Duration(hours: 6),
    ReferenceDataType.farms: Duration(hours: 6),
    ReferenceDataType.ponds: Duration(hours: 1),
  };

  /// Priority order for seeding (high priority data goes first).
  static const List<ReferenceDataType> defaultSeedOrder = [
    ReferenceDataType.ponds,
    ReferenceDataType.farms,
    ReferenceDataType.customers,
    ReferenceDataType.employees,
    ReferenceDataType.labTestTypes,
  ];

  /// Returns TTL for given type (with fallback to 6 hours).
  static Duration ttlFor(ReferenceDataType type) {
    return defaultTtls[type] ?? const Duration(hours: 6);
  }

  /// Utility to sort data types by priority (ponds first).
  static List<ReferenceDataType> sortByPriority(
    Iterable<ReferenceDataType> types,
  ) {
    final priorityMap = {
      for (var i = 0; i < defaultSeedOrder.length; i++) defaultSeedOrder[i]: i,
    };
    return types.sorted((a, b) {
      final aPriority = priorityMap[a] ?? defaultSeedOrder.length;
      final bPriority = priorityMap[b] ?? defaultSeedOrder.length;
      return aPriority.compareTo(bPriority);
    });
  }
}

