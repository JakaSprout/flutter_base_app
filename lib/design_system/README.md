# Design System

Design System uses **Material Design 3** as the foundation, with custom components built on top of Material 3 components for faster development.

## Material Design 3 Foundation

Material Design 3 (Material You) provides:

- **Built-in Components**: Pre-built, well-tested components (Buttons, Cards, TextFields, etc.)
- **Design Tokens**: Color system, typography, spacing, elevation
- **Accessibility**: Built-in accessibility support
- **Platform Adaptation**: Automatic adaptation to iOS/Android design patterns
- **Fast Development**: Less custom code needed, faster time to market

## Structure

### `theme/`

Material 3 theme configuration for the entire application:

- **app_theme.dart**: Main Material 3 theme configuration
- **app_colors.dart**: Material 3 color scheme (light/dark)
- **app_typography.dart**: Material 3 typography system
- **app_spacing.dart**: Material 3 spacing system
- **app_elevation.dart**: Material 3 elevation system

### `components/`

Custom components built on Material 3 components:

- **buttons/**: Custom button variants (extending Material 3 buttons)
- **inputs/**: Custom input fields (extending Material 3 TextField)
- **cards/**: Custom card components (extending Material 3 Card)
- **dialogs/**: Custom dialogs (extending Material 3 Dialog)
- **navigation/**: Custom navigation components
- **forms/**: Form components using Material 3 inputs
- **loading/**: Loading indicators
- **empty_states/**: Empty state components

**Principle**: Extend Material 3 components rather than building from scratch. Only create custom components when Material 3 doesn't provide what we need.

### `layouts/`

Page layouts and screen templates:

- **base_screen.dart**: Base screen with Material 3 Scaffold
- **list_screen.dart**: List screen template
- **form_screen.dart**: Form screen template
- **detail_screen.dart**: Detail screen template

**Principle**: Use Material 3 Scaffold and AppBar as foundation, customize as needed.

## Material 3 Theme Setup

```dart
// app_theme.dart
ThemeData get lightTheme => ThemeData(
  useMaterial3: true,  // Enable Material 3
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.light,
  ),
  // Custom Material 3 theme configuration
);
```

## Best Practices

1. **Use Material 3 First**: Always check if Material 3 provides what you need before building custom
2. **Extend, Don't Replace**: Extend Material 3 components rather than replacing them
3. **Follow Material Guidelines**: Follow Material Design 3 guidelines for consistency
4. **Custom When Needed**: Only create custom components when Material 3 doesn't fit requirements
5. **Documentation**: Document custom components and their Material 3 base

## Usage

```dart
// Material 3 Components (Built-in)
ElevatedButton(onPressed: () {}, child: Text('Click'))
TextField(controller: controller)
Card(child: ...)
Dialog(child: ...)

// Custom Components (Extending Material 3)
AppButton.primary(onPressed: () {}, child: Text('Click'))
AppTextField(controller: controller, label: 'Email')
AppCard(child: ...)
AppDialog(title: 'Confirm', onConfirm: () {})

// Layouts
BaseScreen(title: 'Home', child: ...)
ListScreen(items: items, onItemTap: ...)
FormScreen(formKey: formKey, onSubmit: ...)
```

## Material 3 Resources

- [Material Design 3 Guidelines](https://m3.material.io/)
- [Flutter Material 3 Documentation](https://docs.flutter.dev/ui/design/material)
- [Material 3 Color System](https://m3.material.io/styles/color/the-color-system/overview)
- [Material 3 Components](https://m3.material.io/components)

## Migration from Atomic Design

If migrating from Atomic Design structure:

- **Atoms** → Use Material 3 built-in components
- **Molecules** → Custom components extending Material 3
- **Organisms** → Complex custom components or Material 3 compositions
- **Templates** → Layout components in `layouts/`
