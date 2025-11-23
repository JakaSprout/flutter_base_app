// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simulation_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SimulationResult _$SimulationResultFromJson(Map<String, dynamic> json) {
  return _SimulationResult.fromJson(json);
}

/// @nodoc
mixin _$SimulationResult {
  /// All daily results from DOC 1 to target DOC
  List<DailySimulationResult> get dailyResults =>
      throw _privateConstructorUsedError;

  /// Summary statistics
  SimulationSummary get summary => throw _privateConstructorUsedError;

  /// Harvest events that occurred during simulation
  List<HarvestSummary> get harvestSummaries =>
      throw _privateConstructorUsedError;

  /// Performance metrics
  SimulationMetrics get metrics => throw _privateConstructorUsedError;

  /// DOC when automatic first harvest occurred (null if no automatic harvest)
  int? get automaticHarvestDoc => throw _privateConstructorUsedError;

  /// Serializes this SimulationResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SimulationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SimulationResultCopyWith<SimulationResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimulationResultCopyWith<$Res> {
  factory $SimulationResultCopyWith(
    SimulationResult value,
    $Res Function(SimulationResult) then,
  ) = _$SimulationResultCopyWithImpl<$Res, SimulationResult>;
  @useResult
  $Res call({
    List<DailySimulationResult> dailyResults,
    SimulationSummary summary,
    List<HarvestSummary> harvestSummaries,
    SimulationMetrics metrics,
    int? automaticHarvestDoc,
  });

  $SimulationSummaryCopyWith<$Res> get summary;
  $SimulationMetricsCopyWith<$Res> get metrics;
}

