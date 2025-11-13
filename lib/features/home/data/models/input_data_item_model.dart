import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_base_app/features/home/domain/entities/input_data_item_entity.dart';

part 'input_data_item_model.freezed.dart';
part 'input_data_item_model.g.dart';

/// Input data item model (data layer).
@freezed
class InputDataItemModel with _$InputDataItemModel {
  /// Creates a new instance of [InputDataItemModel].
  const factory InputDataItemModel({
    required String id,
    required String label,
    required String iconPath,
    required String backgroundColor,
    required String iconColor,
    required int order,
  }) = _InputDataItemModel;

  /// Creates [InputDataItemModel] from JSON.
  factory InputDataItemModel.fromJson(Map<String, dynamic> json) =>
      _$InputDataItemModelFromJson(json);
}

/// Extension to convert [InputDataItemModel] to [InputDataItemEntity].
extension InputDataItemModelExtension on InputDataItemModel {
  /// Converts [InputDataItemModel] to [InputDataItemEntity].
  InputDataItemEntity toEntity() {
    return InputDataItemEntity(
      id: id,
      label: label,
      iconPath: iconPath,
      backgroundColor: backgroundColor,
      iconColor: iconColor,
      order: order,
    );
  }
}

/// Extension to convert [InputDataItemEntity] to [InputDataItemModel].
extension InputDataItemEntityExtension on InputDataItemEntity {
  /// Converts [InputDataItemEntity] to [InputDataItemModel].
  InputDataItemModel toModel() {
    return InputDataItemModel(
      id: id,
      label: label,
      iconPath: iconPath,
      backgroundColor: backgroundColor,
      iconColor: iconColor,
      order: order,
    );
  }
}

