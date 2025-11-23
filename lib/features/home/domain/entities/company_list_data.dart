/// Company list data entity (domain layer).
class CompanyListData {
  /// Creates a new instance of [CompanyListData].
  const CompanyListData({
    required this.companies,
    this.selectedCompany,
    this.selectedFarmId,
  });

  /// List of available companies (farm names)
  final List<String> companies;

  /// Currently selected company name (optional)
  final String? selectedCompany;

  /// Currently selected farm ID (optional, for filtering ponds)
  final int? selectedFarmId;
}

