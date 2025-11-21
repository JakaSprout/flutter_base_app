import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/design_system/components/cards/stp_metric_card.dart';
import 'package:flutter_base_app/features/home/presentation/constants/home_constants.dart';
import 'package:flutter_base_app/features/home/presentation/constants/home_design_constants.dart';
import 'package:flutter_base_app/gen/assets.gen.dart';

/// Dashboard summary cards grid container.
///
/// Displays cards in a 2x2 grid layout (max 4 visible when collapsed).
/// Shows "Tampilkan Semua" to expand and "Sembunyikan" to collapse.
class DashboardSummaryGrid extends StatefulWidget {
  /// Creates a new instance of [DashboardSummaryGrid].
  const DashboardSummaryGrid({
    super.key,
    this.onShowAllTap,
    this.estimasiBiomassa,
    this.totalPakan,
    this.biayaPakan,
    this.estimasiSR,
    this.activePonds,
  });

  /// Callback when "Tampilkan Semua" is tapped (optional, uses internal toggle if not provided)
  final VoidCallback? onShowAllTap;

  /// Estimasi Biomassa value
  final String? estimasiBiomassa;

  /// Total Pakan value
  final String? totalPakan;

  /// Biaya Pakan value
  final String? biayaPakan;

  /// Estimasi SR value
  final String? estimasiSR;

  /// Number of active ponds for subtitle
  final int? activePonds;

  @override
  State<DashboardSummaryGrid> createState() => _DashboardSummaryGridState();
}

class _DashboardSummaryGridState extends State<DashboardSummaryGrid>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: HomeDesignConstants.dashboardAnimationDurationMs,
      ),
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
    // Call external callback if provided
    widget.onShowAllTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final activePondsCount =
        widget.activePonds ?? HomeConstants.defaultActivePonds;
    final subtitle = HomeConstants.activePondsSubtitle(activePondsCount);

    // Build all cards
    final allCards = _buildAllCards(subtitle);

    // Check if there are more cards to show
    final hasMoreCards =
        allCards.length > HomeDesignConstants.dashboardMaxVisibleCards;

    // Split cards into visible (first 4) and additional (rest)
    final visibleCards = allCards
        .take(HomeDesignConstants.dashboardMaxVisibleCards)
        .toList();
    final additionalCards = allCards
        .skip(HomeDesignConstants.dashboardMaxVisibleCards)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Grid - always show first 4 cards (2x2 layout)
        _buildGrid(visibleCards),
        // Collapsible section for additional cards (if any)
        if (hasMoreCards)
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: Column(
              children: [
                const SizedBox(
                  height: HomeDesignConstants.dashboardGridSpacing,
                ),
                _buildGrid(additionalCards),
              ],
            ),
          ),
        // Toggle button (only show if there are more cards)
        if (hasMoreCards) ...[
          const SizedBox(height: HomeDesignConstants.dashboardSpacingSmall),
          _buildToggleButton(context),
        ],
      ],
    );
  }

  /// Builds list of all metric cards
  List<STPMetricCard> _buildAllCards(String subtitle) {
    return [
      STPMetricCard(
        iconPath: Assets.icons.general.weightColor,
        title: HomeConstants.cardEstimasiBiomassaTitle,
        value: widget.estimasiBiomassa ?? HomeConstants.defaultEstimasiBiomassa,
        unit: 'kg',
        subtitle: subtitle,
      ),
      STPMetricCard(
        iconPath: Assets.icons.general.packageColor,
        title: HomeConstants.cardTotalPakanTitle,
        value: widget.totalPakan ?? HomeConstants.defaultTotalPakan,
        unit: 'kg',
        subtitle: subtitle,
      ),
      STPMetricCard(
        iconPath: Assets.icons.general.paymentNegative,
        title: HomeConstants.cardBiayaPakanTitle,
        value: widget.biayaPakan ?? HomeConstants.defaultBiayaPakan,
        unit: 'juta',
        subtitle: subtitle,
      ),
      STPMetricCard(
        iconPath: Assets.icons.general.earningsColor,
        title: HomeConstants.cardEstimasiSRTitle,
        value: widget.estimasiSR ?? HomeConstants.defaultEstimasiSR,
        unit: '%',
        subtitle: subtitle,
      ),
      // Additional cards (will be hidden when collapsed)
      STPMetricCard(
        iconPath: Assets.icons.general.waterQuality,
        title: 'Kualitas Air',
        value: '7.5',
        unit: 'pH',
        subtitle: subtitle,
      ),
      STPMetricCard(
        iconPath: Assets.icons.general.feed,
        title: 'Rata-rata Pakan',
        value: '150',
        unit: 'kg/hari',
        subtitle: subtitle,
      ),
      STPMetricCard(
        iconPath: Assets.icons.general.waterQuality,
        title: 'Kualitas Air',
        value: '7.5',
        unit: 'pH',
        subtitle: subtitle,
      ),
    ];
  }

  /// Builds grid layout for cards (2x2 per row)
  Widget _buildGrid(List<STPMetricCard> cards) {
    if (cards.isEmpty) return const SizedBox.shrink();

    final rows = <Widget>[];
    for (var i = 0; i < cards.length; i += 2) {
      final rowCards = cards.skip(i).take(2).toList();
      rows.add(
        Row(
          children: [
            Expanded(child: rowCards[0]),
            if (rowCards.length > 1) ...[
              const SizedBox(width: HomeDesignConstants.dashboardGridSpacing),
              Expanded(child: rowCards[1]),
            ] else
              const Expanded(child: SizedBox.shrink()),
          ],
        ),
      );
      if (i + 2 < cards.length) {
        rows.add(
          const SizedBox(height: HomeDesignConstants.dashboardGridSpacing),
        );
      }
    }

    return Column(children: rows);
  }

  /// Builds toggle button (Tampilkan Semua / Sembunyikan)
  Widget _buildToggleButton(BuildContext context) {
    final label = _isExpanded
        ? HomeConstants.hideLabel
        : HomeConstants.showAllLabel;
    final icon = _isExpanded
        ? Icons.keyboard_arrow_up
        : Icons.keyboard_arrow_down;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _toggleExpand,
          borderRadius: BorderRadius.circular(
            HomeDesignConstants.dashboardToggleBorderRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: HomeDesignConstants.dashboardTogglePaddingHorizontal,
              vertical: HomeDesignConstants.dashboardTogglePaddingVertical,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: HomeDesignConstants.dashboardToggleFontSize,
                    fontWeight: FontWeight.w600,
                    color: HomeDesignConstants.dashboardSecondaryColor,
                    fontFamily: AppConstants.fontFamily,
                    height: HomeDesignConstants.dashboardToggleLineHeight,
                  ),
                ),
                const SizedBox(
                  width: HomeDesignConstants.dashboardToggleSpacing,
                ),
                Icon(
                  icon,
                  size: HomeDesignConstants.dashboardToggleIconSize,
                  color: HomeDesignConstants.dashboardSecondaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
