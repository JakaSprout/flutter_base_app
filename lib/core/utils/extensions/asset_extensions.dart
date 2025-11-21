import 'package:flutter/widgets.dart';
import 'package:app_mobile_afms/gen/assets.gen.dart';

/// Extensions for easier asset usage.
extension AssetGenImageExtension on AssetGenImage {
  /// Get image widget with default sizing.
  Widget get widget => image();

  /// Get image widget with specified width.
  Widget width(double width) => image(width: width);

  /// Get image widget with specified height.
  Widget height(double height) => image(height: height);

  /// Get image widget with specified size.
  Widget size(double width, double height) =>
      image(width: width, height: height);

  /// Get image widget with square size.
  Widget square(double size) => image(width: size, height: size);
}
