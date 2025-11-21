// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'harvest_simulation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HarvestSimulationImpl _$$HarvestSimulationImplFromJson(
  Map<String, dynamic> json,
) => _$HarvestSimulationImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  commodity: json['commodity'] as String,
  cultivationSystem: json['cultivationSystem'] as String,
  pondArea: (json['pondArea'] as num).toDouble(),
  targetHarvest: (json['targetHarvest'] as num).toDouble(),
  estimatedADG: (json['estimatedADG'] as num).toDouble(),
  targetDOC: (json['targetDOC'] as num).toInt(),
  targetSR: (json['targetSR'] as num).toDouble(),
  estimatedFCR: (json['estimatedFCR'] as num).toDouble(),
  targetBiomass: (json['targetBiomass'] as num).toDouble(),
  sellingPrice: (json['sellingPrice'] as num).toDouble(),
  feedPrice: (json['feedPrice'] as num).toDouble(),
  cycleType: json['cycleType'] as String,
  currentDOC: (json['currentDOC'] as num?)?.toDouble(),
  results: SimulationResults.fromJson(json['results'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$HarvestSimulationImplToJson(
  _$HarvestSimulationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'createdAt': instance.createdAt.toIso8601String(),
  'commodity': instance.commodity,
  'cultivationSystem': instance.cultivationSystem,
  'pondArea': instance.pondArea,
  'targetHarvest': instance.targetHarvest,
  'estimatedADG': instance.estimatedADG,
  'targetDOC': instance.targetDOC,
  'targetSR': instance.targetSR,
  'estimatedFCR': instance.estimatedFCR,
  'targetBiomass': instance.targetBiomass,
  'sellingPrice': instance.sellingPrice,
  'feedPrice': instance.feedPrice,
  'cycleType': instance.cycleType,
  'currentDOC': instance.currentDOC,
  'results': instance.results,
};

_$SimulationResultsImpl _$$SimulationResultsImplFromJson(
  Map<String, dynamic> json,
) => _$SimulationResultsImpl(
  potentialRevenue: (json['potentialRevenue'] as num).toDouble(),
  potentialFeedCost: (json['potentialFeedCost'] as num).toDouble(),
  potentialProfit: (json['potentialProfit'] as num).toDouble(),
  biomass: (json['biomass'] as num).toDouble(),
  biomassPoints: (json['biomassPoints'] as List<dynamic>)
      .map((e) => BiomassPoint.fromJson(e as Map<String, dynamic>))
      .toList(),
  feedVsRevenuePoints: (json['feedVsRevenuePoints'] as List<dynamic>)
      .map((e) => FeedPoint.fromJson(e as Map<String, dynamic>))
      .toList(),
  tableRows: (json['tableRows'] as List<dynamic>)
      .map((e) => SimulationTableRow.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$SimulationResultsImplToJson(
  _$SimulationResultsImpl instance,
) => <String, dynamic>{
  'potentialRevenue': instance.potentialRevenue,
  'potentialFeedCost': instance.potentialFeedCost,
  'potentialProfit': instance.potentialProfit,
  'biomass': instance.biomass,
  'biomassPoints': instance.biomassPoints,
  'feedVsRevenuePoints': instance.feedVsRevenuePoints,
  'tableRows': instance.tableRows,
};
