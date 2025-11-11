import 'package:flutter/material.dart';

/// Extensions for BuildContext operations.
extension ContextExtensions on BuildContext {
  /// Get theme data.
  ThemeData get theme => Theme.of(this);

  /// Get text theme.
  TextTheme get textTheme => theme.textTheme;

  /// Get color scheme.
  ColorScheme get colorScheme => theme.colorScheme;

  /// Get media query.
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Get screen size.
  Size get screenSize => mediaQuery.size;

  /// Get screen width.
  double get screenWidth => screenSize.width;

  /// Get screen height.
  double get screenHeight => screenSize.height;

  /// Get screen padding.
  EdgeInsets get screenPadding => mediaQuery.padding;

  /// Check if device is in landscape mode.
  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;

  /// Check if device is in portrait mode.
  bool get isPortrait => mediaQuery.orientation == Orientation.portrait;

  /// Check if device is tablet (width >= 600).
  bool get isTablet => screenWidth >= 600;

  /// Check if device is phone (width < 600).
  bool get isPhone => screenWidth < 600;

  /// Get safe area padding.
  EdgeInsets get safeAreaPadding => mediaQuery.padding;

  /// Get safe area insets.
  EdgeInsets get safeAreaInsets => mediaQuery.viewPadding;

  /// Show snackbar with message.
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    Color? backgroundColor,
    Color? textColor,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: textColor)),
        duration: duration,
        action: action,
        backgroundColor: backgroundColor,
      ),
    );
  }

  /// Show error snackbar.
  void showErrorSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 4),
  }) {
    showSnackBar(
      message,
      duration: duration,
      backgroundColor: colorScheme.error,
      textColor: colorScheme.onError,
    );
  }

  /// Show success snackbar.
  void showSuccessSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    showSnackBar(
      message,
      duration: duration,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  /// Navigate to route.
  Future<T?> navigateTo<T>(String route, {Object? arguments}) {
    return Navigator.of(this).pushNamed<T>(route, arguments: arguments);
  }

  /// Navigate back.
  void navigateBack<T>([T? result]) {
    Navigator.of(this).pop(result);
  }

  /// Check if can navigate back.
  bool get canPop => Navigator.of(this).canPop();

  /// Pop until route name.
  void popUntil(String routeName) {
    Navigator.of(this).popUntil((route) => route.settings.name == routeName);
  }

  /// Get focus scope.
  FocusScopeNode get focusScope => FocusScope.of(this);

  /// Unfocus current focus.
  void unfocus() {
    focusScope.unfocus();
  }

  /// Request focus on node.
  void requestFocus(FocusNode node) {
    focusScope.requestFocus(node);
  }
}
