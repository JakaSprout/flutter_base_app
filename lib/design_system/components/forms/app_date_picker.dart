import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/constants.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';

/// Custom date picker dialog based on Figma design.
///
/// Features:
/// - Month/year dropdown selectors
/// - Navigation arrows
/// - Indonesian day abbreviations (Sn, Sl, Rb, Km, Jm, Sb, Mg)
/// - Selected date with blue background
/// - Current date with blue border
/// - Cancel and Confirm buttons
///
/// Example:
/// ```dart
/// final selectedDate = await showAppDatePicker(
///   context: context,
///   initialDate: DateTime.now(),
///   firstDate: DateTime(2020),
///   lastDate: DateTime(2100),
/// );
/// ```
Future<DateTime?> showAppDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
}) {
  return showDialog<DateTime>(
    context: context,
    builder: (context) => _AppDatePickerDialog(
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    ),
  );
}

class _AppDatePickerDialog extends StatefulWidget {
  const _AppDatePickerDialog({
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
  });

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  @override
  State<_AppDatePickerDialog> createState() => _AppDatePickerDialogState();
}

enum _PickerMode { date, month, year }

class _AppDatePickerDialogState extends State<_AppDatePickerDialog> {
  late DateTime _selectedDate;
  late DateTime _focusedDate;
  _PickerMode _mode = _PickerMode.date;

  // Indonesian month names
  static const List<String> _monthNames = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  // Indonesian day abbreviations (starting from Monday)
  static const List<String> _dayAbbreviations = [
    'Sn', // Senin
    'Sl', // Selasa
    'Rb', // Rabu
    'Km', // Kamis
    'Jm', // Jumat
    'Sb', // Sabtu
    'Mg', // Minggu
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _focusedDate = widget.initialDate;
  }

  void _onDaySelected(DateTime day) {
    setState(() {
      _selectedDate = day;
    });
  }

  void _navigateMonth(int direction) {
    setState(() {
      _focusedDate = DateTime(
        _focusedDate.year,
        _focusedDate.month + direction,
      );
    });
  }

  void _selectMonth(int month) {
    setState(() {
      _focusedDate = DateTime(_focusedDate.year, month);
      _mode = _PickerMode.date;
    });
  }

  void _selectYear(int year) {
    setState(() {
      _focusedDate = DateTime(year, _focusedDate.month);
      _mode = _PickerMode.date;
    });
  }

  void _showMonthPicker() {
    setState(() {
      // Toggle: if already in month mode, go back to date mode
      _mode = _mode == _PickerMode.month ? _PickerMode.date : _PickerMode.month;
    });
  }

  void _showYearPicker() {
    setState(() {
      // Toggle: if already in year mode, go back to date mode
      _mode = _mode == _PickerMode.year ? _PickerMode.date : _PickerMode.year;
    });
  }

  List<DateTime> _getDaysInMonth(DateTime month) {
    final firstDay = DateTime(month.year, month.month);
    final lastDay = DateTime(month.year, month.month + 1, 0);
    final daysInMonth = lastDay.day;

    // Get first day of week (Monday = 1, Sunday = 7)
    final firstDayOfWeek = firstDay.weekday == 7 ? 0 : firstDay.weekday;

    final days = <DateTime>[];

    // Add days from previous month
    final prevMonthLastDay = DateTime(month.year, month.month, 0).day;
    for (var i = firstDayOfWeek - 1; i >= 0; i--) {
      days.add(DateTime(month.year, month.month - 1, prevMonthLastDay - i));
    }

    // Add days from current month
    for (var i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(month.year, month.month, i));
    }

    // Add days from next month to fill the grid
    final remainingDays = 42 - days.length; // 6 weeks * 7 days
    for (var i = 1; i <= remainingDays; i++) {
      days.add(DateTime(month.year, month.month + 1, i));
    }

