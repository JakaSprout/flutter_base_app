import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/design_system/components/inputs/stp_dropdown.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/home/presentation/constants/home_constants.dart';

/// Block filter section for Home screen.
///
/// Contains:
/// - Label: "Blok yang ditampilkan"
/// - Dropdown field for selecting block
class BlockFilter extends StatefulWidget {
  /// Creates a new instance of [BlockFilter].
  const BlockFilter({
    super.key,
    this.onBlockChanged,
    this.selectedBlock,
    this.blocks,
  });

  /// Callback when block selection is changed.
  /// Receives the selected block name.
  final ValueChanged<String>? onBlockChanged;

  /// Current selected block name to display.
  final String? selectedBlock;

  /// List of available blocks for dropdown.
  /// If null, defaults to [HomeConstants.defaultBlock]
  final List<String>? blocks;

  @override
  State<BlockFilter> createState() => _BlockFilterState();
}

class _BlockFilterState extends State<BlockFilter> {
  String? _selectedBlock;

  // Design tokens - using shared colors from design system
  static const Color _gray100 = AppColors.gray100;

  // Widget-specific spacing constants - exact Figma specs
  static const double _spacingSmall = 8; // Figma: gap 8px
  static const double _fontSizeMedium =
      16; // Figma: Body/Small/Medium/Semibold - fontSize 16
  static const double _lineHeight = 1.5; // Figma: lineHeight 1.5em

  // Default values - using feature constants
  static const String _defaultBlock = HomeConstants.defaultBlock;
  static const String _label = HomeConstants.blockFilterLabel;

  @override
  void initState() {
    super.initState();
    _selectedBlock =
        widget.selectedBlock ?? widget.blocks?.firstOrNull ?? _defaultBlock;
  }

  @override
  void didUpdateWidget(BlockFilter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedBlock != oldWidget.selectedBlock) {
      _selectedBlock =
          widget.selectedBlock ?? widget.blocks?.firstOrNull ?? _defaultBlock;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          _label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: _fontSizeMedium,
            fontWeight: FontWeight.w600, // Semibold
            color: _gray100,
            fontFamily: AppConstants.fontFamily,
            height: _lineHeight,
          ),
        ),
        const SizedBox(height: _spacingSmall),
        // Dropdown Field
        _buildDropdownField(context),
      ],
    );
  }

  /// Builds the block dropdown field using STPDropdown.
  Widget _buildDropdownField(BuildContext context) {
    final blocks =
        widget.blocks ?? [_defaultBlock]; // Default list if not provided

    return STPDropdown<String>(
      items: blocks,
      selectedValue: _selectedBlock,
      onChanged: (String selectedBlock) {
        setState(() {
          _selectedBlock = selectedBlock;
        });
        widget.onBlockChanged?.call(selectedBlock);
      },
      colors: const STPDropdownColors.gray(),
      hint: _defaultBlock,
    );
  }
}
