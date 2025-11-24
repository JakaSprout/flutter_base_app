import 'package:freezed_annotation/freezed_annotation.dart';

part 'harvest_summary.freezed.dart';
part 'harvest_summary.g.dart';

/// Summary of a harvest event
@freezed
class HarvestSummary with _$HarvestSummary {
  const factory HarvestSummary({
    /// Day of Culture when harvest occurred
    required int doc,

    /// Harvest weight (kg)
    required double weight,

    /// Revenue from this harvest (Rp)
    required double revenue,

    /// Harvest percentage (0-100)
    required double percentage,

    /// Description of harvest type (e.g., "Panen 1", "Panen Parsial", "Panen Raya")
    required String description,

    /// Cycle mode: Harvest biomass (kg) = biomass before harvest - biomass after harvest
    double? harvestKg,

    /// Cycle mode: Harvest size (individuals/kg) = population at harvest / biomass at harvest
    double? harvestSize,

    /// Cycle mode: Harvest value (Rp) = harvestKg * commodity price per kg
    double? harvestValueRp,

    /// Cycle mode: Feed consumption (kg) from this harvest to next harvest
    double? feedConsumptionKg,

    /// Cycle mode: Feed cost (Rp) = feedConsumptionKg * feed price per kg
    double? feedConsumptionRp,
  }) = _HarvestSummary;

  factory HarvestSummary.fromJson(Map<String, dynamic> json) =>
      _$HarvestSummaryFromJson(json);
}
