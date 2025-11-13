/// Banner entity (domain layer).
class BannerEntity {
  /// Creates a new instance of [BannerEntity].
  const BannerEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.backgroundColor,
  });

  /// Card unique identifier
  final String id;

  /// Card title
  final String title;

  /// Card description
  final String description;

  /// Path to card image
  final String imagePath;

  /// Background color for the card (as hex string, e.g., "#FFFFFF")
  final String backgroundColor;
}

