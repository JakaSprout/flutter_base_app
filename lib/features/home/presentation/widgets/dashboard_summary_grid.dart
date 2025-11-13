import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/design_system/components/cards/stp_metric_card.dart';
import 'package:flutter_base_app/features/home/presentation/constants/home_constants.dart';
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

  // Maximum cards to show when collapsed
  static const int _maxVisibleCards = 4;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
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

  // Design tokens
  static const Color _secondaryColor = Color(
    0xFFFA6619,
  ); // Secondary/60 (Base) from Figma

  // Spacing constants - exact Figma specs
  static const double _gridSpacing = 8; // Figma: gap 8px
  static const double _fontSizeSmall = 12;
  static const double _lineHeight = 1.5; // Figma: lineHeight 1.5em
  static const double _spacingSmall = 8;

  @override
  Widget build(BuildContext context) {
    final activePondsCount =
        widget.activePonds ?? HomeConstants.defaultActivePonds;
    final subtitle = HomeConstants.activePondsSubtitle(activePondsCount);

    // Build all cards
    final allCards = _buildAllCards(subtitle);

    // Check if there are more cards to show
    final hasMoreCards = allCards.length > _maxVisibleCards;

    // Split cards into visible (first 4) and additional (rest)
    final visibleCards = allCards.take(_maxVisibleCards).toList();
    final additionalCards = allCards.skip(_maxVisibleCards).toList();

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
                const SizedBox(height: _gridSpacing),
                _buildGrid(additionalCards),
              ],
            ),
          ),
        // Toggle button (only show if there are more cards)
        if (hasMoreCards) ...[
          const SizedBox(height: _spacingSmall),
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
        iconPath: Assets.icons.general.paymentColor,
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
              const SizedBox(width: _gridSpacing),
              Expanded(child: rowCards[1]),
            ] else
              const Expanded(child: SizedBox.shrink()),
          ],
        ),
      );
      if (i + 2 < cards.length) {
        rows.add(const SizedBox(height: _gridSpacing));
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
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: _fontSizeSmall,
                    fontWeight: FontWeight.w600, // Semibold
                    color: _secondaryColor, // Secondary/60 (Base)
                    fontFamily: AppConstants.fontFamily,
                    height: _lineHeight,
                  ),
                ),
                const SizedBox(width: 2), // Figma: gap 2px
                Icon(icon, size: 24, color: _secondaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