/// @nodoc
class _$SimulationResultCopyWithImpl<$Res, $Val extends SimulationResult>
    implements $SimulationResultCopyWith<$Res> {
  _$SimulationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SimulationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyResults = null,
    Object? summary = null,
    Object? harvestSummaries = null,
    Object? metrics = null,
    Object? automaticHarvestDoc = freezed,
  }) {
    return _then(
      _value.copyWith(
            dailyResults: null == dailyResults
                ? _value.dailyResults
                : dailyResults // ignore: cast_nullable_to_non_nullable
                      as List<DailySimulationResult>,
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as SimulationSummary,
            harvestSummaries: null == harvestSummaries
                ? _value.harvestSummaries
                : harvestSummaries // ignore: cast_nullable_to_non_nullable
                      as List<HarvestSummary>,
            metrics: null == metrics
                ? _value.metrics
                : metrics // ignore: cast_nullable_to_non_nullable
                      as SimulationMetrics,
            automaticHarvestDoc: freezed == automaticHarvestDoc
                ? _value.automaticHarvestDoc
                : automaticHarvestDoc // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }

  /// Create a copy of SimulationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SimulationSummaryCopyWith<$Res> get summary {
    return $SimulationSummaryCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }

  /// Create a copy of SimulationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SimulationMetricsCopyWith<$Res> get metrics {
    return $SimulationMetricsCopyWith<$Res>(_value.metrics, (value) {
      return _then(_value.copyWith(metrics: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SimulationResultImplCopyWith<$Res>
    implements $SimulationResultCopyWith<$Res> {
  factory _$$SimulationResultImplCopyWith(
    _$SimulationResultImpl value,
    $Res Function(_$SimulationResultImpl) then,
  ) = __$$SimulationResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<DailySimulationResult> dailyResults,
    SimulationSummary summary,
    List<HarvestSummary> harvestSummaries,
    SimulationMetrics metrics,
    int? automaticHarvestDoc,
  });

  @override
  $SimulationSummaryCopyWith<$Res> get summary;
  @override
  $SimulationMetricsCopyWith<$Res> get metrics;
}

/// @nodoc
class __$$SimulationResultImplCopyWithImpl<$Res>
    extends _$SimulationResultCopyWithImpl<$Res, _$SimulationResultImpl>
    implements _$$SimulationResultImplCopyWith<$Res> {
  __$$SimulationResultImplCopyWithImpl(
    _$SimulationResultImpl _value,
    $Res Function(_$SimulationResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SimulationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyResults = null,
    Object? summary = null,
    Object? harvestSummaries = null,
    Object? metrics = null,
    Object? automaticHarvestDoc = freezed,
  }) {
    return _then(
      _$SimulationResultImpl(
        dailyResults: null == dailyResults
            ? _value._dailyResults
            : dailyResults // ignore: cast_nullable_to_non_nullable
                  as List<DailySimulationResult>,
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as SimulationSummary,
        harvestSummaries: null == harvestSummaries
            ? _value._harvestSummaries
            : harvestSummaries // ignore: cast_nullable_to_non_nullable
                  as List<HarvestSummary>,
        metrics: null == metrics
            ? _value.metrics
            : metrics // ignore: cast_nullable_to_non_nullable
                  as SimulationMetrics,
        automaticHarvestDoc: freezed == automaticHarvestDoc
            ? _value.automaticHarvestDoc
            : automaticHarvestDoc // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SimulationResultImpl implements _SimulationResult {
  const _$SimulationResultImpl({
    required final List<DailySimulationResult> dailyResults,
    required this.summary,
    required final List<HarvestSummary> harvestSummaries,
    required this.metrics,
    this.automaticHarvestDoc,
  }) : _dailyResults = dailyResults,
       _harvestSummaries = harvestSummaries;

  factory _$SimulationResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$SimulationResultImplFromJson(json);

  /// All daily results from DOC 1 to target DOC
  final List<DailySimulationResult> _dailyResults;

  /// All daily results from DOC 1 to target DOC
  @override
  List<DailySimulationResult> get dailyResults {
    if (_dailyResults is EqualUnmodifiableListView) return _dailyResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailyResults);
  }

  /// Summary statistics
  @override
  final SimulationSummary summary;

  /// Harvest events that occurred during simulation
  final List<HarvestSummary> _harvestSummaries;

  /// Harvest events that occurred during simulation
  @override
  List<HarvestSummary> get harvestSummaries {
    if (_harvestSummaries is EqualUnmodifiableListView)
      return _harvestSummaries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_harvestSummaries);
  }

  /// Performance metrics
  @override
  final SimulationMetrics metrics;

  /// DOC when automatic first harvest occurred (null if no automatic harvest)
  @override
  final int? automaticHarvestDoc;

  @override
  String toString() {
    return 'SimulationResult(dailyResults: $dailyResults, summary: $summary, harvestSummaries: $harvestSummaries, metrics: $metrics, automaticHarvestDoc: $automaticHarvestDoc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimulationResultImpl &&
            const DeepCollectionEquality().equals(
              other._dailyResults,
              _dailyResults,
            ) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality().equals(
              other._harvestSummaries,
              _harvestSummaries,
            ) &&
            (identical(other.metrics, metrics) || other.metrics == metrics) &&
            (identical(other.automaticHarvestDoc, automaticHarvestDoc) ||
                other.automaticHarvestDoc == automaticHarvestDoc));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_dailyResults),
    summary,
    const DeepCollectionEquality().hash(_harvestSummaries),
    metrics,
    automaticHarvestDoc,
  );

  /// Create a copy of SimulationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SimulationResultImplCopyWith<_$SimulationResultImpl> get copyWith =>
      __$$SimulationResultImplCopyWithImpl<_$SimulationResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SimulationResultImplToJson(this);
  }
}

abstract class _SimulationResult implements SimulationResult {
  const factory _SimulationResult({
    required final List<DailySimulationResult> dailyResults,
    required final SimulationSummary summary,
    required final List<HarvestSummary> harvestSummaries,
    required final SimulationMetrics metrics,
    final int? automaticHarvestDoc,
  }) = _$SimulationResultImpl;

  factory _SimulationResult.fromJson(Map<String, dynamic> json) =
      _$SimulationResultImpl.fromJson;

  /// All daily results from DOC 1 to target DOC
  @override
  List<DailySimulationResult> get dailyResults;

  /// Summary statistics
  @override
  SimulationSummary get summary;

  /// Harvest events that occurred during simulation
  @override
  List<HarvestSummary> get harvestSummaries;

  /// Performance metrics
  @override
  SimulationMetrics get metrics;

  /// DOC when automatic first harvest occurred (null if no automatic harvest)
  @override
  int? get automaticHarvestDoc;

  /// Create a copy of SimulationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SimulationResultImplCopyWith<_$SimulationResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
