/// Farm list data entity (domain layer).
class FarmListData {
  /// Creates a new instance of [FarmListData].
  const FarmListData({
    required this.farms,
    this.selectedFarm,
    this.selectedFarmId,
    this.selectedFarmUuid,
  });

  /// List of available farms (farm names)
  final List<String> farms;

  /// Currently selected farm name (optional)
  final String? selectedFarm;

  /// Currently selected farm ID (optional, for filtering ponds)
  final int? selectedFarmId;

  /// Currently selected farm UUID (optional, for filtering ponds)
  final String? selectedFarmUuid;
}
