import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/models/simulation_results_models.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/form_section.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:intl/intl.dart';

/// Section displaying loan potential analysis with bar chart.
class LoanAnalysisSection extends StatelessWidget {
  /// Creates a new instance of [LoanAnalysisSection].
  const LoanAnalysisSection({
    required this.simulation,
    required this.currencyFormat,
    super.key,
  });

  /// Simulation data.
  final SimulationResultsScreenArgs simulation;

  /// Currency formatter.
  final NumberFormat currencyFormat;

  @override
  Widget build(BuildContext context) {
    final totalCostNeeds = simulation.totalCostNeeds ?? 0;
    final recommendedLoan = simulation.recommendedLoan ?? 0;
    final loanCeilingTaken = simulation.loanCeilingTaken ?? 0;
    final remainingCredit = simulation.remainingCredit ?? 0;
    final creditLimit = simulation.creditLimit ?? 0;

    return SectionFieldPadding.wrapSection(
      child: FormSection(
        title: HarvestCalculatorConstants.sectionLoanAnalysis,
        children: [
          SectionFieldPadding.wrap(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Bar Chart
                SizedBox(
                  height: 300,
                  child: Echarts(
                    option: _buildLoanChartOption(
                      totalCostNeeds,
                      recommendedLoan,
                      loanCeilingTaken,
                      remainingCredit,
                      creditLimit,
                    ),
                    reloadAfterInit: true,
                  ),
                ),
                const SizedBox(height: 16),
                // Legend with border
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: HarvestCalculatorDesignConstants.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: HarvestCalculatorDesignConstants.gray20,
                    ),
                  ),
                  child: Column(
                    children: [
                      _LegendItem(
                        color: HarvestCalculatorDesignConstants.chartPurple,
                        label: HarvestCalculatorConstants.labelTotalCostNeeds,
                        value: currencyFormat.format(totalCostNeeds),
                      ),
                      const SizedBox(height: 12),
                      _LegendItem(
                        color: HarvestCalculatorDesignConstants.chartBlue500,
                        label: HarvestCalculatorConstants.labelLoanCeilingTaken,
                        value: currencyFormat.format(loanCeilingTaken),
                      ),
                      const SizedBox(height: 12),
                      _LegendItem(
                        color: HarvestCalculatorDesignConstants.chartBlue300,
                        label: HarvestCalculatorConstants.labelRemainingCredit,
                        value: currencyFormat.format(remainingCredit),
                      ),
                      const SizedBox(height: 12),
                      _LegendItem(
                        color: HarvestCalculatorDesignConstants.error,
                        label: HarvestCalculatorConstants.labelCreditLimit,
                        value: currencyFormat.format(creditLimit),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _buildLoanChartOption(
    double totalCostNeeds,
    double recommendedLoan,
    double loanCeilingTaken,
    double remainingCredit,
    double creditLimit,
  ) {
    // Convert to millions for better display
    final costNeedsM = totalCostNeeds / 1000000;
    final recommendedLoanM = recommendedLoan / 1000000;
    final loanCeilingTakenM = loanCeilingTaken / 1000000;
    final remainingCreditM = remainingCredit / 1000000;
    final creditLimitM = creditLimit / 1000000;
    final maxValue = [
      costNeedsM,
      recommendedLoanM,
      creditLimitM,
    ].reduce((a, b) => a > b ? a : b);

    return '''
    {
      grid: { left: 60, right: 16, top: 16, bottom: 60 },
      barGap: '-50%',
      tooltip: {
        trigger: 'axis',
        axisPointer: { type: 'shadow' },
        backgroundColor: '#FFFFFF',
        borderColor: '#E5E7EB',
        borderWidth: 1,
        textStyle: { color: '#111827' },
        formatter: function(params) {
          var result = params[0].name + '<br/>';
          params.forEach(function(item) {
            result += item.marker + ' ' + item.seriesName + ': Rp ' + item.value + 'jt<br/>';
          });
          return result;
        }
      },
      legend: {
        show: false
      },
      xAxis: {
        type: 'category',
        data: ['Total Kebutuhan Biaya', 'Pinjaman Yang Disarankan'],
        axisLine: { lineStyle: { color: '#CFCFCF' } },
        axisLabel: {
          fontFamily: 'Open Sans',
          fontSize: 9,
          color: '#4A4A4A'
        }
      },
      yAxis: {
        type: 'value',
        name: 'Nilai (Rp)',
        nameLocation: 'middle',
        nameGap: 40,
        nameTextStyle: {
          fontFamily: 'Open Sans',
          fontSize: 12,
          color: '#4A4A4A'
        },
        axisLine: { show: false },
        splitLine: { lineStyle: { color: '#ECECEC' } },
        axisLabel: {
          formatter: function(value) {
            return value + 'jt';
          },
          fontFamily: 'Open Sans',
          fontSize: 12,
          color: '#4A4A4A'
        },
        max: ${maxValue * 1.2}
      },
      series: [
        {
          name: 'Total Kebutuhan Biaya',
          type: 'bar',
          stack: 'cost',
          data: [$costNeedsM, 0],
          itemStyle: { color: '#${HarvestCalculatorDesignConstants.chartPurple.value.toRadixString(16).substring(2)}' },
          barWidth: 60
        },
        {
          name: 'Plafon Yang Diambil',
          type: 'bar',
          stack: 'loan',
          data: [0, $loanCeilingTakenM],
          itemStyle: { color: '#${HarvestCalculatorDesignConstants.chartBlue500.value.toRadixString(16).substring(2)}' },
          barWidth: 60
        },
        {
          name: 'Sisa Kredit',
          type: 'bar',
          stack: 'loan',
          data: [0, $remainingCreditM],
          itemStyle: { color: '#${HarvestCalculatorDesignConstants.chartBlue300.value.toRadixString(16).substring(2)}' },
          barWidth: 60
        },
        {
          name: 'Batas Limit Kredit',
          type: 'line',
          data: [$creditLimitM, $creditLimitM],
          lineStyle: {
            color: '#${HarvestCalculatorDesignConstants.error.value.toRadixString(16).substring(2)}',
            width: 2,
            type: 'dashed'
          },
          itemStyle: {
            color: '#${HarvestCalculatorDesignConstants.error.value.toRadixString(16).substring(2)}'
          },
          symbol: 'none',
          markLine: {
            silent: true,
            lineStyle: {
              color: '#${HarvestCalculatorDesignConstants.error.value.toRadixString(16).substring(2)}',
              width: 2,
              type: 'dashed'
            },
            label: {
              show: false
            }
          }
        }
      ]
    }
    ''';
  }
}

/// Legend item widget.
class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.color,
    required this.label,
    required this.value,
  });

  final Color color;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: HarvestCalculatorDesignConstants.textPrimary,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Open Sans',
            fontSize: HarvestCalculatorDesignConstants.fontSize12,
            fontWeight: HarvestCalculatorDesignConstants.fontWeightBold,
            color: HarvestCalculatorDesignConstants.textPrimary,
          ),
        ),
      ],
    );
  }
}
