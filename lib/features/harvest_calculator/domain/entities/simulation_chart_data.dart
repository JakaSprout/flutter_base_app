import 'package:freezed_annotation/freezed_annotation.dart';

part 'simulation_chart_data.freezed.dart';
part 'simulation_chart_data.g.dart';

/// Domain entity representing a biomass chart point.
@freezed
class BiomassPoint with _$BiomassPoint {
  const factory BiomassPoint({
    required int doc,
    required double biomass,
    required double? partialHarvest,
  }) = _BiomassPoint;

  factory BiomassPoint.fromJson(Map<String, dynamic> json) =>
      _$BiomassPointFromJson(json);
}

/// Domain entity representing a feed vs revenue chart point.
@freezed
class FeedPoint with _$FeedPoint {
  const factory FeedPoint({
    required int doc,
    required double feedCost,
    required double revenue,
  }) = _FeedPoint;

  factory FeedPoint.fromJson(Map<String, dynamic> json) =>
      _$FeedPointFromJson(json);
}

