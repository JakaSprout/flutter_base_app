// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'harvest_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HarvestSummaryImpl _$$HarvestSummaryImplFromJson(Map<String, dynamic> json) =>
    _$HarvestSummaryImpl(
      doc: (json['doc'] as num).toInt(),
      weight: (json['weight'] as num).toDouble(),
      revenue: (json['revenue'] as num).toDouble(),
      percentage: (json['percentage'] as num).toDouble(),
      description: json['description'] as String,
      harvestKg: (json['harvestKg'] as num?)?.toDouble(),
      harvestSize: (json['harvestSize'] as num?)?.toDouble(),
      harvestValueRp: (json['harvestValueRp'] as num?)?.toDouble(),
      feedConsumptionKg: (json['feedConsumptionKg'] as num?)?.toDouble(),
      feedConsumptionRp: (json['feedConsumptionRp'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$HarvestSummaryImplToJson(
  _$HarvestSummaryImpl instance,
) => <String, dynamic>{
  'doc': instance.doc,
  'weight': instance.weight,
  'revenue': instance.revenue,
  'percentage': instance.percentage,
  'description': instance.description,
  'harvestKg': instance.harvestKg,
  'harvestSize': instance.harvestSize,
  'harvestValueRp': instance.harvestValueRp,
  'feedConsumptionKg': instance.feedConsumptionKg,
  'feedConsumptionRp': instance.feedConsumptionRp,
};
