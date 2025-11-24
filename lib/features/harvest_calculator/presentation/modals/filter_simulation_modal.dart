import 'package:app_mobile_afms/design_system/components/forms/stp_date_picker.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FilterOptions {
  FilterOptions({
    this.startDate,
    this.endDate,
    this.simulationTypes = const [],
    this.cycleTypes = const [],
    this.commodities = const [],
  });

  final DateTime? startDate;
  final DateTime? endDate;
  final List<String> simulationTypes;
  final List<String> cycleTypes;
  final List<String> commodities;

  int get count {
    // Refined count logic based on common behavior:
    int itemCount = 0;
    if (startDate != null || endDate != null) itemCount++;
    itemCount += simulationTypes.length;
    itemCount += cycleTypes.length;
    itemCount += commodities.length;
    return itemCount;
  }

  FilterOptions copyWith({
    DateTime? startDate,
    DateTime? endDate,
    List<String>? simulationTypes,
    List<String>? cycleTypes,
    List<String>? commodities,
  }) {
    return FilterOptions(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      simulationTypes: simulationTypes ?? this.simulationTypes,
      cycleTypes: cycleTypes ?? this.cycleTypes,
      commodities: commodities ?? this.commodities,
    );
  }
}

/// Modal bottom sheet for filtering simulations.
class FilterSimulationModal extends StatefulWidget {
  const FilterSimulationModal({
    required this.currentOptions,
    super.key,
  });

  final FilterOptions currentOptions;

  @override
  State<FilterSimulationModal> createState() => _FilterSimulationModalState();
}

class _FilterSimulationModalState extends State<FilterSimulationModal> {
  late DateTime? _startDate;
  late DateTime? _endDate;
  late List<String> _simulationTypes;
  late List<String> _cycleTypes;
  late List<String> _commodities;

  @override
  void initState() {
    super.initState();
    _startDate = widget.currentOptions.startDate;
    _endDate = widget.currentOptions.endDate;
    _simulationTypes = List.from(widget.currentOptions.simulationTypes);
    _cycleTypes = List.from(widget.currentOptions.cycleTypes);
    _commodities = List.from(widget.currentOptions.commodities);
  }

  void _resetFilters() {
    setState(() {
      _startDate = null;
      _endDate = null;
      _simulationTypes = [];
      _cycleTypes = [];
      _commodities = [];
    });
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final picked = await showSTPDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final picked = await showSTPDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Container(
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
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      HarvestCalculatorConstants.filterTitle,
                      style:
                          HarvestCalculatorDesignConstants.cardTitleTextStyle,
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
            
            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date Range
                    Text(
                      HarvestCalculatorConstants.filterDateRange,
                      style: HarvestCalculatorDesignConstants.sectionTitleTextStyle
                          .copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        // Start Date
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                HarvestCalculatorConstants.filterStartDate,
                                style: HarvestCalculatorDesignConstants.labelTextStyle,
                              ),
                              const SizedBox(height: 8),
                              InkWell(
                                onTap: () => _selectStartDate(context),
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: HarvestCalculatorDesignConstants.borderGray),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today_outlined,
                                        size: 18,
                                        color: HarvestCalculatorDesignConstants.gray60,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        _startDate != null
                                            ? dateFormat.format(_startDate!)
                                            : 'dd/mm/yyyy',
                                        style: _startDate != null
                                            ? HarvestCalculatorDesignConstants.bodyTextStyle
                                            : HarvestCalculatorDesignConstants.placeholderTextStyle,
                                      ),
                                      const Spacer(),
                                      const Icon(Icons.keyboard_arrow_down, color: HarvestCalculatorDesignConstants.gray60, size: 20),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        // End Date
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                HarvestCalculatorConstants.filterEndDate,
                                style: HarvestCalculatorDesignConstants.labelTextStyle,
                              ),
                              const SizedBox(height: 8),
                              InkWell(
                                onTap: () => _selectEndDate(context),
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: HarvestCalculatorDesignConstants.borderGray),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today_outlined,
                                        size: 18,
                                        color: HarvestCalculatorDesignConstants.gray60,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        _endDate != null
                                            ? dateFormat.format(_endDate!)
                                            : 'dd/mm/yyyy',
                                        style: _endDate != null
                                            ? HarvestCalculatorDesignConstants.bodyTextStyle
                                            : HarvestCalculatorDesignConstants.placeholderTextStyle,
                                      ),
                                      const Spacer(),
                                      const Icon(Icons.keyboard_arrow_down, color: HarvestCalculatorDesignConstants.gray60, size: 20),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Simulation Types
                    _buildCheckboxSection(
                      HarvestCalculatorConstants.filterSimulation,
                      [
                        HarvestCalculatorConstants.filterHarvestPlan,
                        HarvestCalculatorConstants.filterCreditProjection,
                      ],
                      _simulationTypes,
                    ),

                    const SizedBox(height: 24),
                    
                    // Cycle Types
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          HarvestCalculatorConstants.filterCycleType,
                          style: HarvestCalculatorDesignConstants.sectionTitleTextStyle.copyWith(fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _cycleTypes.clear();
                            });
                          },
                          child: Text(
                            'Reset',
                            style: HarvestCalculatorDesignConstants.smallTextStyle.copyWith(
                              color: HarvestCalculatorDesignConstants.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildCheckboxGroup(
                      [
                        HarvestCalculatorConstants.cycleTypeFull,
                        HarvestCalculatorConstants.cycleTypeMid,
                      ],
                      _cycleTypes,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Commodities
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          HarvestCalculatorConstants.filterCommodity,
                          style: HarvestCalculatorDesignConstants.sectionTitleTextStyle.copyWith(fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _commodities.clear();
                            });
                          },
                          child: Text(
                            'Reset',
                            style: HarvestCalculatorDesignConstants.smallTextStyle.copyWith(
                              color: HarvestCalculatorDesignConstants.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildCheckboxGroup(
                      [
                        HarvestCalculatorConstants.filterShrimpGalah,
                        HarvestCalculatorConstants.filterShrimpVaname,
                      ],
                      _commodities,
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Buttons
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: _resetFilters,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        HarvestCalculatorConstants.buttonResetFilters,
                        style: HarvestCalculatorDesignConstants.buttonTextStyle.copyWith(
                          color: HarvestCalculatorDesignConstants.error,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          FilterOptions(
                            startDate: _startDate,
                            endDate: _endDate,
                            simulationTypes: _simulationTypes,
                            cycleTypes: _cycleTypes,
                            commodities: _commodities,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HarvestCalculatorDesignConstants.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        HarvestCalculatorConstants.buttonSave,
                        style: HarvestCalculatorDesignConstants.buttonTextStyle.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxSection(String title, List<String> options, List<String> selectedValues) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: HarvestCalculatorDesignConstants.sectionTitleTextStyle.copyWith(fontSize: 14),
        ),
        const SizedBox(height: 12),
        _buildCheckboxGroup(options, selectedValues),
      ],
    );
  }

  Widget _buildCheckboxGroup(List<String> options, List<String> selectedValues) {
    return Column(
      children: options.map((option) {
        final isSelected = selectedValues.contains(option);
        return InkWell(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedValues.remove(option);
              } else {
                selectedValues.add(option);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    option,
                    style: HarvestCalculatorDesignConstants.bodyTextStyle,
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: isSelected
                          ? HarvestCalculatorDesignConstants.primary
                          : HarvestCalculatorDesignConstants.gray60,
                      width: 2,
                    ),
                    color: isSelected
                        ? HarvestCalculatorDesignConstants.primary
                        : Colors.transparent,
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
