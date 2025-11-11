import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/config/navigation_constants.dart';

/// Monitoring screen.
///
/// This is a placeholder screen that will be implemented based on Figma design.
class MonitoringScreen extends StatelessWidget {
  /// Creates a new instance of [MonitoringScreen].
  const MonitoringScreen({super.key});

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
              NavigationConstants.screenMonitoringTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              NavigationConstants.placeholderMonitoring,
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
