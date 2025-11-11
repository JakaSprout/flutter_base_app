import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Navigation service for type-safe navigation.
class NavigationService {
  /// Navigate to home screen.
  static void goToHome(BuildContext context) {
    context.go('/');
  }

  /// Navigate back.
  static void goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    }
  }

  /// Navigate to a specific route.
  static void goTo(BuildContext context, String path) {
    context.go(path);
  }

  /// Push a new route.
  static void push(BuildContext context, String path) {
    context.push(path);
  }
}
