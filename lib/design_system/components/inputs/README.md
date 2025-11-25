# Custom Input Components

This folder contains reusable input components that extend Material 3 form controls.

## Available Components

### 1. STPDropdown
A customizable dropdown component with configurable colors and styling.

**Features:**
- Configurable color schemes (primary, gray, custom)
- Bottom sheet menu presentation
- Optional label and hint text
- Custom display text formatting

**Usage:**
```dart
STPDropdown<String>(
  items: ['Option 1', 'Option 2', 'Option 3'],
  selectedValue: selectedValue,
  onChanged: (value) => setState(() => selectedValue = value),
  colors: STPDropdownColors.primary(),
  label: 'Select Option:',
)
```

### 2. STPSwitch
A custom switch component.

### 3. STPDatePickerDropdown (NEW)
A dropdown-style date picker that displays a calendar when tapped.

**Features:**
- Dropdown appearance with calendar icon
- Calendar opens as overlay below the input
- Month and year navigation
- Indonesian day/month names
- Customizable date format
- Date range constraints

**Usage:**
```dart
STPDatePickerDropdown(
  label: 'Tgl Mulai',
  selectedDate: _startDate,
  onDateSelected: (date) {
    setState(() => _startDate = date);
  },
  firstDate: DateTime(2020),
  lastDate: DateTime(2100),
  placeholder: 'Pilih tanggal',
)
```

### 4. STPDateRangePicker (NEW)
A date range picker with start and end date dropdowns.

**Features:**
- Two date pickers (start and end date) side by side
- Automatic date range validation
- End date cannot be before start date
- Consistent styling with Figma design

**Usage:**
```dart
STPDateRangePicker(
  startDate: _startDate,
  endDate: _endDate,
  onStartDateChanged: (date) {
    setState(() => _startDate = date);
  },
  onEndDateChanged: (date) {
    setState(() => _endDate = date);
  },
  startLabel: 'Tgl Mulai',
  endLabel: 'Tgl Akhir',
)
```

## Design Principles

All input components follow these principles:
- Consistent with Material 3 design
- Accessible and user-friendly
- Properly themed with app colors
- Support for disabled state
- Proper error handling
- Indonesian localization where applicable

## Examples

See `stp_date_picker_example.dart` for complete usage examples of all date picker components.
