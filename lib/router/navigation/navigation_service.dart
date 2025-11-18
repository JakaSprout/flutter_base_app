import 'package:flutter/material.dart';
import 'package:flutter_base_app/router/routes.dart';
import 'package:go_router/go_router.dart';

/// Navigation service for type-safe navigation.
class NavigationService {
  /// Navigate to home screen.
  static void goToHome(BuildContext context) {
    context.goNamed(Routes.homeName);
  }

  /// Navigate back.
  static void goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    }
  }

  /// Navigate to a specific route.
  ///
  /// Prefer using route constants from [Routes] instead of hardcoded strings.
  /// Example: Use [Routes.home] instead of '/'.
  static void goTo(BuildContext context, String path) {
    context.go(path);
  }

  /// Push a new route.
  ///
  /// Prefer using route constants from [Routes] instead of hardcoded strings.
  /// Example: Use [Routes.home] instead of '/'.
  static void push(BuildContext context, String path) {
    context.push(path);
  }
}
