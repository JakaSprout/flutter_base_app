import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/theme/theme_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Theme toggle button widget.
///
/// A button that allows users to toggle between light and dark themes.
/// Displays an icon representing the current theme mode.
class ThemeToggleButton extends HookConsumerWidget {
  /// Creates a new instance of [ThemeToggleButton].
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(currentThemeModeProvider);
    final themeNotifier = ref.read(themeModeNotifierProvider.notifier);

    // Determine icon based on current theme mode
    IconData icon;
    String tooltip;

    switch (themeMode) {
      case ThemeMode.light:
        icon = Icons.dark_mode_outlined;
        tooltip = 'Switch to dark theme';
      case ThemeMode.dark:
        icon = Icons.light_mode_outlined;
        tooltip = 'Switch to light theme';
      case ThemeMode.system:
        icon = Icons.brightness_auto_outlined;
        tooltip = 'Toggle theme (currently following system)';
    }

    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      onPressed: themeNotifier.toggleTheme,
    );
  }
}

/// Theme mode selector widget.
///
/// A more comprehensive widget that allows users to select from
/// Light, Dark, or System theme modes.
class ThemeModeSelector extends HookConsumerWidget {
  /// Creates a new instance of [ThemeModeSelector].
  const ThemeModeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(currentThemeModeProvider);
    final themeNotifier = ref.read(themeModeNotifierProvider.notifier);

    return PopupMenuButton<ThemeMode>(
      icon: Icon(_getThemeIcon(themeMode)),
      tooltip: 'Select theme mode',
      onSelected: themeNotifier.setThemeMode,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<ThemeMode>>[
        PopupMenuItem<ThemeMode>(
          value: ThemeMode.light,
          child: Row(
            children: [
              const Icon(Icons.light_mode_outlined, size: 20),
              const SizedBox(width: 12),
              const Text('Light'),
              if (themeMode == ThemeMode.light) ...[
                const Spacer(),
                Icon(
                  Icons.check,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ],
          ),
        ),
        PopupMenuItem<ThemeMode>(
          value: ThemeMode.dark,
          child: Row(
            children: [
              const Icon(Icons.dark_mode_outlined, size: 20),
              const SizedBox(width: 12),
              const Text('Dark'),
              if (themeMode == ThemeMode.dark) ...[
                const Spacer(),
                Icon(
                  Icons.check,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ],
          ),
        ),
        PopupMenuItem<ThemeMode>(
          value: ThemeMode.system,
          child: Row(
            children: [
              const Icon(Icons.brightness_auto_outlined, size: 20),
              const SizedBox(width: 12),
              const Text('System'),
              if (themeMode == ThemeMode.system) ...[
                const Spacer(),
                Icon(
                  Icons.check,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  IconData _getThemeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return Icons.light_mode_outlined;
      case ThemeMode.dark:
        return Icons.dark_mode_outlined;
      case ThemeMode.system:
        return Icons.brightness_auto_outlined;
    }
  }
}
