import 'package:flutter_base_app/features/home/domain/entities/banner_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'banner_model.freezed.dart';
part 'banner_model.g.dart';

/// Banner data model (data layer).
@freezed
class BannerModel with _$BannerModel {
  /// Creates a new instance of [BannerModel].
  const factory BannerModel({
    required String id,
    required String title,
    required String description,
    required String imagePath,
    required String backgroundColor,
  }) = _BannerModel;

  /// Creates [BannerModel] from JSON.
  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);
}

/// Extension to convert [BannerModel] to [BannerEntity].
extension BannerModelExtension on BannerModel {
  /// Converts [BannerModel] to [BannerEntity].
  BannerEntity toEntity() {
    return BannerEntity(
      id: id,
      title: title,
      description: description,
      imagePath: imagePath,
      backgroundColor: backgroundColor,
    );
  }
}

/// Extension to convert [BannerEntity] to [BannerModel].
extension BannerEntityExtension on BannerEntity {
  /// Converts [BannerEntity] to [BannerModel].
  BannerModel toModel() {
    return BannerModel(
      id: id,
      title: title,
      description: description,
      imagePath: imagePath,
      backgroundColor: backgroundColor,
    );
  }
}
