import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/components/forms/stp_date_picker.dart';
import 'package:flutter_base_app/design_system/components/forms/stp_form_input_field.dart';
import 'package:intl/intl.dart';

/// Date picker form field widget for lab request form.
///
/// Uses design system STPFormInputField for consistency.
class LabRequestDatePickerFormField extends StatefulWidget {
  /// Creates a new instance of [LabRequestDatePickerFormField].
  const LabRequestDatePickerFormField({
    required this.label,
    required this.selectedDate,
    required this.onDateSelected,
    this.isRequired = true,
    super.key,
  });

  /// Field label
  final String label;

  /// Selected date
  final DateTime? selectedDate;

  /// Callback when date is selected
  final ValueChanged<DateTime?> onDateSelected;

  /// Whether the field is required
  final bool isRequired;

  @override
  State<LabRequestDatePickerFormField> createState() =>
      _LabRequestDatePickerFormFieldState();
}

class _LabRequestDatePickerFormFieldState
    extends State<LabRequestDatePickerFormField> {
  bool _isPickerOpen = false;

  @override
  Widget build(BuildContext context) {
    final label = widget.label;
    final selectedDate = widget.selectedDate;
    final isRequired = widget.isRequired;
    final onDateSelected = widget.onDateSelected;

    var formattedValue = '';
    IconData? fieldIcon;

    if (label.toLowerCase().contains('tanggal') ||
        label.toLowerCase().contains('date')) {
      formattedValue = selectedDate != null
          ? DateFormat('dd MMM yyyy').format(selectedDate)
          : '';
      fieldIcon = Icons.calendar_today;
    } else if (label.toLowerCase().contains('waktu') ||
        label.toLowerCase().contains('time')) {
      formattedValue = selectedDate != null
          ? DateFormat('HH:mm').format(selectedDate)
          : '';
      fieldIcon = Icons.access_time;
    } else {
      formattedValue = selectedDate != null
          ? DateFormat('dd MMM yyyy HH:mm').format(selectedDate)
          : '';
      fieldIcon = Icons.calendar_today;
    }

    return STPFormInputField(
      label: label,
      value: formattedValue,
      isRequired: isRequired,
      icon: fieldIcon,
      onTap: _isPickerOpen
          ? null
          : () async {
              if (_isPickerOpen || !mounted) return;
              
              // Set flag before opening picker
              setState(() {
                _isPickerOpen = true;
              });

              try {
                if (label.toLowerCase().contains('tanggal') ||
                    label.toLowerCase().contains('date')) {
                  final date = await showSTPDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (date != null && context.mounted) {
                    final existingTime = selectedDate;
                    onDateSelected(
                      DateTime(
                        date.year,
                        date.month,
                        date.day,
                        existingTime?.hour ?? 0,
                        existingTime?.minute ?? 0,
                      ),
                    );
                  }
                } else if (label.toLowerCase().contains('waktu') ||
                    label.toLowerCase().contains('time')) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: selectedDate != null
                        ? TimeOfDay.fromDateTime(selectedDate)
                        : TimeOfDay.now(),
                  );
                  // Reset flag immediately after dialog closes, before callback
                  if (mounted) {
                    setState(() {
                      _isPickerOpen = false;
                    });
                  }
                  if (time != null && context.mounted) {
                    // Use selectedDate if available, otherwise use today's date
                    final baseDate = selectedDate ?? DateTime.now();
                    onDateSelected(
                      DateTime(
                        baseDate.year,
                        baseDate.month,
                        baseDate.day,
                        time.hour,
                        time.minute,
                      ),
                    );
                  }
                } else {
                  // Default: date and time picker
                  final date = await showSTPDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (date != null && context.mounted) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: selectedDate != null
                          ? TimeOfDay.fromDateTime(selectedDate)
                          : TimeOfDay.now(),
                    );
                    if (time != null && context.mounted) {
                      onDateSelected(
                        DateTime(
                          date.year,
                          date.month,
                          date.day,
                          time.hour,
                          time.minute,
                        ),
                      );
                    }
                  }
                }
              } finally {
                // Only reset if not already reset (for time picker case)
                if (mounted && _isPickerOpen) {
                  setState(() {
                    _isPickerOpen = false;
                  });
                }
              }
            },
    );
  }
}



