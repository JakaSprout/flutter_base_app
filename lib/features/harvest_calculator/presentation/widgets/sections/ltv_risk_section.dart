import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/components/banners/stp_status_banner.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/forms/form_section.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

/// Section displaying LTV (Loan-to-Value) risk assessment with gauge chart.
class LTVRiskSection extends StatelessWidget {
  /// Creates a new instance of [LTVRiskSection].
  const LTVRiskSection({required this.ltvPercentage, super.key});

  /// LTV percentage value (0-100).
  final double ltvPercentage;

  @override
  Widget build(BuildContext context) {
    final isIdeal = ltvPercentage < 70;
    final isWarning = ltvPercentage >= 71 && ltvPercentage <= 79;

    String riskStatus;
    Color riskColor;
    Color statusTextColor;
    if (isIdeal) {
      riskStatus = 'Ideal';
      riskColor = AppColors.success;
      statusTextColor = AppColors.black; // Black for "Ideal" text
    } else if (isWarning) {
      riskStatus = 'Waspada';
      riskColor = const Color(0xFFFFA500); // Orange for warning
      statusTextColor = riskColor;
    } else {
      riskStatus = 'Resiko Tinggi';
      riskColor = AppColors.error;
      statusTextColor = riskColor;
    }

    return SectionFieldPadding.wrapSection(
      child: FormSection(
        title: HarvestCalculatorConstants.sectionLoanRiskLTV,
        children: [
          SectionFieldPadding.wrap(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Gauge Chart
                SizedBox(
                  height: 200,
                  child: Echarts(
                    option: _buildGaugeChartOption(
                      ltvPercentage,
                      riskStatus,
                      riskColor,
                      statusTextColor,
                    ),
                    reloadAfterInit: true,
                  ),
                ),
                const SizedBox(height: 16),
                // Legend with border
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.gray20),
                  ),
                  child: const Column(
                    children: [
                      // Top row: Ideal and Waspada
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _LegendItem(
                            color: AppColors.success,
                            label: HarvestCalculatorConstants.labelLTVIdeal,
                          ),
                          _LegendItem(
                            color: Color(0xFFFFA500),
                            label: HarvestCalculatorConstants.labelLTVWarning,
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      // Bottom row: Resiko Tinggi
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _LegendItem(
                            color: AppColors.error,
                            label: HarvestCalculatorConstants.labelLTVHighRisk,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Status banner
                STPStatusBanner(
                  type: isIdeal
                      ? STPStatusBannerType.success
                      : STPStatusBannerType.info,
                  child: Text(
                    HarvestCalculatorConstants.messageLTVHealthy.replaceAll(
                      '{value}',
                      ltvPercentage.toStringAsFixed(1),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 12,
                      height: 18 / 12,
                      fontWeight: FontWeight.w400,
                      color: HarvestCalculatorDesignConstants.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _buildGaugeChartOption(
    double ltvPercentage,
    String riskStatus,
    Color riskColor,
    Color statusTextColor,
  ) {
    // Convert colors to hex
    final successHex =
        '#${AppColors.success.value.toRadixString(16).substring(2)}';
    final warningHex =
        '#${const Color(0xFFFFA500).value.toRadixString(16).substring(2)}';
    final errorHex = '#${AppColors.error.value.toRadixString(16).substring(2)}';
    final statusTextColorHex =
        '#${statusTextColor.value.toRadixString(16).substring(2)}';
    final textPrimaryHex =
        '#${HarvestCalculatorDesignConstants.textPrimary.value.toRadixString(16).substring(2)}';

    return '''
    {
      series: [
        {
          type: 'gauge',
          startAngle: 180,
          endAngle: 0,
          center: ['50%', '75%'],
          radius: '120%',
          min: 0,
          max: 100,
          splitNumber: 8,
          axisLine: {
            lineStyle: {
              width: 20,
              color: [
                [0.7, '$successHex'],
                [0.79, '$warningHex'],
                [1, '$errorHex']
              ]
            }
          },
          pointer: {
            icon: 'path://M12.8,0.7l12,40.1H0.7L12.8,0.7z',
            length: '12%',
            width: 20,
            offsetCenter: [0, '-60%'],
            itemStyle: {
              color: 'auto'
            }
          },
          axisTick: {
            show: false,
          },
          splitLine: {
            show: false,
          },
          axisLabel: {
            color: '#464646',
            fontSize: 20,
            distance: -60,
            rotate: 'tangential',
            formatter: function (value) {
              return '';
            }
          },
          title: {
            offsetCenter: [0, '-10%'],
            fontSize: 20
          },
          detail: {
            fontSize: 30,
            offsetCenter: [0, '-20%'],
            valueAnimation: true,
            formatter: function (value) {
              return value.toFixed(1) + '%\\n{status|' + '$riskStatus' + '}';
            },
            color: '$textPrimaryHex',
            rich: {
              status: {
                fontSize: 14,
                fontWeight: '600',
                color: '$statusTextColorHex',
                lineHeight: 20,
                padding: [4, 0, 0, 0]
              }
            }
          },
          data: [
            {
              value: ${ltvPercentage.clamp(0.0, 100.0)},
            }
          ]
        }
      ]
    }
    ''';
  }
}

/// Legend item widget.
class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: HarvestCalculatorDesignConstants.textSecondary,
          ),
        ),
      ],
    );
  }
}