    return days;
  }

  bool _isSameMonth(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month;
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final days = _getDaysInMonth(_focusedDate);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 400,
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with month/year selectors and navigation
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
              child: _buildHeader(),
            ),
            // Divider between header and calendar
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 1,
              color: AppColors.gray20,
            ),
            // Content based on mode
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_mode == _PickerMode.date) ...[
                        const SizedBox(height: 16),
                        // Day headers
                        _buildDayHeaders(),
                        const SizedBox(height: 8),
                        // Calendar grid
                        _buildCalendarGrid(days, now),
                      ] else if (_mode == _PickerMode.month) ...[
                        const SizedBox(height: 16),
                        // Month picker grid
                        _buildMonthPicker(),
                      ] else if (_mode == _PickerMode.year) ...[
                        const SizedBox(height: 16),
                        // Year picker grid
                        _buildYearPicker(),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Action buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
              child: _buildActionButtons(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: _buildSelectorButton(
            text: _monthNames[_focusedDate.month - 1],
            onTap: _showMonthPicker,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          flex: 2,
          child: _buildSelectorButton(
            text: '${_focusedDate.year}',
            onTap: _showYearPicker,
          ),
        ),
        if (_mode == _PickerMode.date) ...[
          const SizedBox(width: 4),
          _buildNavigationButton(
            icon: Icons.chevron_left,
            onTap: () => _navigateMonth(-1),
          ),
          const SizedBox(width: 4),
          _buildNavigationButton(
            icon: Icons.chevron_right,
            onTap: () => _navigateMonth(1),
          ),
        ],
      ],
    );
  }

  Widget _buildNavigationButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.gray20),
        ),
        child: Icon(icon, size: 16, color: AppColors.gray100),
      ),
    );
  }

  Widget _buildDayHeaders() {
    return Row(
      children: _dayAbbreviations.map((day) {
        return Expanded(
          child: Center(
            child: Text(
              day,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.gray100,
                fontFamily: AppConstants.fontFamily,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCalendarGrid(List<DateTime> days, DateTime now) {
    return SizedBox(
      height: 240, // Fixed height to prevent overflow: 6 rows * 40px
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          final isCurrentMonth = _isSameMonth(day, _focusedDate);
          final isSelected = _isSameDay(day, _selectedDate);
          final isToday = _isSameDay(day, now);
          final isInRange =
              day.isAfter(widget.firstDate.subtract(const Duration(days: 1))) &&
              day.isBefore(widget.lastDate.add(const Duration(days: 1)));

          return GestureDetector(
            onTap: isInRange ? () => _onDaySelected(day) : null,
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                border: isToday && !isSelected
                    ? Border.all(color: AppColors.primary)
                    : null,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected || isToday
                        ? FontWeight.w600
                        : FontWeight.w400,
                    color: isSelected
                        ? AppColors.white
                        : (isToday
                              ? AppColors.primary
                              : (isCurrentMonth
                                    ? AppColors.gray100
                                    : AppColors.gray70)),
                    fontFamily: AppConstants.fontFamily,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelectorButton({
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray100,
                  fontFamily: AppConstants.fontFamily,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.arrow_drop_down,
              size: 20,
              color: AppColors.gray100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthPicker() {
    return SizedBox(
      height: 200, // Fixed height to prevent overflow: 4 rows * ~50px
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 2.5,
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          final month = index + 1;
          final isSelected =
              month == _focusedDate.month &&
              _focusedDate.year == widget.initialDate.year;
          return GestureDetector(
            onTap: () => _selectMonth(month),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.gray20,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  _monthNames[index],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? AppColors.white : AppColors.gray100,
                    fontFamily: AppConstants.fontFamily,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildYearPicker() {
    // Group years into pages of 12
    final currentPage = (_focusedDate.year - widget.firstDate.year) ~/ 12;
    final startYear = widget.firstDate.year + (currentPage * 12);
    final endYear = (startYear + 11).clamp(
      widget.firstDate.year,
      widget.lastDate.year,
    );
    final pageYears = List.generate(
      (endYear - startYear + 1).clamp(0, 12),
      (index) => startYear + index,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Year navigation header
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: startYear > widget.firstDate.year
                    ? () {
                        setState(() {
                          _focusedDate = DateTime(startYear - 12);
                        });
                      }
                    : null,
                style: IconButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: startYear > widget.firstDate.year
                      ? AppColors.gray100
                      : AppColors.gray70,
                ),
              ),
              Text(
                '$startYear - $endYear',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray100,
                  fontFamily: AppConstants.fontFamily,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: endYear < widget.lastDate.year
                    ? () {
                        setState(() {
                          _focusedDate = DateTime(startYear + 12);
                        });
                      }
                    : null,
                style: IconButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: endYear < widget.lastDate.year
                      ? AppColors.gray100
                      : AppColors.gray70,
                ),
              ),
            ],
          ),
        ),
        // Year grid
        SizedBox(
          height: 200, // Fixed height to prevent overflow: 4 rows * ~50px
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 2.5,
            ),
            itemCount: pageYears.length,
            itemBuilder: (context, index) {
              final year = pageYears[index];
              final isSelected = year == _focusedDate.year;
              return GestureDetector(
                onTap: () => _selectYear(year),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.gray20,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '$year',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: isSelected ? AppColors.white : AppColors.gray100,
                        fontFamily: AppConstants.fontFamily,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        // Cancel button
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              side: const BorderSide(color: AppColors.gray20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Batal',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.gray100,
                fontFamily: AppConstants.fontFamily,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Confirm button
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pop(_selectedDate),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Konfirmasi',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
                fontFamily: AppConstants.fontFamily,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
