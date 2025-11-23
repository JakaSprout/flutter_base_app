import 'package:app_mobile_afms/core/reference_data/domain/reference_data_type.dart';

/// Result of seeding a single reference data type.
class ReferenceDataSeedResult {
  const ReferenceDataSeedResult({
    required this.dataType,
    required this.success,
    this.recordCount = 0,
    this.cached = false,
    this.error,
  });

  final ReferenceDataType dataType;
  final bool success;
  final int recordCount;
  final bool cached;
  final String? error;

  ReferenceDataSeedResult copyWith({
    bool? success,
    int? recordCount,
    bool? cached,
    String? error,
  }) {
    return ReferenceDataSeedResult(
      dataType: dataType,
      success: success ?? this.success,
      recordCount: recordCount ?? this.recordCount,
      cached: cached ?? this.cached,
      error: error ?? this.error,
    );
  }

  static ReferenceDataSeedResult cachedResult(ReferenceDataType type) {
    return ReferenceDataSeedResult(dataType: type, success: true, cached: true);
  }
}

/// Aggregate result for seeding all reference data types.
class ReferenceDataSeedSummary {
  const ReferenceDataSeedSummary({
    required this.success,
    required this.results,
  });

  final bool success;
  final Map<ReferenceDataType, ReferenceDataSeedResult> results;

  ReferenceDataSeedResult? resultFor(ReferenceDataType type) {
    return results[type];
  }
}

