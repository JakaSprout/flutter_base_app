import 'package:flutter_base_app/features/home/data/models/home_model.dart';
import 'package:flutter_base_app/features/home/data/models/mappers/pond_mapper.dart';
import 'package:flutter_base_app/features/home/domain/entities/home_data.dart';

/// Mapper for converting between data models and domain entities.
class HomeMapper {
  /// Private constructor to prevent instantiation.
  HomeMapper._();

  /// Convert [HomeModel] to [HomeData] entity.
  static HomeData toEntity(HomeModel model) {
    return HomeData(
      activePonds: model.activePonds,
      estimasiBiomassa: model.estimasiBiomassa,
      totalPakan: model.totalPakan,
      biayaPakan: model.biayaPakan,
      estimasiSR: model.estimasiSR,
      ponds: model.ponds.map(PondMapper.toEntity).toList(),
      companies: model.companies,
      selectedCompany: model.selectedCompany,
    );
  }

  /// Convert [HomeData] entity to [HomeModel].
  static HomeModel toModel(HomeData entity) {
    return HomeModel(
      activePonds: entity.activePonds,
      estimasiBiomassa: entity.estimasiBiomassa,
      totalPakan: entity.totalPakan,
      biayaPakan: entity.biayaPakan,
      estimasiSR: entity.estimasiSR,
      ponds: entity.ponds.map(PondMapper.toModel).toList(),
      companies: entity.companies,
      selectedCompany: entity.selectedCompany,
    );
  }
}
