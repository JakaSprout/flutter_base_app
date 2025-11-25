import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/design_system/components/inputs/stp_dropdown.dart';
import 'package:app_mobile_afms/features/home/presentation/constants/home_constants.dart';
import 'package:app_mobile_afms/features/home/presentation/constants/home_design_constants.dart';
import 'package:flutter/material.dart';

/// Farm Selection section for Home screen.
///
/// Displays a label "Pilih Farm" with a dropdown for farm selection.
class FarmSelectionSection extends StatefulWidget {
  /// Creates a new instance of [FarmSelectionSection].
  const FarmSelectionSection({
    super.key,
    this.selectedFarm,
    this.farms,
    this.onFarmChanged,
  });

  /// Currently selected farm name.
  final String? selectedFarm;

  /// List of available farms for dropdown.
  /// If null, defaults to [HomeConstants.defaultFarmName]
  final List<String>? farms;

  /// Callback when farm selection is changed.
  /// Receives the selected farm name.
  final ValueChanged<String>? onFarmChanged;

  @override
  State<FarmSelectionSection> createState() =>
      _FarmSelectionSectionState();
}

class _FarmSelectionSectionState extends State<FarmSelectionSection> {
  String? _selectedFarm;

  @override
  void initState() {
    super.initState();
    _selectedFarm =
        widget.selectedFarm ??
        widget.farms?.firstOrNull ??
        HomeConstants.defaultFarmName;
  }

  @override
  void didUpdateWidget(FarmSelectionSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedFarm != oldWidget.selectedFarm) {
      _selectedFarm =
          widget.selectedFarm ??
          widget.farms?.firstOrNull ??
          HomeConstants.defaultFarmName;
    }
  }

  @override
  Widget build(BuildContext context) {
    final farms =
        widget.farms ??
        [HomeConstants.defaultFarmName]; // Default list if not provided

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label "Pilih Farm"
        Text(
          HomeConstants.farmSelectionLabel,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontSize: HomeDesignConstants.farmSelectionLabelFontSize,
            fontWeight: FontWeight.w400,
            color: HomeDesignConstants.gray100,
            fontFamily: AppConstants.fontFamily,
            height: HomeDesignConstants.farmSelectionLineHeight,
          ),
        ),
        const SizedBox(
          height: HomeDesignConstants.farmSelectionLabelSpacing,
        ),
        // Dropdown
        STPDropdown<String>(
          items: farms,
          selectedValue: _selectedFarm,
          onChanged: (String selectedFarm) {
            setState(() {
              _selectedFarm = selectedFarm;
            });
            widget.onFarmChanged?.call(selectedFarm);
          },
          colors: const STPDropdownColors.gray(),
          hint: HomeConstants.defaultFarmName,
        ),
      ],
    );
  }
}

