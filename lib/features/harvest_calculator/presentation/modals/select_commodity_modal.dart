import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter/material.dart';

/// Modal bottom sheet for selecting commodity.
class SelectCommodityModal extends StatefulWidget {
  /// Creates a new instance of [SelectCommodityModal].
  const SelectCommodityModal({
    required this.onSave,
    this.initialValue,
    super.key,
  });

  /// Initial selected value.
  final String? initialValue;

  /// Callback when save button is pressed with selected value.
  final ValueChanged<String> onSave;

  @override
  State<SelectCommodityModal> createState() => _SelectCommodityModalState();
}

class _SelectCommodityModalState extends State<SelectCommodityModal> {
  late String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      decoration: const BoxDecoration(
        color: HarvestCalculatorDesignConstants.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Handle bar
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: HarvestCalculatorDesignConstants.gray20,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Header with title and close button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          HarvestCalculatorConstants.titleSelectCommodity,
                          style: HarvestCalculatorDesignConstants
                              .cardTitleTextStyle,
                        ),
                        SizedBox(height: 4),
                        Text(
                          HarvestCalculatorConstants.subtitleSelectCommodity,
                          style: HarvestCalculatorDesignConstants.bodyTextStyle,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: HarvestCalculatorDesignConstants.gray60,
                      size: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            // Commodity options
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _CommodityOption(
                      label: HarvestCalculatorConstants.commodityShrimp,
                      isSelected:
                          _selectedValue ==
                          HarvestCalculatorConstants.commodityShrimp,
                      onTap: () {
                        setState(() {
                          _selectedValue =
                              HarvestCalculatorConstants.commodityShrimp;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    _CommodityOption(
                      label: HarvestCalculatorConstants.commodityTilapia,
                      isSelected:
                          _selectedValue ==
                          HarvestCalculatorConstants.commodityTilapia,
                      onTap: () {
                        setState(() {
                          _selectedValue =
                              HarvestCalculatorConstants.commodityTilapia;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    _CommodityOption(
                      label: HarvestCalculatorConstants.commodityNila,
                      isSelected:
                          _selectedValue ==
                          HarvestCalculatorConstants.commodityNila,
                      onTap: () {
                        setState(() {
                          _selectedValue =
                              HarvestCalculatorConstants.commodityNila;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Spacing before divider
            const SizedBox(height: 20),
            // Divider above button
            const Divider(
              height: 1,
              thickness: 1,
              color: HarvestCalculatorDesignConstants.gray20,
            ),
            // Save button without shadow
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: SafeArea(
                top: false,
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _selectedValue == null
                        ? null
                        : () {
                            widget.onSave(_selectedValue!);
                            Navigator.pop(context);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          HarvestCalculatorDesignConstants.primaryBlue,
                      foregroundColor: HarvestCalculatorDesignConstants.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      minimumSize: const Size(double.infinity, 56),
                    ),
                    child: const Text(
                      HarvestCalculatorConstants.buttonSave,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Option card for commodity selection.
class _CommodityOption extends StatelessWidget {
  /// Creates a new instance of [_CommodityOption].
  const _CommodityOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  /// Option label.
  final String label;

  /// Whether this option is selected.
  final bool isSelected;

  /// Callback when option is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: isSelected
              ? HarvestCalculatorDesignConstants
                    .simulationCardIconBackgroundBlue
              : HarvestCalculatorDesignConstants.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? HarvestCalculatorDesignConstants.primaryBlue
                : HarvestCalculatorDesignConstants.gray20,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          splashColor: HarvestCalculatorDesignConstants.gray20.withOpacity(0.3),
          highlightColor: HarvestCalculatorDesignConstants.gray20.withOpacity(
            0.1,
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Label text
                Expanded(
                  child: Text(
                    label,
                    style: HarvestCalculatorDesignConstants.bodyTextStyle
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(width: 12),
                // Radio button
                Radio<String>(
                  value: label,
                  groupValue: isSelected ? label : null,
                  onChanged: (_) => onTap(),
                  activeColor: HarvestCalculatorDesignConstants.primaryBlue,
                  fillColor: WidgetStateProperty.resolveWith<Color>((
                    Set<WidgetState> states,
                  ) {
                    if (states.contains(WidgetState.selected)) {
                      return HarvestCalculatorDesignConstants.primaryBlue;
                    }
                    return HarvestCalculatorDesignConstants.gray20;
                  }),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
