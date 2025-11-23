// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulation_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SimulationSummaryImpl _$$SimulationSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$SimulationSummaryImpl(
  finalBiomass: (json['finalBiomass'] as num).toDouble(),
  totalFeedConsumption: (json['totalFeedConsumption'] as num).toDouble(),
  totalRevenue: (json['totalRevenue'] as num).toDouble(),
  totalFeedCost: (json['totalFeedCost'] as num).toDouble(),
  netProfit: (json['netProfit'] as num).toDouble(),
  finalSurvivalRate: (json['finalSurvivalRate'] as num).toDouble(),
  averageFCR: (json['averageFCR'] as num).toDouble(),
  totalHarvestWeight: (json['totalHarvestWeight'] as num).toDouble(),
  simulationDays: (json['simulationDays'] as num).toInt(),
);

Map<String, dynamic> _$$SimulationSummaryImplToJson(
  _$SimulationSummaryImpl instance,
) => <String, dynamic>{
  'finalBiomass': instance.finalBiomass,
  'totalFeedConsumption': instance.totalFeedConsumption,
  'totalRevenue': instance.totalRevenue,
  'totalFeedCost': instance.totalFeedCost,
  'netProfit': instance.netProfit,
  'finalSurvivalRate': instance.finalSurvivalRate,
  'averageFCR': instance.averageFCR,
  'totalHarvestWeight': instance.totalHarvestWeight,
  'simulationDays': instance.simulationDays,
};
