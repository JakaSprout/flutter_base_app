/// View model representing a pond option for UI display.
/// This is a presentation-layer model that adapts domain data for UI purposes.
class PondOption {
  /// Creates a new instance of [PondOption].
  const PondOption({required this.name, required this.id});

  /// Pond display name.
  final String name;

  /// Pond identifier.
  final String id;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PondOption) return false;
    return other.name == name && other.id == id;
  }

  @override
  int get hashCode => Object.hash(name, id);
}
