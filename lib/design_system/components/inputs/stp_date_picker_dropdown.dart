import 'package:app_mobile_afms/core/config/constants.dart';
import 'package:app_mobile_afms/design_system/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A dropdown-style date picker that displays a calendar when tapped.
///
/// This widget mimics a dropdown appearance and shows a calendar picker
/// directly below the input field when tapped.
///
/// Example:
/// ```dart
/// STPDatePickerDropdown(
///   label: 'Tgl Mulai',
///   selectedDate: _startDate,
///   onDateSelected: (date) {
///     setState(() => _startDate = date);
///   },
///   firstDate: DateTime(2020),
///   lastDate: DateTime(2100),
/// )
/// ```
class STPDatePickerDropdown extends StatefulWidget {
  /// Creates a new instance of [STPDatePickerDropdown].
  const STPDatePickerDropdown({
    required this.onDateSelected,
    super.key,
    this.label,
    this.selectedDate,
    this.firstDate,
    this.lastDate,
    this.placeholder = 'Pilih tanggal',
    this.enabled = true,
    this.dateFormat = 'dd/MM/yyyy',
  });

  /// Label text displayed above the dropdown
  final String? label;

  /// Currently selected date
  final DateTime? selectedDate;

  /// Callback when a date is selected
  final ValueChanged<DateTime> onDateSelected;

  /// Earliest selectable date (defaults to 100 years ago)
  final DateTime? firstDate;

  /// Latest selectable date (defaults to 100 years from now)
  final DateTime? lastDate;

  /// Placeholder text when no date is selected
  final String placeholder;

  /// Whether the picker is enabled
  final bool enabled;

  /// Date format for display (defaults to 'dd/MM/yyyy')
  final String dateFormat;

  @override
  State<STPDatePickerDropdown> createState() => _STPDatePickerDropdownState();
}

class _STPDatePickerDropdownState extends State<STPDatePickerDropdown> {
  final GlobalKey _dropdownKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool _isCalendarOpen = false;

  // Design tokens
  static const double _borderRadius = 8;
  static const double _fontSize = 14;
  static const double _iconSize = 20;
  static const double _paddingHorizontal = 12;
  static const double _paddingVertical = 10;

  @override
  void dispose() {
    _removeCalendar();
    super.dispose();
  }

  String get _displayText {
    if (widget.selectedDate == null) {
      return widget.placeholder;
    }
    try {
      final formatter = DateFormat(widget.dateFormat, 'id_ID');
      return formatter.format(widget.selectedDate!);
    } catch (e) {
      // Fallback to default format if locale is not initialized
      final formatter = DateFormat(widget.dateFormat);
      return formatter.format(widget.selectedDate!);
    }
  }

  void _toggleCalendar() {
    if (!widget.enabled) return;

    if (_isCalendarOpen) {
      _removeCalendar();
    } else {
      _showCalendar();
    }
  }

  void _showCalendar() {
    final renderBox =
        _dropdownKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final offset = renderBox.localToGlobal(Offset.zero);
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate optimal calendar position
    var calendarLeft = offset.dx;
    const calendarWidth = 280.0;

    // If calendar would extend beyond screen width, position it to the left
    if (calendarLeft + calendarWidth > screenWidth) {
      calendarLeft =
          screenWidth - calendarWidth - 16; // 16px padding from screen edge
    }

    // Ensure calendar doesn't go off screen to the left
    if (calendarLeft < 16) {
      calendarLeft = 16;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => _CalendarOverlay(
        position: Offset(calendarLeft, offset.dy),
        selectedDate: widget.selectedDate,
        firstDate:
            widget.firstDate ??
            DateTime.now().subtract(const Duration(days: 36500)),
        lastDate:
            widget.lastDate ?? DateTime.now().add(const Duration(days: 36500)),
        onDateSelected: (date) {
          widget.onDateSelected(date);
          _removeCalendar();
        },
        onDismiss: _removeCalendar,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isCalendarOpen = true;
    });
  }

