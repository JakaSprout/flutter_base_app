import 'package:app_mobile_afms/design_system/components/forms/stp_date_picker.dart';
import 'package:app_mobile_afms/features/lab_request/domain/entities/lab_request_status.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_constants.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_design_constants.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/modals/lab_request_filter_options.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Modal bottom sheet for filtering lab requests.
class LabRequestFilterModal extends StatefulWidget {
  /// Creates a new instance of [LabRequestFilterModal].
  const LabRequestFilterModal({
    required this.currentOptions,
    super.key,
  });

  final LabRequestFilterOptions currentOptions;

  @override
  State<LabRequestFilterModal> createState() => _LabRequestFilterModalState();
}

class _LabRequestFilterModalState extends State<LabRequestFilterModal> {
  late DateTime? _startDate;
  late DateTime? _endDate;
  late List<LabRequestStatus> _statuses;

  @override
  void initState() {
    super.initState();
    _startDate = widget.currentOptions.startDate;
    _endDate = widget.currentOptions.endDate;
    _statuses = List.from(widget.currentOptions.statuses);
  }

  void _resetFilters() {
    setState(() {
      _startDate = null;
      _endDate = null;
      _statuses = [];
    });
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final picked = await showSTPDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 30)),
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
      firstDate: _startDate ?? DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  void _toggleStatus(LabRequestStatus status) {
    setState(() {
      if (_statuses.contains(status)) {
        _statuses.remove(status);
      } else {
        _statuses.add(status);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: LabRequestDesignConstants.white,
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
                  color: LabRequestDesignConstants.gray20,
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
                      LabRequestConstants.buttonFilter,
                      style: const TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: LabRequestDesignConstants.gray100,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: LabRequestDesignConstants.gray60,
                      size: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            // Date Range Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rentang Tanggal',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: LabRequestDesignConstants.gray100,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectStartDate(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: LabRequestDesignConstants.gray20,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  _startDate != null
                                      ? DateFormat('dd/MM/yyyy').format(_startDate!)
                                      : 'Dari',
                                  style: TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontSize: 14,
                                    color: _startDate != null
                                        ? LabRequestDesignConstants.gray100
                                        : LabRequestDesignConstants.gray60,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        LabRequestConstants.filterTo,
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 14,
                          color: LabRequestDesignConstants.gray70,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectEndDate(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: LabRequestDesignConstants.gray20,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  _endDate != null
                                      ? DateFormat('dd/MM/yyyy').format(_endDate!)
                                      : 'Sampai',
                                  style: TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontSize: 14,
                                    color: _endDate != null
                                        ? LabRequestDesignConstants.gray100
                                        : LabRequestDesignConstants.gray60,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Status Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Status',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: LabRequestDesignConstants.gray100,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: LabRequestStatus.values.map((status) {
                      final isSelected = _statuses.contains(status);
                      return GestureDetector(
                        onTap: () => _toggleStatus(status),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Color(int.parse('0xFF${status.backgroundColor.replaceFirst('#', '')}'))
                                : LabRequestDesignConstants.white,
                            border: Border.all(
                              color: Color(int.parse('0xFF${status.color.replaceFirst('#', '')}')),
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            status.displayName,
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(int.parse('0xFF${status.color.replaceFirst('#', '')}')),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _resetFilters,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(
                          color: LabRequestDesignConstants.gray20,
                        ),
                      ),
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: LabRequestDesignConstants.gray100,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final result = LabRequestFilterOptions(
                          startDate: _startDate,
                          endDate: _endDate,
                          statuses: _statuses,
                        );
                        Navigator.pop(context, result);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: LabRequestDesignConstants.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        LabRequestConstants.buttonSave,
                        style: const TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: LabRequestDesignConstants.white,
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
}





