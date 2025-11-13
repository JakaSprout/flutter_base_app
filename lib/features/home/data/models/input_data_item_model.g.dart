// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_data_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InputDataItemModelImpl _$$InputDataItemModelImplFromJson(
  Map<String, dynamic> json,
) => _$InputDataItemModelImpl(
  id: json['id'] as String,
  label: json['label'] as String,
  iconPath: json['iconPath'] as String,
  backgroundColor: json['backgroundColor'] as String,
  iconColor: json['iconColor'] as String,
  order: (json['order'] as num).toInt(),
);

Map<String, dynamic> _$$InputDataItemModelImplToJson(
  _$InputDataItemModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'iconPath': instance.iconPath,
  'backgroundColor': instance.backgroundColor,
  'iconColor': instance.iconColor,
  'order': instance.order,
};
