import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/models/simulation_results_models.dart';
import 'package:flutter_base_app/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

/// Data table widget for displaying feed expenditure data.
class FeedTable extends StatelessWidget {
  /// Creates a new instance of [FeedTable].
  const FeedTable({
    required this.rows,
    required this.isAscending,
    required this.onSort,
    super.key,
  });

  /// Table row data.
  final List<SimulationTableRowData> rows;

  /// Whether DOC column is sorted ascending.
  final bool isAscending;

  /// Callback when sort is triggered.
  final VoidCallback onSort;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.gray20),
        ),
        child: SizedBox(
          height: 280,
          child: DataTable2(
            columnSpacing: 0,
            horizontalMargin: 0,
            minWidth: 300,
            headingRowColor: WidgetStateProperty.all(AppColors.gray05),
            headingRowHeight: 56,
            headingRowDecoration: const BoxDecoration(
              color: AppColors.gray05,
              border: Border(bottom: BorderSide(color: AppColors.gray20)),
            ),
            dataRowHeight: 48,
            border: const TableBorder(
              top: BorderSide(color: AppColors.gray20),
              bottom: BorderSide(color: AppColors.gray20),
              left: BorderSide(color: AppColors.gray20),
              right: BorderSide(color: AppColors.gray20),
              horizontalInside: BorderSide(color: AppColors.gray20),
              verticalInside: BorderSide(color: AppColors.gray20),
            ),
            columns: [
              DataColumn2(
                minWidth: 86,
                label: ColoredBox(
                  color: AppColors.gray05,
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
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Potensi Pendapatan (Rp)',
                    style: HarvestCalculatorDesignConstants.smallTextStyle
                        .copyWith(
                          fontWeight: FontWeight.w600,
                          color: HarvestCalculatorDesignConstants.textPrimary,
                        ),
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                  ),
                ),
                size: ColumnSize.L,
              ),
              DataColumn2(
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Pengeluaran Pakan (Rp)',
                    style: HarvestCalculatorDesignConstants.smallTextStyle
                        .copyWith(
                          fontWeight: FontWeight.w600,
                          color: HarvestCalculatorDesignConstants.textPrimary,
                        ),
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                  ),
                ),
                size: ColumnSize.L,
              ),
              DataColumn2(
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Profit (Rp)',
                    style: HarvestCalculatorDesignConstants.smallTextStyle
                        .copyWith(
                          fontWeight: FontWeight.w600,
                          color: HarvestCalculatorDesignConstants.textPrimary,
                        ),
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                  ),
                ),
                size: ColumnSize.L,
              ),
            ],
            rows: rows
                .map(
                  (row) => DataRow(
                    cells: [
                      DataCell(
                        Container(
                          color: AppColors.gray05,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          alignment: Alignment.center,
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
                      DataCell(
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
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
                      DataCell(
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
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
                      DataCell(
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            currencyFormat.format(row.profit),
                            style: HarvestCalculatorDesignConstants
                                .smallTextStyle
                                .copyWith(
                                  color: HarvestCalculatorDesignConstants
                                      .textPrimary,
                                ),
                          ),
                        ),
                      ),
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
