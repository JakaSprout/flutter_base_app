// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulation_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SimulationResultImpl _$$SimulationResultImplFromJson(
  Map<String, dynamic> json,
) => _$SimulationResultImpl(
  dailyResults: (json['dailyResults'] as List<dynamic>)
      .map((e) => DailySimulationResult.fromJson(e as Map<String, dynamic>))
      .toList(),
  summary: SimulationSummary.fromJson(json['summary'] as Map<String, dynamic>),
  harvestSummaries: (json['harvestSummaries'] as List<dynamic>)
      .map((e) => HarvestSummary.fromJson(e as Map<String, dynamic>))
      .toList(),
  metrics: SimulationMetrics.fromJson(json['metrics'] as Map<String, dynamic>),
  automaticHarvestDoc: (json['automaticHarvestDoc'] as num?)?.toInt(),
);

Map<String, dynamic> _$$SimulationResultImplToJson(
  _$SimulationResultImpl instance,
) => <String, dynamic>{
  'dailyResults': instance.dailyResults,
  'summary': instance.summary,
  'harvestSummaries': instance.harvestSummaries,
  'metrics': instance.metrics,
  'automaticHarvestDoc': instance.automaticHarvestDoc,
};
