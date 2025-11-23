// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_simulation_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailySimulationResultImpl _$$DailySimulationResultImplFromJson(
  Map<String, dynamic> json,
) => _$DailySimulationResultImpl(
  doc: (json['doc'] as num).toInt(),
  weight: (json['weight'] as num).toDouble(),
  population: (json['population'] as num).toDouble(),
  biomass: (json['biomass'] as num).toDouble(),
  dailyFeedConsumption: (json['dailyFeedConsumption'] as num).toDouble(),
  cumulativeFeedConsumption: (json['cumulativeFeedConsumption'] as num)
      .toDouble(),
  potentialRevenue: (json['potentialRevenue'] as num).toDouble(),
  cumulativeFeedCost: (json['cumulativeFeedCost'] as num).toDouble(),
  potentialProfit: (json['potentialProfit'] as num).toDouble(),
  survivalRate: (json['survivalRate'] as num).toDouble(),
  fcr: (json['fcr'] as num).toDouble(),
  adg: (json['adg'] as num).toDouble(),
  hasHarvest: json['hasHarvest'] as bool? ?? false,
  harvestAmount: (json['harvestAmount'] as num?)?.toDouble(),
  harvestPopulationReduction: (json['harvestPopulationReduction'] as num?)
      ?.toDouble(),
);

Map<String, dynamic> _$$DailySimulationResultImplToJson(
  _$DailySimulationResultImpl instance,
) => <String, dynamic>{
  'doc': instance.doc,
  'weight': instance.weight,
  'population': instance.population,
  'biomass': instance.biomass,
  'dailyFeedConsumption': instance.dailyFeedConsumption,
  'cumulativeFeedConsumption': instance.cumulativeFeedConsumption,
  'potentialRevenue': instance.potentialRevenue,
  'cumulativeFeedCost': instance.cumulativeFeedCost,
  'potentialProfit': instance.potentialProfit,
  'survivalRate': instance.survivalRate,
  'fcr': instance.fcr,
  'adg': instance.adg,
  'hasHarvest': instance.hasHarvest,
  'harvestAmount': instance.harvestAmount,
  'harvestPopulationReduction': instance.harvestPopulationReduction,
};
