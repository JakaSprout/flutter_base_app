import 'package:app_mobile_afms/core/config/navigation_constants.dart';
import 'package:flutter/material.dart';

/// Graph screen.
///
/// This is a placeholder screen that will be implemented based on Figma design.
class GraphScreen extends StatelessWidget {
  /// Creates a new instance of [GraphScreen].
  const GraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.show_chart,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              NavigationConstants.screenGraphTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              NavigationConstants.placeholderGraph,
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
