import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/design_system/components/inputs/stp_date_picker_dropdown.dart';
import 'package:app_mobile_afms/design_system/components/inputs/stp_date_range_picker.dart';
import 'package:app_mobile_afms/design_system/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Example screen demonstrating the usage of STP date picker widgets.
///
/// This screen shows how to use:
/// - [STPDatePickerDropdown] - Single date picker dropdown
/// - [STPDateRangePicker] - Date range picker with start and end dates
class STPDatePickerExample extends StatefulWidget {
  const STPDatePickerExample({super.key});

  @override
  State<STPDatePickerExample> createState() => _STPDatePickerExampleState();
}

class _STPDatePickerExampleState extends State<STPDatePickerExample> {
  DateTime? _singleDate;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          'Date Picker Examples',
          style: TextStyle(
            fontFamily: AppConstants.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Single Date Picker Example
            const Text(
              'Single Date Picker',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.gray100,
                fontFamily: AppConstants.fontFamily,
              ),
            ),
            const SizedBox(height: 16),
            STPDatePickerDropdown(
              label: 'Tanggal',
              selectedDate: _singleDate,
              onDateSelected: (date) {
                setState(() {
                  _singleDate = date;
                });
              },
              placeholder: 'Pilih tanggal',
            ),
            const SizedBox(height: 8),
            if (_singleDate != null)
              Text(
                'Selected: ${_singleDate.toString()}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.gray70,
                  fontFamily: AppConstants.fontFamily,
                ),
              ),
            const SizedBox(height: 32),

            // Date Range Picker Example
            const Text(
              'Date Range Picker',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.gray100,
                fontFamily: AppConstants.fontFamily,
              ),
            ),
            const SizedBox(height: 16),
            STPDateRangePicker(
              startDate: _startDate,
              endDate: _endDate,
              onStartDateChanged: (date) {
                setState(() {
                  _startDate = date;
                });
              },
              onEndDateChanged: (date) {
                setState(() {
                  _endDate = date;
                });
              },
            ),
            const SizedBox(height: 8),
            if (_startDate != null || _endDate != null)
              Text(
                'Range: ${_startDate?.toString() ?? 'Not set'} to ${_endDate?.toString() ?? 'Not set'}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.gray70,
                  fontFamily: AppConstants.fontFamily,
                ),
              ),
            const SizedBox(height: 32),

            // Custom Date Format Example
            const Text(
              'Custom Date Format',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.gray100,
                fontFamily: AppConstants.fontFamily,
              ),
            ),
            const SizedBox(height: 16),
            STPDatePickerDropdown(
              label: 'Tanggal Lahir',
              selectedDate: _singleDate,
              onDateSelected: (date) {
                setState(() {
                  _singleDate = date;
                });
              },
              placeholder: 'DD-MM-YYYY',
              dateFormat: 'dd-MM-yyyy',
              firstDate: DateTime(1950),
              lastDate: DateTime.now(),
            ),
          ],
        ),
      ),
    );
  }
}
