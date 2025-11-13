import 'package:flutter_base_app/features/home/data/models/pond_model.dart';
import 'package:flutter_base_app/features/home/domain/entities/pond_entity.dart';

/// Mapper for converting between pond models and entities.
class PondMapper {
  /// Private constructor to prevent instantiation.
  PondMapper._();

  /// Convert [PondModel] to [PondEntity].
  static PondEntity toEntity(PondModel model) {
    return PondEntity(
      id: model.id,
      name: model.name,
    );
  }

  /// Convert [PondEntity] to [PondModel].
  static PondModel toModel(PondEntity entity) {
    return PondModel(
      id: entity.id,
      name: entity.name,
    );
  }
}

