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
    );

Map<String, dynamic> _$$HarvestSummaryImplToJson(
  _$HarvestSummaryImpl instance,
) => <String, dynamic>{
  'doc': instance.doc,
  'weight': instance.weight,
  'revenue': instance.revenue,
  'percentage': instance.percentage,
  'description': instance.description,
};
