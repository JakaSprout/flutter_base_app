import 'package:app_mobile_afms/design_system/components/inputs/stp_date_picker_dropdown.dart';
import 'package:flutter/material.dart';

/// A date range picker widget with start and end date dropdowns.
///
/// This widget displays two date picker dropdowns side by side for
/// selecting a date range, matching the Figma design.
///
/// Example:
/// ```dart
/// STPDateRangePicker(
///   startDate: _startDate,
///   endDate: _endDate,
///   onStartDateChanged: (date) {
///     setState(() => _startDate = date);
///   },
///   onEndDateChanged: (date) {
///     setState(() => _endDate = date);
///   },
/// )
/// ```
class STPDateRangePicker extends StatelessWidget {
  /// Creates a new instance of [STPDateRangePicker].
  const STPDateRangePicker({
    required this.onStartDateChanged,
    required this.onEndDateChanged,
    super.key,
    this.startDate,
    this.endDate,
    this.startLabel = 'Tgl Mulai',
    this.endLabel = 'Tgl Akhir',
    this.startPlaceholder = 'Pilih',
    this.endPlaceholder = 'Akhir',
    this.firstDate,
    this.lastDate,
    this.enabled = true,
    this.dateFormat = 'dd/MM/yyyy',
  });

  /// Start date of the range
  final DateTime? startDate;

  /// End date of the range
  final DateTime? endDate;

  /// Callback when start date is selected
  final ValueChanged<DateTime> onStartDateChanged;

  /// Callback when end date is selected
  final ValueChanged<DateTime> onEndDateChanged;

  /// Label for start date picker (defaults to 'Tgl Mulai')
  final String startLabel;

  /// Label for end date picker (defaults to 'Tgl Akhir')
  final String endLabel;

  /// Placeholder for start date picker (defaults to 'Pilih')
  final String startPlaceholder;

  /// Placeholder for end date picker (defaults to 'Akhir')
  final String endPlaceholder;

  /// Earliest selectable date
  final DateTime? firstDate;

  /// Latest selectable date
  final DateTime? lastDate;

  /// Whether the pickers are enabled
  final bool enabled;

  /// Date format for display (defaults to 'dd/MM/yyyy')
  final String dateFormat;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Start date picker
        Expanded(
          child: STPDatePickerDropdown(
            label: startLabel,
            selectedDate: startDate,
            onDateSelected: onStartDateChanged,
            placeholder: startPlaceholder,
            firstDate: firstDate,
            lastDate: endDate ?? lastDate,
            enabled: enabled,
            dateFormat: dateFormat,
          ),
        ),
        const SizedBox(width: 12),
        // End date picker
        Expanded(
          child: STPDatePickerDropdown(
            label: endLabel,
            selectedDate: endDate,
            onDateSelected: onEndDateChanged,
            placeholder: endPlaceholder,
            firstDate: startDate ?? firstDate,
            lastDate: lastDate,
            enabled: enabled,
            dateFormat: dateFormat,
          ),
        ),
      ],
    );
  }
}
