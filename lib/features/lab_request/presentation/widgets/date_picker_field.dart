import 'package:app_mobile_afms/design_system/components/forms/stp_date_picker.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_design_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Date picker field widget for lab request list filter.
class LabRequestDatePickerField extends StatelessWidget {
  /// Creates a new instance of [LabRequestDatePickerField].
  const LabRequestDatePickerField({
    required this.label,
    required this.selectedDate,
    required this.onDateSelected,
    super.key,
  });

  /// Field label
  final String label;

  /// Selected date
  final DateTime? selectedDate;

  /// Callback when date is selected
  final ValueChanged<DateTime?> onDateSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final date = await showSTPDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          onDateSelected(date);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(LabRequestDesignConstants.fieldPadding),
        decoration: BoxDecoration(
          color: LabRequestDesignConstants.white,
          border: Border.all(color: LabRequestDesignConstants.borderColor),
          borderRadius: BorderRadius.circular(
            LabRequestDesignConstants.fieldBorderRadius,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedDate != null
                    ? DateFormat('dd-MMM-yyyy').format(selectedDate!)
                    : label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const Icon(Icons.calendar_today, size: 20),
          ],
        ),
      ),
    );
  }
}


