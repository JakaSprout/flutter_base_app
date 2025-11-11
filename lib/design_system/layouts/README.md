# Layouts

Page layouts and screen templates using Material Design 3 Scaffold.

## Structure

```
layouts/
 ├─ base_screen.dart      # Base screen with Material 3 Scaffold
 ├─ list_screen.dart      # List screen template
 ├─ form_screen.dart      # Form screen template
 └─ detail_screen.dart    # Detail screen template
```

## Principles

1. **Use Material 3 Scaffold**: Use Material 3 Scaffold and AppBar as foundation
2. **Customize as Needed**: Customize Material 3 components to match design requirements
3. **Reusability**: Design layouts to be reusable across multiple screens
4. **Consistency**: Follow Material Design 3 guidelines for layout consistency

## Example

```dart
// Base screen using Material 3 Scaffold
class BaseScreen extends StatelessWidget {
  final String title;
  final Widget body;
  
  const BaseScreen({required this.title, required this.body});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: body,
    );
  }
}
```

