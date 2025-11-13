// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeModelImpl _$$HomeModelImplFromJson(Map<String, dynamic> json) =>
    _$HomeModelImpl(
      activePonds: (json['activePonds'] as num).toInt(),
      estimasiBiomassa: json['estimasiBiomassa'] as String,
      totalPakan: json['totalPakan'] as String,
      biayaPakan: json['biayaPakan'] as String,
      estimasiSR: json['estimasiSR'] as String,
      ponds: (json['ponds'] as List<dynamic>)
          .map((e) => PondModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      companies: (json['companies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      selectedCompany: json['selectedCompany'] as String?,
    );

Map<String, dynamic> _$$HomeModelImplToJson(_$HomeModelImpl instance) =>
    <String, dynamic>{
      'activePonds': instance.activePonds,
      'estimasiBiomassa': instance.estimasiBiomassa,
      'totalPakan': instance.totalPakan,
      'biayaPakan': instance.biayaPakan,
      'estimasiSR': instance.estimasiSR,
      'ponds': instance.ponds,
      'companies': instance.companies,
      'selectedCompany': instance.selectedCompany,
    };
