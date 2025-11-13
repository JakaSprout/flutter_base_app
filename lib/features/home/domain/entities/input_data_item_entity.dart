/// Input data item entity (domain layer).
class InputDataItemEntity {
  /// Creates a new instance of [InputDataItemEntity].
  const InputDataItemEntity({
    required this.id,
    required this.label,
    required this.iconPath,
    required this.backgroundColor,
    required this.iconColor,
    required this.order,
  });

  /// Unique identifier for the input data item
  final String id;

  /// Display label
  final String label;

  /// Path to icon asset
  final String iconPath;

  /// Background color (as hex string, e.g., "#FFFFFF")
  final String backgroundColor;

  /// Icon color (as hex string, e.g., "#000000")
  final String iconColor;

  /// Display order (lower number = appears first)
  final int order;
}

