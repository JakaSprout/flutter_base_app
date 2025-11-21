import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:flutter_base_app/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter_base_app/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Data model for a partial harvest plan.
class _PartialHarvestPlan {
  _PartialHarvestPlan({
    required this.id,
    required this.docController,
    required this.percentageController,
  });

  /// Unique identifier for this harvest plan.
  final String id;

  /// Text editing controller for DOC value.
  final TextEditingController docController;

  /// Text editing controller for percentage value.
  final TextEditingController percentageController;

  /// Dispose controllers.
  void dispose() {
    docController.dispose();
    percentageController.dispose();
  }
}

/// Modal bottom sheet for partial harvest configuration.
class PartialHarvestModal extends StatefulWidget {
  /// Creates a new instance of [PartialHarvestModal].
  const PartialHarvestModal({super.key});

  @override
  State<PartialHarvestModal> createState() => _PartialHarvestModalState();
}

class _PartialHarvestModalState extends State<PartialHarvestModal> {
  /// List of partial harvest plans (Panen 1, Panen 2, etc.)
  final List<_PartialHarvestPlan> _harvestPlans = [];

  /// Controller for Panen Raya DOC (always present).
  late final TextEditingController _mainHarvestDocController;

  /// Controller for Panen Raya percentage (always present).
  late final TextEditingController _mainHarvestPercentageController;

  /// Counter for generating unique IDs.
  int _idCounter = 0;

  @override
  void initState() {
    super.initState();
    _mainHarvestDocController = TextEditingController(text: '120');
    _mainHarvestPercentageController = TextEditingController(text: '100');

    // Initialize with 2 harvest plans as default
    _addHarvestPlan(doc: '30', percentage: '50');
    _addHarvestPlan(doc: '50', percentage: '50');
  }

  @override
  void dispose() {
    _mainHarvestDocController.dispose();
    _mainHarvestPercentageController.dispose();
    for (final plan in _harvestPlans) {
      plan.dispose();
    }
    super.dispose();
  }

  /// Adds a new harvest plan to the list.
  void _addHarvestPlan({String doc = '', String percentage = ''}) {
    setState(() {
      _harvestPlans.add(
        _PartialHarvestPlan(
          id: 'harvest_${_idCounter++}',
          docController: TextEditingController(text: doc),
          percentageController: TextEditingController(text: percentage),
        ),
      );
    });
  }

  /// Removes a harvest plan by index.
  void _removeHarvestPlan(int index) {
    if (index >= 0 && index < _harvestPlans.length) {
      setState(() {
        _harvestPlans.removeAt(index).dispose();
      });
    }
  }

  /// Gets the display title for a harvest plan at the given index.
  String _getHarvestTitle(int index) {
    return 'Panen ${index + 1}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
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
                  color: AppColors.gray20,
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
                          HarvestCalculatorConstants.labelPartialHarvest,
                          style: HarvestCalculatorDesignConstants
                              .cardTitleTextStyle,
                        ),
                        SizedBox(height: 4),
                        Text(
                          HarvestCalculatorConstants.subtitlePartialHarvest,
                          style: HarvestCalculatorDesignConstants.bodyTextStyle,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.gray60,
                      size: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Harvest sections
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Dynamic partial harvest plans
                    ...List.generate(
                      _harvestPlans.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(
                          bottom: index < _harvestPlans.length - 1 ? 16 : 16,
                        ),
                        child: HarvestSectionCard(
                          title: _getHarvestTitle(index),
                          docController: _harvestPlans[index].docController,
                          percentageController:
                              _harvestPlans[index].percentageController,
                          showDelete: true,
                          onDelete: () => _removeHarvestPlan(index),
                        ),
                      ),
                    ),
                    // Panen Raya (always present)
                    HarvestSectionCard(
                      title: HarvestCalculatorConstants.labelMainHarvest,
                      docController: _mainHarvestDocController,
                      percentageController: _mainHarvestPercentageController,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            // Add harvest plan button
            // Bottom padding consistent with STPBottomActionButton
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: OutlinedButton.icon(
                onPressed: _addHarvestPlan,
                icon: const Icon(Icons.add, size: 20, color: AppColors.gray60),
                label: const Text(
                  HarvestCalculatorConstants.buttonAddHarvestPlan,
                  style: HarvestCalculatorDesignConstants.bodyTextStyle,
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  backgroundColor: AppColors.white,
                  foregroundColor: HarvestCalculatorDesignConstants.textPrimary,
                  side: const BorderSide(color: AppColors.gray20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Card widget for harvest section (Panen 1, Panen 2, Panen Raya).
class HarvestSectionCard extends StatelessWidget {
  /// Creates a new instance of [HarvestSectionCard].
  const HarvestSectionCard({
    required this.title,
    required this.docController,
    required this.percentageController,
    this.showDelete = false,
    this.onDelete,
    super.key,
  });

  /// Section title (Panen 1, Panen 2, Panen Raya).
  final String title;

  /// Text editing controller for DOC value.
  final TextEditingController docController;

  /// Text editing controller for percentage value.
  final TextEditingController percentageController;

  /// Whether to show delete button.
  final bool showDelete;

  /// Callback when delete is pressed.
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.gray05,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.gray20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title with delete button
          Row(
            children: [
              Text(
                title,
                style: HarvestCalculatorDesignConstants.bodyTextStyle.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (showDelete) ...[
                const Spacer(),
                IconButton(
                  icon: SvgPicture.asset(
                    Assets.icons.general.trash,
                    width: 20,
                    height: 20,
                    color: AppColors.gray60,
                  ),
                  onPressed: onDelete,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          // Fields row
          Row(
            children: [
              Expanded(
                child: HarvestField(
                  label: HarvestCalculatorConstants.labelDOC,
                  controller: docController,
                  unit: 'hari',
                  isRequired: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: HarvestField(
                  label: HarvestCalculatorConstants.labelHarvestPercentage,
                  controller: percentageController,
                  unit: '%',
                  isRequired: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Field widget for harvest section (DOC or Percentage).
class HarvestField extends StatelessWidget {
  /// Creates a new instance of [HarvestField].
  const HarvestField({
    required this.label,
    required this.controller,
    required this.unit,
    this.isRequired = false,
    super.key,
  });

  /// Field label.
  final String label;

  /// Text editing controller.
  final TextEditingController controller;

  /// Unit suffix.
  final String unit;

  /// Whether the field is required.
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label with required indicator
        Row(
          children: [
            if (isRequired) ...[
              const Text(
                '*',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: HarvestCalculatorDesignConstants.errorColor,
                ),
              ),
              const SizedBox(width: 2),
            ],
            Text(
              label,
              style: HarvestCalculatorDesignConstants.smallTextStyle.copyWith(
                height: 1.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Field
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: AppColors.gray20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  style: HarvestCalculatorDesignConstants.bodyTextStyle,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              Text(unit, style: HarvestCalculatorDesignConstants.bodyTextStyle),
            ],
          ),
        ),
      ],
    );
  }
}
