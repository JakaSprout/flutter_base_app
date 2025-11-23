import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/simulation_results_models.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

/// Data table widget for displaying feed expenditure data.
class FeedTable extends StatelessWidget {
  /// Creates a new instance of [FeedTable].
  const FeedTable({
    required this.rows,
    required this.isAscending,
    required this.onSort,
    this.height,
    this.showExtendedColumns = false,
    super.key,
  });

  /// Table row data.
  final List<SimulationTableRowData> rows;

  /// Whether DOC column is sorted ascending.
  final bool isAscending;

  /// Callback when sort is triggered.
  final VoidCallback onSort;

  /// Optional custom height for the table. If null, uses default height of 400.
  final double? height;

  /// Whether to show extended columns (weight, population, biomass, etc.)
  final bool showExtendedColumns;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    // Debug table values for first few rows to compare with CSV
    for (var i = 0; i < rows.length && i < 5; i++) {
      final row = rows[i];
      debugPrint(
        'FEED_TABLE DOC=${row.doc}: weight_gr=${row.weight.toStringAsFixed(3)}, populasi=${row.population.round()}, biomassa_kg=${row.biomass.toStringAsFixed(3)}, capacity_pond=${row.capacityPerPond.toStringAsFixed(3)}, daily_feed_kg=${row.dailyFeedConsumption.toStringAsFixed(3)}, cumulative_feed_kg=${row.cumulativeFeedConsumption.toStringAsFixed(3)}, revenue=${currencyFormat.format(row.revenue)}, feed_cost=${currencyFormat.format(row.feedCost)}',
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: HarvestCalculatorDesignConstants.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: HarvestCalculatorDesignConstants.gray20),
        ),
        child: SizedBox(
          height: height ?? 400,
          child: DataTable2(
            columnSpacing: 0,
            horizontalMargin: 0,
            minWidth: showExtendedColumns ? 600 : 200,
            scrollController: ScrollController(),
            headingRowColor: WidgetStateProperty.all(
              HarvestCalculatorDesignConstants.gray05,
            ),
            headingRowHeight: 56,
            headingRowDecoration: const BoxDecoration(
              color: HarvestCalculatorDesignConstants.gray05,
              border: Border(
                bottom: BorderSide(
                  color: HarvestCalculatorDesignConstants.gray20,
                ),
              ),
            ),
            dataRowHeight: 48,
            border: const TableBorder(
              top: BorderSide(color: HarvestCalculatorDesignConstants.gray20),
              bottom: BorderSide(
                color: HarvestCalculatorDesignConstants.gray20,
              ),
              left: BorderSide(color: HarvestCalculatorDesignConstants.gray20),
              right: BorderSide(color: HarvestCalculatorDesignConstants.gray20),
              horizontalInside: BorderSide(
                color: HarvestCalculatorDesignConstants.gray20,
              ),
              verticalInside: BorderSide(
                color: HarvestCalculatorDesignConstants.gray20,
              ),
            ),
            columns: [
              DataColumn2(
                minWidth: 86,
                label: ColoredBox(
                  color: HarvestCalculatorDesignConstants.gray05,
                  child: GestureDetector(
                    onTap: onSort,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'DOC',
                            style: HarvestCalculatorDesignConstants
                                .smallTextStyle
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: HarvestCalculatorDesignConstants
                                      .textPrimary,
                                ),
                          ),
                          const SizedBox(width: 10),
                          SvgPicture.asset(
                            Assets.icons.general.arrowUpDown,
                            width: 20,
                            height: 20,
                            color:
                                HarvestCalculatorDesignConstants.textSecondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                size: ColumnSize.S,
              ),
              DataColumn2(
                label: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: showExtendedColumns ? 8 : 12,
                  ),
                  child: SizedBox(
                    height: 40,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Pendapatan\n(Rp)',
                        style: HarvestCalculatorDesignConstants.smallTextStyle
                            .copyWith(
                              fontWeight: FontWeight.w600,
                              color:
                                  HarvestCalculatorDesignConstants.textPrimary,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                size: showExtendedColumns ? ColumnSize.M : ColumnSize.L,
              ),
              DataColumn2(
                label: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: showExtendedColumns ? 8 : 12,
                  ),
                  child: SizedBox(
                    height: 40,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Pengeluaran\n(Rp)',
                        style: HarvestCalculatorDesignConstants.smallTextStyle
                            .copyWith(
                              fontWeight: FontWeight.w600,
                              color:
                                  HarvestCalculatorDesignConstants.textPrimary,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                size: showExtendedColumns ? ColumnSize.M : ColumnSize.L,
              ),
              DataColumn2(
                label: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: showExtendedColumns ? 8 : 12,
                  ),
                  child: SizedBox(
                    height: 40,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Total\nPanen\n(g)',
                        style: HarvestCalculatorDesignConstants.smallTextStyle
                            .copyWith(
                              fontWeight: FontWeight.w600,
                              color:
                                  HarvestCalculatorDesignConstants.textPrimary,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                size: showExtendedColumns ? ColumnSize.S : ColumnSize.M,
              ),
              DataColumn2(
                label: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: showExtendedColumns ? 8 : 12,
                  ),
                  child: SizedBox(
                    height: 40,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Pakan\nKeluar\n(g)',
                        style: HarvestCalculatorDesignConstants.smallTextStyle
                            .copyWith(
                              fontWeight: FontWeight.w600,
                              color:
                                  HarvestCalculatorDesignConstants.textPrimary,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                size: showExtendedColumns ? ColumnSize.S : ColumnSize.M,
              ),
              if (showExtendedColumns) ...[
                DataColumn2(
                  label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      height: 40,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Weight\n(gr)',
                          style: HarvestCalculatorDesignConstants.smallTextStyle
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                color: HarvestCalculatorDesignConstants
                                    .textPrimary,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  size: ColumnSize.S,
                ),
                DataColumn2(
                  label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      height: 40,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Populasi',
                          style: HarvestCalculatorDesignConstants.smallTextStyle
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                color: HarvestCalculatorDesignConstants
                                    .textPrimary,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  size: ColumnSize.S,
                ),
                DataColumn2(
                  label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      height: 40,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Biomassa\n(kg)',
                          style: HarvestCalculatorDesignConstants.smallTextStyle
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                color: HarvestCalculatorDesignConstants
                                    .textPrimary,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  size: ColumnSize.S,
                ),
                DataColumn2(
                  label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      height: 40,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Capacity\nPond',
                          style: HarvestCalculatorDesignConstants.smallTextStyle
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                color: HarvestCalculatorDesignConstants
                                    .textPrimary,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  size: ColumnSize.S,
                ),
                DataColumn2(
                  label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      height: 40,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Pakan\nHarian\n(kg)',
                          style: HarvestCalculatorDesignConstants.smallTextStyle
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                color: HarvestCalculatorDesignConstants
                                    .textPrimary,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  size: ColumnSize.S,
                ),
                DataColumn2(
                  label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      height: 40,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Pakan\nCumul.\n(kg)',
                          style: HarvestCalculatorDesignConstants.smallTextStyle
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                color: HarvestCalculatorDesignConstants
                                    .textPrimary,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  size: ColumnSize.S,
                ),
              ],
            ],
            rows: rows
                .map(
                  (row) => DataRow(
                    cells: [
                      DataCell(
                        Container(
                          color: HarvestCalculatorDesignConstants.gray05,
                          padding: EdgeInsets.symmetric(
                            horizontal: showExtendedColumns ? 4 : 12,
                          ),
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '${row.doc}',
                              style: HarvestCalculatorDesignConstants
                                  .smallTextStyle
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: HarvestCalculatorDesignConstants
                                        .textPrimary,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: showExtendedColumns ? 4 : 12,
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              currencyFormat.format(row.revenue),
                              style: HarvestCalculatorDesignConstants
                                  .smallTextStyle
                                  .copyWith(
                                    color: HarvestCalculatorDesignConstants
                                        .textPrimary,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: showExtendedColumns ? 4 : 12,
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              currencyFormat.format(row.feedCost),
                              style: HarvestCalculatorDesignConstants
                                  .smallTextStyle
                                  .copyWith(
                                    color: HarvestCalculatorDesignConstants
                                        .textPrimary,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: showExtendedColumns ? 4 : 12,
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              // Total panen kumulatif (convert kg to g)
                              (row.biomass * 1000).toStringAsFixed(0),
                              style: HarvestCalculatorDesignConstants
                                  .smallTextStyle
                                  .copyWith(
                                    color: HarvestCalculatorDesignConstants
                                        .textPrimary,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: showExtendedColumns ? 4 : 12,
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              // Pakan keluar harian (convert kg to g)
                              (row.dailyFeedConsumption * 1000).toStringAsFixed(
                                0,
                              ),
                              style: HarvestCalculatorDesignConstants
                                  .smallTextStyle
                                  .copyWith(
                                    color: HarvestCalculatorDesignConstants
                                        .textPrimary,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      if (showExtendedColumns) ...[
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                // Weight in grams (already in grams from domain)
                                row.weight.toStringAsFixed(3),
                                style: HarvestCalculatorDesignConstants
                                    .smallTextStyle
                                    .copyWith(
                                      color: HarvestCalculatorDesignConstants
                                          .textPrimary,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                row.population.round().toString(),
                                style: HarvestCalculatorDesignConstants
                                    .smallTextStyle
                                    .copyWith(
                                      color: HarvestCalculatorDesignConstants
                                          .textPrimary,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                // Biomass in kg
                                row.biomass.toStringAsFixed(3),
                                style: HarvestCalculatorDesignConstants
                                    .smallTextStyle
                                    .copyWith(
                                      color: HarvestCalculatorDesignConstants
                                          .textPrimary,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                row.capacityPerPond.toStringAsFixed(3),
                                style: HarvestCalculatorDesignConstants
                                    .smallTextStyle
                                    .copyWith(
                                      color: HarvestCalculatorDesignConstants
                                          .textPrimary,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                // Daily feed consumption in kg
                                row.dailyFeedConsumption.toStringAsFixed(3),
                                style: HarvestCalculatorDesignConstants
                                    .smallTextStyle
                                    .copyWith(
                                      color: HarvestCalculatorDesignConstants
                                          .textPrimary,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                // Cumulative feed consumption in kg
                                row.cumulativeFeedConsumption.toStringAsFixed(
                                  3,
                                ),
                                style: HarvestCalculatorDesignConstants
                                    .smallTextStyle
                                    .copyWith(
                                      color: HarvestCalculatorDesignConstants
                                          .textPrimary,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
