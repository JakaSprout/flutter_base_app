import 'package:freezed_annotation/freezed_annotation.dart';

part 'simulation_table_data.freezed.dart';
part 'simulation_table_data.g.dart';

/// Domain entity representing a simulation table row.
@freezed
class SimulationTableRow with _$SimulationTableRow {
  const factory SimulationTableRow({
    required int doc,
    required double weight,
    required double quantity,
    required double sr,
    required double fcr,
    required double adg,
    required double biomass,
    required double sellingPrice,
    required double feedPrice,
    required double revenue,
    required double feedCost,
    required double profit,
  }) = _SimulationTableRow;

  factory SimulationTableRow.fromJson(Map<String, dynamic> json) =>
      _$SimulationTableRowFromJson(json);
}

