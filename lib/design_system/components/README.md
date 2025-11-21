# Custom Components

Custom components built on top of Material Design 3 components.

## Naming Convention

All custom components use the `STP` prefix (e.g., `STPAppBar`, `STPFormInputField`, `STPDropdown`).

## Structure

```
components/
 ├─ buttons/        # Custom button variants (extending Material 3 buttons)
 ├─ cards/          # Custom card components (extending Material 3 Card)
 │  ├─ stp_input_data_item.dart
 │  └─ stp_metric_card.dart
 ├─ dialogs/        # Custom dialogs (extending Material 3 Dialog)
 ├─ dividers/       # Custom divider components
 ├─ empty_states/   # Empty state components
 ├─ forms/          # Form components using Material 3 inputs
 │  ├─ stp_date_picker.dart
 │  ├─ stp_dropdown_form_field.dart
 │  ├─ stp_form_input_field.dart
 │  └─ stp_info_banner.dart
 ├─ icons/          # Icon wrapper components
 ├─ inputs/         # Custom input fields (extending Material 3 TextField)
 │  └─ stp_dropdown.dart
 ├─ loading/        # Loading indicators
 ├─ navigation/     # Custom navigation components
 │  ├─ stp_app_bar.dart
 │  └─ stp_bottom_nav_bar.dart
 └─ text/           # Custom text widgets
```

## Available Components

### Banners

- **STPStatusBanner**: Status banner for info/success notifications with appropriate icons and colors

### Forms

- **STPFormInputField**: Consistent input field with label, required indicator, and icon support
- **STPDropdownFormField**: Dropdown field with label and optional required indicator (uses bottom sheet popup)
- **STPDatePicker**: Custom date picker dialog with month/year selectors and Indonesian locale
- **STPInfoBanner**: Information banner component with icon and light blue background

### Navigation

- **STPAppBar**: Standard AppBar with centered title, consistent styling, and gray divider
- **STPBottomNavBar**: Bottom navigation bar with floating action button support

### Inputs

- **STPDropdown**: Reusable dropdown component with configurable colors and bottom sheet popup

### Cards

- **STPInputDataItem**: Card component for displaying input data items
- **STPMetricCard**: Card component for displaying metric information

## Principles

1. **Extend Material 3**: Always extend Material 3 components rather than building from scratch
2. **Use Material 3 First**: Check if Material 3 provides what you need before creating custom
3. **Document Base Component**: Document which Material 3 component is being extended
4. **Follow Material Guidelines**: Follow Material Design 3 guidelines for consistency
5. **Consistent Naming**: Use `STP` prefix for all custom components

## Example

```dart
// ✅ GOOD: Extend Material 3 with STP prefix
class STPFormInputField extends StatelessWidget {
  final String label;
  final String value;
  final bool isRequired;

  const STPFormInputField({
    required this.label,
    required this.value,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Label
        Text(label),
        // Input field using Material 3 TextFormField
        TextFormField(
          // Custom styling
        ),
      ],
    );
  }
}

// ❌ BAD: Replace Material 3 or missing STP prefix
class FormInputField extends StatelessWidget {
  // Building from scratch instead of using Material 3
  // Missing STP prefix
}
```

## Usage

```dart
// Form input field
STPFormInputField(
  label: 'Nama',
  value: 'John Doe',
  isRequired: true,
  controller: nameController,
)

// Dropdown form field
STPDropdownFormField<String>(
  label: 'Pilih Blok',
  items: ['Blok A', 'Blok B'],
  selectedValue: selectedBlock,
  onChanged: (value) => setState(() => selectedBlock = value),
)

// Date picker
final date = await showSTPDatePicker(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime(2020),
  lastDate: DateTime(2100),
);

// App bar
STPAppBar(
  title: 'My Screen',
  actions: [
    IconButton(icon: Icon(Icons.search), onPressed: () {}),
  ],
)

// Info banner
STPInfoBanner(
  message: 'Pastikan semua informasi sudah benar',
)
```
