# Custom Components

Custom components built on top of Material Design 3 components.

## Structure

```
components/
 ├─ buttons/        # Custom button variants (extending Material 3 buttons)
 ├─ inputs/         # Custom input fields (extending Material 3 TextField)
 ├─ cards/          # Custom card components (extending Material 3 Card)
 ├─ dialogs/        # Custom dialogs (extending Material 3 Dialog)
 ├─ navigation/     # Custom navigation components
 ├─ forms/          # Form components using Material 3 inputs
 ├─ loading/        # Loading indicators
 ├─ empty_states/   # Empty state components
 ├─ dividers/       # Custom divider components
 ├─ icons/         # Icon wrapper components
 └─ text/          # Custom text widgets
```

## Principles

1. **Extend Material 3**: Always extend Material 3 components rather than building from scratch
2. **Use Material 3 First**: Check if Material 3 provides what you need before creating custom
3. **Document Base Component**: Document which Material 3 component is being extended
4. **Follow Material Guidelines**: Follow Material Design 3 guidelines for consistency

## Example

```dart
// ✅ GOOD: Extend Material 3
class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  
  const AppButton({required this.onPressed, required this.child});
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // Custom styling
      ),
      child: child,
    );
  }
}

// ❌ BAD: Replace Material 3
class AppButton extends StatelessWidget {
  // Building from scratch instead of using Material 3
}
```

