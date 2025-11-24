import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/harvest_summary.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/simulation_parameters.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';
import 'package:flutter/material.dart';
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
  const PartialHarvestModal({
    super.key,
    this.automaticHarvestDoc,
    this.harvestSummaries,
    this.targetDOC,
    this.initialCustomHarvestEvents,
  });

  /// DOC when automatic harvest occurred (from simulation result)
  final int? automaticHarvestDoc;

  /// Harvest summaries from simulation result
  final List<HarvestSummary>? harvestSummaries;

  /// Target DOC for final harvest
  final int? targetDOC;

  /// Previously configured custom harvest events (for persistence)
  final List<HarvestEvent>? initialCustomHarvestEvents;

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

    // Initialize main harvest (Panen Raya) with targetDOC
    final targetDocText = widget.targetDOC?.toString() ?? '120';
    _mainHarvestDocController = TextEditingController(text: targetDocText);
    _mainHarvestPercentageController = TextEditingController(text: '100');

    // Initialize harvest plans
    _initializeHarvestPlans();
  }

  /// Initialize harvest plans with DOC values from custom events (persisted) or from simulation results
  void _initializeHarvestPlans() {
    // PRIORITY 1: Use custom events if provided
    if (widget.initialCustomHarvestEvents != null &&
        widget.initialCustomHarvestEvents!.isNotEmpty) {
      for (final event in widget.initialCustomHarvestEvents!) {
        _addHarvestPlan(
          doc: event.doc.toString(),
          percentage: event.percentage.toString(),
        );
      }
      return;
    }

    // PRIORITY 2: Use simulation results as fallback (first open, auto mode)
    if (widget.harvestSummaries != null &&
        widget.harvestSummaries!.isNotEmpty) {
      // Filter out Panen Raya from harvest summaries
      final partialHarvests = widget.harvestSummaries!
          .where(
            (summary) => !summary.description.toLowerCase().contains('raya'),
          )
          .toList();

      // Add existing partial harvests
      for (final harvest in partialHarvests.take(2)) {
        // Max 2 partial harvests
        _addHarvestPlan(
          doc: harvest.doc.toString(),
          percentage: harvest.percentage.toString(),
        );
      }

      // If we have less than 2 harvests, add default ones
      while (_harvestPlans.length < 2) {
        final defaultDoc = _harvestPlans.isEmpty ? '60' : '90';
        _addHarvestPlan(doc: defaultDoc, percentage: '50');
      }
    } else {
      // No simulation data, use defaults
      _addHarvestPlan(doc: '60', percentage: '50'); // Panen 1
      _addHarvestPlan(doc: '90', percentage: '50'); // Panen 2
    }
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

  /// Converts current harvest plans to List<HarvestEvent>
  List<HarvestEvent> _convertToHarvestEvents() {
    final events = <HarvestEvent>[];

    // Add partial harvest plans
    for (final plan in _harvestPlans) {
      final doc = int.tryParse(plan.docController.text);
      final percentage = double.tryParse(plan.percentageController.text);

      if (doc != null && percentage != null && doc > 0 && percentage > 0) {
        events.add(HarvestEvent(doc: doc, percentage: percentage));
      }
    }

    // Sort by DOC ascending
    events.sort((a, b) => a.doc.compareTo(b.doc));

    return events;
  }

  /// Validates and submits harvest plans
  void _submitHarvestPlans() {
    final events = _convertToHarvestEvents();

    debugPrint(
      '🔄 [PartialHarvestModal] Submitting ${events.length} harvest events',
    );
    for (final event in events) {
      debugPrint('   - DOC: ${event.doc}, Percentage: ${event.percentage}%');
    }

    // Validate that all harvest DOCs are before main harvest DOC
    final mainHarvestDoc = int.tryParse(_mainHarvestDocController.text);
    if (mainHarvestDoc == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('DOC Panen Raya harus diisi'),
          backgroundColor: HarvestCalculatorDesignConstants.errorColor,
        ),
      );
      return;
    }

    debugPrint('🔄 [PartialHarvestModal] Main Harvest DOC: $mainHarvestDoc');

    // Check if any partial harvest DOC is >= main harvest DOC
    final invalidHarvests = events
        .where((e) => e.doc >= mainHarvestDoc)
        .toList();
    if (invalidHarvests.isNotEmpty) {
      debugPrint(
        '❌ [PartialHarvestModal] Invalid harvests found: ${invalidHarvests.length}',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'DOC panen parsial harus lebih kecil dari DOC Panen Raya ($mainHarvestDoc)',
          ),
          backgroundColor: HarvestCalculatorDesignConstants.errorColor,
        ),
      );
      return;
    }

    debugPrint('✅ [PartialHarvestModal] Returning events to results screen');
    // Return harvest events to previous screen
    Navigator.pop(context, {
      'harvestEvents': events,
      'targetDOC': mainHarvestDoc,
    });
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
                    // Panen Raya (always present, fixed at targetDOC)
                    HarvestSectionCard(
                      title: HarvestCalculatorConstants.labelMainHarvest,
                      docController: _mainHarvestDocController,
                      percentageController: _mainHarvestPercentageController
                        ..text = '100',
                      isPercentageDisabled: true,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            // Add harvest plan button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              child: OutlinedButton.icon(
                onPressed: _addHarvestPlan,
                icon: const Icon(
                  Icons.add,
                  size: 20,
                  color: HarvestCalculatorDesignConstants.gray60,
                ),
                label: const Text(
                  HarvestCalculatorConstants.buttonAddHarvestPlan,
                  style: HarvestCalculatorDesignConstants.bodyTextStyle,
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  backgroundColor: HarvestCalculatorDesignConstants.white,
                  foregroundColor: HarvestCalculatorDesignConstants.textPrimary,
                  side: const BorderSide(
                    color: HarvestCalculatorDesignConstants.gray20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
            ),
            // Submit button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: ElevatedButton(
                onPressed: _submitHarvestPlans,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: HarvestCalculatorDesignConstants.primaryBlue,
                  foregroundColor: HarvestCalculatorDesignConstants.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Terapkan Perubahan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
    this.isPercentageDisabled = false,
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

  final bool isPercentageDisabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: HarvestCalculatorDesignConstants.gray05,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: HarvestCalculatorDesignConstants.gray20),
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
                    color: HarvestCalculatorDesignConstants.gray60,
                  ),
                  onPressed: onDelete,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          // Show explanation for automatic harvest timing
          Text(
            'DOC dihitung otomatis berdasarkan kapasitas kolam',
            style: HarvestCalculatorDesignConstants.smallTextStyle.copyWith(
              color: HarvestCalculatorDesignConstants.gray60,
              fontSize: 12,
            ),
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
                  enabled: !isPercentageDisabled,
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
    this.enabled = true,
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

  final bool enabled;

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
            color: HarvestCalculatorDesignConstants.white,
            border: Border.all(color: HarvestCalculatorDesignConstants.gray20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  style: HarvestCalculatorDesignConstants.bodyTextStyle,
                  enabled: enabled,
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
