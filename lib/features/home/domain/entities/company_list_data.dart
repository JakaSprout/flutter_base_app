/// Company list data entity (domain layer).
class CompanyListData {
  /// Creates a new instance of [CompanyListData].
  const CompanyListData({
    required this.companies,
    this.selectedCompany,
  });

  /// List of available companies
  final List<String> companies;

  /// Currently selected company (optional)
  final String? selectedCompany;
}

