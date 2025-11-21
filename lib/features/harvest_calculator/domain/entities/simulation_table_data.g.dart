// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulation_table_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SimulationTableRowImpl _$$SimulationTableRowImplFromJson(
  Map<String, dynamic> json,
) => _$SimulationTableRowImpl(
  doc: (json['doc'] as num).toInt(),
  weight: (json['weight'] as num).toDouble(),
  quantity: (json['quantity'] as num).toDouble(),
  sr: (json['sr'] as num).toDouble(),
  fcr: (json['fcr'] as num).toDouble(),
  adg: (json['adg'] as num).toDouble(),
  biomass: (json['biomass'] as num).toDouble(),
  sellingPrice: (json['sellingPrice'] as num).toDouble(),
  feedPrice: (json['feedPrice'] as num).toDouble(),
  revenue: (json['revenue'] as num).toDouble(),
  feedCost: (json['feedCost'] as num).toDouble(),
  profit: (json['profit'] as num).toDouble(),
);

Map<String, dynamic> _$$SimulationTableRowImplToJson(
  _$SimulationTableRowImpl instance,
) => <String, dynamic>{
  'doc': instance.doc,
  'weight': instance.weight,
  'quantity': instance.quantity,
  'sr': instance.sr,
  'fcr': instance.fcr,
  'adg': instance.adg,
  'biomass': instance.biomass,
  'sellingPrice': instance.sellingPrice,
  'feedPrice': instance.feedPrice,
  'revenue': instance.revenue,
  'feedCost': instance.feedCost,
  'profit': instance.profit,
};
