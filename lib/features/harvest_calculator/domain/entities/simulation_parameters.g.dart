// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulation_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SimulationParametersImpl _$$SimulationParametersImplFromJson(
  Map<String, dynamic> json,
) => _$SimulationParametersImpl(
  pondArea: (json['pondArea'] as num).toDouble(),
  stockingDensity: (json['stockingDensity'] as num).toDouble(),
  initialWeight: (json['initialWeight'] as num).toDouble(),
  targetSR: (json['targetSR'] as num).toDouble(),
  targetHarvestWeight: (json['targetHarvestWeight'] as num).toDouble(),
  estimatedFCR: (json['estimatedFCR'] as num).toDouble(),
  targetDOC: (json['targetDOC'] as num).toInt(),
  estimatedADG: (json['estimatedADG'] as num).toDouble(),
  dailyLossPercentage: (json['dailyLossPercentage'] as num).toDouble(),
  capacityKgPerM2: (json['capacityKgPerM2'] as num).toDouble(),
  capacityKgPerPond: (json['capacityKgPerPond'] as num).toDouble(),
  sellingPricePerKg: (json['sellingPricePerKg'] as num).toDouble(),
  feedPricePerKg: (json['feedPricePerKg'] as num).toDouble(),
  feedingRatePercentage: (json['feedingRatePercentage'] as num).toDouble(),
  harvestEvents: (json['harvestEvents'] as List<dynamic>)
      .map((e) => HarvestEvent.fromJson(e as Map<String, dynamic>))
      .toList(),
  currentDOC: (json['currentDOC'] as num?)?.toInt(),
  simulationType: json['simulationType'] as String?,
  currentBiomass: (json['currentBiomass'] as num?)?.toDouble(),
  stocking: (json['stocking'] as num?)?.toDouble(),
  estimatedHarvestYield: (json['estimatedHarvestYield'] as num?)?.toDouble(),
  totalFeedPaymentObligation: (json['totalFeedPaymentObligation'] as num?)
      ?.toDouble(),
  harvestPurchasePrice: (json['harvestPurchasePrice'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$SimulationParametersImplToJson(
  _$SimulationParametersImpl instance,
) => <String, dynamic>{
  'pondArea': instance.pondArea,
  'stockingDensity': instance.stockingDensity,
  'initialWeight': instance.initialWeight,
  'targetSR': instance.targetSR,
  'targetHarvestWeight': instance.targetHarvestWeight,
  'estimatedFCR': instance.estimatedFCR,
  'targetDOC': instance.targetDOC,
  'estimatedADG': instance.estimatedADG,
  'dailyLossPercentage': instance.dailyLossPercentage,
  'capacityKgPerM2': instance.capacityKgPerM2,
  'capacityKgPerPond': instance.capacityKgPerPond,
  'sellingPricePerKg': instance.sellingPricePerKg,
  'feedPricePerKg': instance.feedPricePerKg,
  'feedingRatePercentage': instance.feedingRatePercentage,
  'harvestEvents': instance.harvestEvents,
  'currentDOC': instance.currentDOC,
  'simulationType': instance.simulationType,
  'currentBiomass': instance.currentBiomass,
  'stocking': instance.stocking,
  'estimatedHarvestYield': instance.estimatedHarvestYield,
  'totalFeedPaymentObligation': instance.totalFeedPaymentObligation,
  'harvestPurchasePrice': instance.harvestPurchasePrice,
};

_$HarvestEventImpl _$$HarvestEventImplFromJson(Map<String, dynamic> json) =>
    _$HarvestEventImpl(
      doc: (json['doc'] as num).toInt(),
      percentage: (json['percentage'] as num).toDouble(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$HarvestEventImplToJson(_$HarvestEventImpl instance) =>
    <String, dynamic>{
      'doc': instance.doc,
      'percentage': instance.percentage,
      'description': instance.description,
    };
