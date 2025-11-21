import 'package:app_mobile_afms/features/home/data/models/pond_model.dart';
import 'package:app_mobile_afms/features/home/domain/entities/home_data.dart'
    show HomeData;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_model.freezed.dart';
part 'home_model.g.dart';

/// Home data model (data layer).
///
/// This is the data model with JSON serialization support.
/// It will be mapped to [HomeData] entity in the domain layer.
@freezed
class HomeModel with _$HomeModel {
  /// Creates a new instance of [HomeModel].
  const factory HomeModel({
    required int activePonds,
    required String estimasiBiomassa,
    required String totalPakan,
    required String biayaPakan,
    required String estimasiSR,
    required List<PondModel> ponds,
    required List<String> companies,
    String? selectedCompany,
  }) = _HomeModel;

  /// Creates [HomeModel] from JSON.
  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      _$HomeModelFromJson(json);
}