  void _removeCalendar() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    // Use addPostFrameCallback to ensure we don't call setState after widget is disposed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _isCalendarOpen = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.gray100,
              fontFamily: AppConstants.fontFamily,
            ),
          ),
          const SizedBox(height: 8),
        ],
        // Dropdown trigger
        GestureDetector(
          key: _dropdownKey,
          onTap: _toggleCalendar,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: _paddingHorizontal,
              vertical: _paddingVertical,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(
                color: _isCalendarOpen ? AppColors.primary : AppColors.gray20,
                width: _isCalendarOpen ? 1 : 1,
              ),
              borderRadius: BorderRadius.circular(_borderRadius),
            ),
            child: Row(
              children: [
                // Calendar icon
                Icon(
                  Icons.calendar_today,
                  size: _iconSize,
                  color: widget.selectedDate != null
                      ? AppColors.primary
                      : AppColors.gray70,
                ),
                const SizedBox(width: 12),
                // Date text
                Expanded(
                  child: Text(
                    _displayText,
                    style: TextStyle(
                      fontSize: _fontSize,
                      fontWeight: FontWeight.w400,
                      color: widget.selectedDate != null
                          ? AppColors.gray100
                          : AppColors.gray70,
                      fontFamily: AppConstants.fontFamily,
                    ),
                  ),
                ),
                // Chevron icon
                Icon(
                  _isCalendarOpen
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: _iconSize,
                  color: AppColors.gray100,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Overlay widget that displays the calendar picker.
class _CalendarOverlay extends StatefulWidget {
  const _CalendarOverlay({
    required this.position,
    required this.selectedDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
    required this.onDismiss,
  });

  final Offset position;
  final DateTime? selectedDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime> onDateSelected;
  final VoidCallback onDismiss;

  @override
  State<_CalendarOverlay> createState() => _CalendarOverlayState();
}

enum _PickerMode { date, month, year }

class _CalendarOverlayState extends State<_CalendarOverlay> {
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

  // Indonesian day abbreviations
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
    _selectedDate = widget.selectedDate ?? DateTime.now();
    _focusedDate = widget.selectedDate ?? DateTime.now();
  }

  void _onDaySelected(DateTime day) {
    widget.onDateSelected(day);
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
      _mode = _mode == _PickerMode.month ? _PickerMode.date : _PickerMode.month;
    });
  }

  void _showYearPicker() {
    setState(() {
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
    return Stack(
      children: [
        // Transparent barrier to detect outside taps
        Positioned.fill(
          child: GestureDetector(
            onTap: widget.onDismiss,
            behavior: HitTestBehavior.translucent,
            child: Container(color: Colors.transparent),
          ),
        ),
        // Calendar positioned below the dropdown
        Positioned(
          left: widget.position.dx,
          top: widget.position.dy + 50, // Position below the dropdown
          child: Material(
            elevation: 8,
            shadowColor: Colors.black26,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 280, // Fixed width for better calendar display on mobile
              constraints: const BoxConstraints(minWidth: 260, maxWidth: 320),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.gray20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with month/year selectors
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildHeader(),
                  ),
                  const Divider(height: 1, color: AppColors.gray20),
                  // Calendar content
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildContent(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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

  Widget _buildSelectorButton({
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
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
              ),
            ),
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
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.gray20),
        ),
        child: Icon(icon, size: 16, color: AppColors.gray100),
      ),
    );
  }

  Widget _buildContent() {
    final now = DateTime.now();
    final days = _getDaysInMonth(_focusedDate);

    if (_mode == _PickerMode.date) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDayHeaders(),
          const SizedBox(height: 2),
          _buildCalendarGrid(days, now),
        ],
      );
    } else if (_mode == _PickerMode.month) {
      return _buildMonthPicker();
    } else {
      return _buildYearPicker();
    }
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
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
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
    );
  }

  Widget _buildMonthPicker() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 2.5,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        final month = index + 1;
        final isSelected = month == _focusedDate.month;
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
    );
  }

  Widget _buildYearPicker() {
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
        Row(
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
            ),
            Text(
              '$startYear - $endYear',
              style: const TextStyle(
                fontSize: 16,
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
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Year grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
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
      ],
    );
  }
}
