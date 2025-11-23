// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulation_metrics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SimulationMetricsImpl _$$SimulationMetricsImplFromJson(
  Map<String, dynamic> json,
) => _$SimulationMetricsImpl(
  peakBiomass: (json['peakBiomass'] as num).toDouble(),
  peakBiomassDay: (json['peakBiomassDay'] as num).toInt(),
  averageDailyFeedConsumption: (json['averageDailyFeedConsumption'] as num)
      .toDouble(),
  feedEfficiency: (json['feedEfficiency'] as num).toDouble(),
  biomassGrowthRate: (json['biomassGrowthRate'] as num).toDouble(),
  daysToHalfBiomass: (json['daysToHalfBiomass'] as num).toInt(),
  daysToFourFifthBiomass: (json['daysToFourFifthBiomass'] as num).toInt(),
);

Map<String, dynamic> _$$SimulationMetricsImplToJson(
  _$SimulationMetricsImpl instance,
) => <String, dynamic>{
  'peakBiomass': instance.peakBiomass,
  'peakBiomassDay': instance.peakBiomassDay,
  'averageDailyFeedConsumption': instance.averageDailyFeedConsumption,
  'feedEfficiency': instance.feedEfficiency,
  'biomassGrowthRate': instance.biomassGrowthRate,
  'daysToHalfBiomass': instance.daysToHalfBiomass,
  'daysToFourFifthBiomass': instance.daysToFourFifthBiomass,
};
