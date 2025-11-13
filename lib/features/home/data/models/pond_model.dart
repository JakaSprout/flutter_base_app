import 'package:flutter_base_app/features/home/domain/entities/pond_entity.dart'
    show PondEntity;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pond_model.freezed.dart';
part 'pond_model.g.dart';

/// Pond data model (data layer).
///
/// This is the data model with JSON serialization support.
/// It will be mapped to [PondEntity] entity in the domain layer.
@freezed
class PondModel with _$PondModel {
  /// Creates a new instance of [PondModel].
  const factory PondModel({required String id, required String name}) =
      _PondModel;

  /// Creates [PondModel] from JSON.
  factory PondModel.fromJson(Map<String, dynamic> json) =>
      _$PondModelFromJson(json);
}
