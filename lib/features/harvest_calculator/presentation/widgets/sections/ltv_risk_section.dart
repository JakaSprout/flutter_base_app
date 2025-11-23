import 'package:app_mobile_afms/design_system/components/banners/stp_status_banner.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/modals/ltv_info_bottom_sheet.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/widgets/forms/section_field_padding.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Section displaying LTV (Loan-to-Value) risk assessment with gauge chart.
class LTVRiskSection extends StatelessWidget {
  /// Creates a new instance of [LTVRiskSection].
  const LTVRiskSection({required this.ltvPercentage, super.key});

  /// LTV percentage value (0-100).
  final double ltvPercentage;

  @override
  Widget build(BuildContext context) {
    final riskData = _calculateRiskData(ltvPercentage);

    return SectionFieldPadding.wrapSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Custom header with info icon
          Row(
            children: [
              // Orange section indicator
              SvgPicture.asset(
                Assets.icons.general.sectionIndicator,
                width: HarvestCalculatorDesignConstants.sectionIndicatorWidth,
                height: HarvestCalculatorDesignConstants.sectionIndicatorHeight,
              ),
              const SizedBox(
                width: HarvestCalculatorDesignConstants.sectionHeaderGap,
              ),
              // Title
              Text(
                HarvestCalculatorConstants.sectionLoanRiskLTV,
                style: HarvestCalculatorDesignConstants.sectionTitleTextStyle
                    .copyWith(
                      fontWeight:
                          HarvestCalculatorDesignConstants.fontWeightSemibold,
                      color: HarvestCalculatorDesignConstants.textPrimary,
                    ),
              ),
              const SizedBox(
                width: HarvestCalculatorDesignConstants.sectionHeaderIconGap,
              ),
              // Info icon
              GestureDetector(
                onTap: () => _showLTVInfoBottomSheet(context),
                child: SvgPicture.asset(
                  Assets.icons.general.signInfo,
                  width: HarvestCalculatorDesignConstants.infoIconSize,
                  height: HarvestCalculatorDesignConstants.infoIconSize,
                  color: HarvestCalculatorDesignConstants.placeholderColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: HarvestCalculatorDesignConstants.sectionHeaderGap,
          ),
          // Fields
          SectionFieldPadding.wrap(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Gauge Chart
                SizedBox(
                  height: HarvestCalculatorDesignConstants.chartHeight,
                  child: Echarts(
                    option: _buildGaugeChartOption(
                      ltvPercentage,
                      riskData.status,
                      riskData.color,
                      riskData.statusTextColor,
                    ),
                    reloadAfterInit: true,
                  ),
                ),
                const SizedBox(
                  height: HarvestCalculatorDesignConstants.spacing16,
                ),
                // Legend with border
                Container(
                  padding: const EdgeInsets.all(
                    HarvestCalculatorDesignConstants.spacing16,
                  ),
                  decoration: BoxDecoration(
                    color: HarvestCalculatorDesignConstants.white,
                    borderRadius: BorderRadius.circular(
                      HarvestCalculatorDesignConstants
                          .legendContainerBorderRadius,
                    ),
                    border: Border.all(
                      color: HarvestCalculatorDesignConstants.gray20,
                    ),
                  ),
                  child: const Column(
                    children: [
                      // Top row: Ideal and Waspada
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _LegendItem(
                            color: HarvestCalculatorDesignConstants.success,
                            label: HarvestCalculatorConstants.labelLTVIdeal,
                          ),
                          _LegendItem(
                            color:
                                HarvestCalculatorDesignConstants.warningColor,
                            label: HarvestCalculatorConstants.labelLTVWarning,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: HarvestCalculatorDesignConstants.spacing12,
                      ),
                      // Bottom row: Resiko Tinggi
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _LegendItem(
                            color: HarvestCalculatorDesignConstants.error,
                            label: HarvestCalculatorConstants.labelLTVHighRisk,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: HarvestCalculatorDesignConstants.spacing16,
                ),
                // Status banner
                STPStatusBanner(
                  type: riskData.isIdeal
                      ? STPStatusBannerType.success
                      : STPStatusBannerType.info,
                  child: _buildLTVStatusMessage(ltvPercentage),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Calculates risk data based on LTV percentage.
  _LTVRiskData _calculateRiskData(double ltvPercentage) {
    final isIdeal =
        ltvPercentage < HarvestCalculatorConstants.ltvIdealThreshold;
    final isWarning =
        ltvPercentage >= HarvestCalculatorConstants.ltvWarningMin &&
        ltvPercentage <= HarvestCalculatorConstants.ltvWarningMax;

    if (isIdeal) {
      return const _LTVRiskData(
        status: HarvestCalculatorConstants.ltvRiskStatusIdeal,
        color: HarvestCalculatorDesignConstants.success,
        statusTextColor: HarvestCalculatorDesignConstants.black,
        isIdeal: true,
      );
    } else if (isWarning) {
      return const _LTVRiskData(
        status: HarvestCalculatorConstants.ltvRiskStatusWarning,
        color: HarvestCalculatorDesignConstants.warningColor,
        statusTextColor: HarvestCalculatorDesignConstants.warningColor,
        isIdeal: false,
      );
    } else {
      return const _LTVRiskData(
        status: HarvestCalculatorConstants.ltvRiskStatusHigh,
        color: HarvestCalculatorDesignConstants.error,
        statusTextColor: HarvestCalculatorDesignConstants.error,
        isIdeal: false,
      );
    }
  }

  /// Shows LTV info bottom sheet.
  void _showLTVInfoBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const LTVInfoBottomSheet(),
    );
  }

  /// Builds LTV status message with formatted percentage.
  Widget _buildLTVStatusMessage(double ltvPercentage) {
    return RichText(
      text: TextSpan(
        style: HarvestCalculatorDesignConstants.smallTextStyle.copyWith(
          height: 18 / HarvestCalculatorDesignConstants.fontSize12,
          color: HarvestCalculatorDesignConstants.success,
        ),
        children: [
          const TextSpan(
            text: HarvestCalculatorConstants.messageLTVHealthyPrefix,
          ),
          TextSpan(
            text: '${ltvPercentage.toCleanString()}%',
            style: const TextStyle(
              fontWeight: HarvestCalculatorDesignConstants.fontWeightBold,
            ),
          ),
          const TextSpan(
            text: HarvestCalculatorConstants.messageLTVHealthySuffix,
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
        '#${HarvestCalculatorDesignConstants.success.value.toRadixString(16).substring(2)}';
    final warningHex =
        '#${HarvestCalculatorDesignConstants.warningColor.value.toRadixString(16).substring(2)}';
    final errorHex =
        '#${HarvestCalculatorDesignConstants.error.value.toRadixString(16).substring(2)}';
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
          width: HarvestCalculatorDesignConstants.legendItemSize,
          height: HarvestCalculatorDesignConstants.legendItemSize,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
              HarvestCalculatorDesignConstants.legendItemBorderRadius,
            ),
          ),
        ),
        const SizedBox(width: HarvestCalculatorDesignConstants.legendItemGap),
        Text(
          label,
          style: HarvestCalculatorDesignConstants.smallTextSecondaryStyle,
        ),
      ],
    );
  }
}

/// Internal data class for LTV risk calculation.
class _LTVRiskData {
  const _LTVRiskData({
    required this.status,
    required this.color,
    required this.statusTextColor,
    required this.isIdeal,
  });

  final String status;
  final Color color;
  final Color statusTextColor;
  final bool isIdeal;
}
