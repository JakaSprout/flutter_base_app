import 'package:flutter/material.dart';
import 'package:app_mobile_afms/core/config/navigation_constants.dart';

/// Pond (Kolam) screen.
///
/// This is a placeholder screen that will be implemented based on Figma design.
class PondScreen extends StatelessWidget {
  /// Creates a new instance of [PondScreen].
  const PondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.grid_view,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              NavigationConstants.screenPondTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              NavigationConstants.placeholderPond,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
