// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulation_chart_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BiomassPointImpl _$$BiomassPointImplFromJson(Map<String, dynamic> json) =>
    _$BiomassPointImpl(
      doc: (json['doc'] as num).toInt(),
      biomass: (json['biomass'] as num).toDouble(),
      partialHarvest: (json['partialHarvest'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$BiomassPointImplToJson(_$BiomassPointImpl instance) =>
    <String, dynamic>{
      'doc': instance.doc,
      'biomass': instance.biomass,
      'partialHarvest': instance.partialHarvest,
    };

_$FeedPointImpl _$$FeedPointImplFromJson(Map<String, dynamic> json) =>
    _$FeedPointImpl(
      doc: (json['doc'] as num).toInt(),
      feedCost: (json['feedCost'] as num).toDouble(),
      revenue: (json['revenue'] as num).toDouble(),
    );

Map<String, dynamic> _$$FeedPointImplToJson(_$FeedPointImpl instance) =>
    <String, dynamic>{
      'doc': instance.doc,
      'feedCost': instance.feedCost,
      'revenue': instance.revenue,
    };
