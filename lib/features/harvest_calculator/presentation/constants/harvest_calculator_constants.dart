/// Constants for Harvest Calculator feature.
///
/// Contains all text constants and default values for Harvest Calculator screens
/// to avoid hardcoded strings throughout the feature.
class HarvestCalculatorConstants {
  // Private constructor to prevent instantiation
  HarvestCalculatorConstants._();

  // Screen Titles
  /// Title for Harvest Calculator
  static const String titleHarvestCalculator = 'Kalkulator Panen';

  /// Title for Create Simulation (Cycle)
  static const String titleCreateSimulation = 'Buat Simulasi Siklus';

  /// Title for Create Simulation (Agent)
  static const String titleCreateSimulationAgent = 'Buat Simulasi Agen';

  /// Title for Simulation Results
  static const String titleSimulationResults = 'Hasil Simulasi';

  /// Title for Saved Simulations
  static const String titleSavedSimulations = 'Simulasi Tersimpan';

  // Card & Description
  /// Harvest Calculator card title
  static const String cardTitle = 'Kalkulator Panen';

  /// Harvest Calculator description
  static const String cardDescription =
      'Hitung dan simulasikan potensi hasil panen dalam budidaya udang';

  /// Preview info message for results screen
  static const String previewInfoMessage =
      'Simulasi yang ditampilkan adalah Preview. Pilih opsi "Simpan" untuk menyimpan hasil.';

  /// ADG calculator info message
  static const String adgCalculatorInfoMessage =
      'Kalkulator ini menggunakan ADG (Average Daily Gain) sebagai dasar perhitungan.';

  /// Show recommendation button text
  static const String buttonShowRecommendation = 'Tampilkan Rekomendasi';

  // Empty State
  /// Empty state message when no simulation exists
  static const String emptyStateMessage = 'Belum Ada Simulasi Panen.';

  /// Empty state secondary message
  static const String emptyStateSecondaryMessage =
      'Mulai hitung potensi panen dan pengeluaran budidaya Kamu.';

  // Button Labels
  /// Create simulation button text
  static const String buttonCreateSimulation = 'Buat Simulasi Siklus';

  /// Create simulation button text (short)
  static const String buttonCreate = 'Buat Simulasi';

  /// Simulasi Panen button text for empty state
  static const String buttonSimulasiPanen = 'Simulasi Panen';

  // Simulation Type Selection
  /// Title for simulation type selection modal
  static const String titleSelectSimulationType = 'Pilih Simulasi Panen';

  /// Cycle simulation type label
  static const String labelCycle = 'Siklus';

  /// Agent simulation type value
  static const String simulationTypeAgent = 'agent';

  /// Cycle simulation type value
  static const String simulationTypeCycle = 'cycle';

  /// Cycle simulation description
  static const String descriptionCycle =
      'Penghitungan estimasi hasil panen berdasarkan perhitungan ADG.';

  /// Distributor Agent simulation type label
  static const String labelDistributorAgent = 'Agen Distributor';

  /// Distributor Agent simulation description
  static const String descriptionDistributorAgent =
      'Penghitungan estimasi hasil panen sebagai dasar pertimbangan peminjaman';

  /// Save simulation button text
  static const String buttonSave = 'Simpan';

  /// Save cycle button text
  static const String buttonCycleSaved = 'Siklus Tersimpan';

  /// See more button text
  static const String buttonSeeMore = 'Lihat Selengkapnya';

  /// Detail button text
  static const String buttonDetail = 'Detail';

  /// Delete button text
  static const String buttonDelete = 'Hapus';

  /// Filter button text
  static const String buttonFilter = 'Filter';

  /// Sort button text
  static const String buttonSort = 'Urutkan';

  // Form Labels - Basic Info
  /// Use registered pond question
  static const String questionUseRegisteredPond = 'Gunakan Kolam Terdaftar?';

  /// Use registered pond option - Yes
  static const String optionUseRegisteredPond = 'Ya, Gunakan';

  /// Use registered pond option - Manual
  static const String optionFillManual = 'Isi Manual';

  /// Select pond label
  static const String labelSelectPond = 'Pilih Kolam';

  /// Select pond placeholder/hint
  static const String hintSelectPond = 'Pilih Kolam';

  /// Title for registered pond modal
  static const String titleSelectRegisteredPond = 'Pilih Kolam';

  /// Subtitle for registered pond modal
  static const String subtitleSelectRegisteredPond =
      'Tentukan Kolam Terdaftar pilihanmu.';

  /// Search placeholder for registered pond modal
  static const String searchRegisteredPondPlaceholder =
      'Cari Nama Kolam Terdaftar atau ID';

  /// Simulation name label
  static const String labelSimulationName = 'Nama Simulasi';

  /// Commodity label
  static const String labelCommodity = 'Komoditas';

  /// Cultivation system label
  static const String labelCultivationSystem = 'Sistem Budidaya';

  /// Select cultivation system placeholder
  static const String hintSelectCultivationSystem = 'Pilih Sistem Budidaya';

  // Form Labels - Pond Capacity
  /// Pond area label
  static const String labelPondArea = 'Luas Kolam (m²)';

  /// Stocking density label
  static const String labelStockingDensity = 'Kepadatan Tebar';

  /// Capacity label (kg/m²)
  static const String labelCapacity = 'Kapasitas';

  /// Capacity label (grams)
  static const String labelCapacityGrams = 'Kapasitas';

  /// Pond capacity label
  static const String labelPondCapacity = 'Kapasitas Kolam';

  /// Pond depth label (deprecated, use labelStockingDensity)
  static const String labelPondDepth = 'Kedalaman Kolam';

  /// Fry count label (deprecated)
  static const String labelFryCount = 'Jumlah Benur';

  /// Target harvest label
  static const String labelTargetHarvest = 'Target Panen';

  /// Estimated ADG label
  static const String labelEstimatedADG = 'Estimasi ADG (g)';

  // Form Labels - Cycle Type
  /// Cycle type section title
  static const String sectionCycleType = 'Tipe Siklus';

  /// Cycle type subtitle
  static const String subtitleCycleType = 'Pilih Tipe Siklus';

  /// Full cycle option
  static const String cycleTypeFull = 'Siklus Penuh';

  /// Mid cycle option
  static const String cycleTypeMid = 'Pertengahan Siklus';

  /// Title for cycle type info modal.
  static const String titleCycleTypeInfo = 'Penjelasan Sistem Siklus';

  /// Description for full cycle info.
  static const String descriptionCycleTypeFull =
      'adalah kondisi ketika memulai perhitungan sejak awal budidaya. (DOC Saat Ini = 0)';

  /// Description for mid cycle info.
  static const String descriptionCycleTypeMid =
      'adalah kondisi ketika perhitungan berada di tengah proses budidaya, misalnya saat kolam sudah berjalan beberapa minggu. (DOC Saat Ini > 0)';

  /// Current DOC label
  static const String labelCurrentDOC = 'DOC Saat Ini';

  // Form Labels - Growth Target
  /// Target DOC label
  static const String labelTargetDOC = 'Target DOC';

  /// Target SR label
  static const String labelTargetSR = 'Target SR';

  /// Estimated FCR label
  static const String labelEstimatedFCR = 'Estimasi FCR';

  /// Target Biomass label
  static const String labelTargetBiomass = 'Target Biomassa';

  /// Target Selling Price label
  static const String labelTargetSellingPrice = 'Target Harga Jual';

  /// Target Feed Price label
  static const String labelTargetFeedPrice = 'Target Harga Pakan';

  // Form Labels - Price Info
  /// Shrimp selling price label
  static const String labelShrimpSellingPrice = 'Harga Jual Udang';

  /// Feed price label
  static const String labelFeedPrice = 'Harga Pakan (Rp/kg)';

  // Form Labels - Agent Mode
  /// Current biomass label (for Agent mode)
  static const String labelCurrentBiomass = 'Estimasi Biomassa Saat Ini (kg)';

  /// Total feed payment obligation label (for Agent mode)
  static const String labelTotalFeedPaymentObligation =
      'Total Kewajiban Bayar Pakan';

  /// Harvest purchase price label (for Agent mode)
  static const String labelHarvestPurchasePrice = 'Harga Beli Panen/kg';

  /// Estimated harvest yield label (for Agent mode)
  static const String labelEstimatedHarvestYield = 'Estimasi Hasil Panen';

  // Form Labels - Partial Harvest
  /// Partial harvest section title
  static const String labelPartialHarvest = 'Panen Parsial';

  /// Partial harvest subtitle
  static const String subtitlePartialHarvest =
      'Atur panen parsial yang ingin dilakukan';

  /// Harvest 1 label
  static const String labelHarvest1 = 'Panen 1';

  /// Harvest 2 label
  static const String labelHarvest2 = 'Panen 2';

  /// Main harvest label
  static const String labelMainHarvest = 'Panen Raya';

  /// DOC label (for partial harvest)
  static const String labelDOC = 'DOC';

  /// Harvest percentage label
  static const String labelHarvestPercentage = 'Persentase Panen (%)';

  /// Add harvest plan button text
  static const String buttonAddHarvestPlan = 'Rencana Panen';

  /// Button to return to recommendation
  static const String buttonReturnToRecommendation = 'Balik ke Rekomendasi';

  /// Info text: Capacity will be adjusted according to commodity
  static const String infoCapacityAdjustedByCommodity =
      'Kapasitas akan disesuaikan dengan komoditas.';

  /// Info text: Capacity does not match recommendation
  static const String infoCapacityNotMatchRecommendation =
      'Kapasitas tidak sesuai rekomendasi.';

  /// Weight label
  static const String labelWeight = 'Berat';

  /// Quantity label
  static const String labelQuantity = 'Jumlah';

  // Section Titles
  /// Cultivation information section
  static const String sectionCultivationInfo = 'Informasi Budidaya';

  /// Pond capacity section
  static const String sectionPondCapacity = 'Kapasitas Kolam';

  /// Growth target section
  static const String sectionGrowthTarget = 'Target Pertumbuhan';

  /// Commodity and feed price section
  static const String sectionPriceInfo = 'Harga Komoditas & Pakan';

  /// Feed price section (for Agent mode)
  static const String sectionFeedPrice = 'Harga Pakan';

  /// Harvest price section (for Agent mode)
  static const String sectionHarvestPrice = 'Harga Panen';

  // Chart Titles
  /// Biomass and partial harvest chart title
  static const String chartBiomassAndPartialHarvest =
      'Grafik Biomassa dan Panen Parsial';

  /// Feed expenditure vs revenue chart title
  static const String chartFeedExpenditureVsRevenue =
      'Pengeluaran vs Pendapatan';

  /// Table section title
  static const String tableTitle = 'Pengeluaran Pakan vs Potensi Pendapatan';

  /// Metric tile title - potential revenue
  static const String metricPotentialRevenue = 'Total Potensi Pendapatan';

  /// Metric tile title - potential expenditure
  static const String metricPotentialExpenditure = 'Estimasi Pengeluaran Pakan';

  /// Profit banner label
  static const String metricPotentialProfit = 'Potensi Profit';

  /// Partial harvest action label
  static const String actionAdjustPartialHarvest = 'Atur Panen Parsial';

  /// Toggle label for chart view
  static const String toggleChart = 'Chart';

  /// Toggle label for table view
  static const String toggleTable = 'Table';

  // Table Headers
  /// DOC column header
  static const String tableHeaderDOC = 'DOC';

  /// Weight column header
  static const String tableHeaderWeight = 'Berat';

  /// Quantity column header
  static const String tableHeaderQuantity = 'Jumlah';

  /// SR column header
  static const String tableHeaderSR = 'SR';

  /// FCR column header
  static const String tableHeaderFCR = 'FCR';

  /// ADG column header
  static const String tableHeaderADG = 'ADG';

  /// Biomass column header
  static const String tableHeaderBiomass = 'Biomassa';

  /// Selling Price column header
  static const String tableHeaderSellingPrice = 'Harga Jual';

  /// Feed Price column header
  static const String tableHeaderFeedPrice = 'Harga Pakan';

  /// Revenue column header
  static const String tableHeaderRevenue = 'Pendapatan';

  /// Feed Expenditure column header
  static const String tableHeaderFeedExpenditure = 'Pengeluaran Pakan';

  /// Profit column header
  static const String tableHeaderProfit = 'Profit';

  // Search
  /// Search cycles placeholder
  static const String hintSearchCycles = 'Cari Hitungan Budidaya Sebelumnya';

  // Dynamic Text Helpers
  /// Get simulation count text with proper pluralization
  static String simulationCount(int count) {
    return '$count ${count == 1 ? 'siklus' : 'siklus'}';
  }

  // Screen Titles - Additional
  /// Preview screen title
  static const String titlePreview = 'Preview';

  // Agent Mode - LTV Section
  static const String sectionLoanRiskLTV = 'Resiko Pinjaman (LTV)';
  static const String labelLTVIdeal = 'Ideal (LTV<70%)';
  static const String labelLTVWarning = 'Waspada (71%-79%)';
  static const String labelLTVHighRisk = 'Resiko Tinggi (>80%)';
  static const String messageLTVHealthy =
      'Nilai LTV petani sebesar {value}% mencerminkan rasio yang sehat dan berada dalam batas aman.';
  static const String messageLTVHealthyPrefix = 'Nilai LTV petani sebesar ';
  static const String messageLTVHealthySuffix =
      ' mencerminkan rasio yang sehat dan berada dalam batas aman.';
  static const String titleLTVInfo = 'Penjelasan LTV';
  static const String descriptionLTV =
      'LTV atau Loan to Value adalah rasio pinjaman terhadap nilai aset. Aset disini merupakan Potensi Panen. Jadi artian serapannya merupakan: Rasio Pinjaman Terhadap Potensi Hasil Panen';
  
  // LTV Risk Thresholds
  static const double ltvIdealThreshold = 70.0;
  static const double ltvWarningMin = 71.0;
  static const double ltvWarningMax = 79.0;
  
  // LTV Risk Status Labels
  static const String ltvRiskStatusIdeal = 'Ideal';
  static const String ltvRiskStatusWarning = 'Waspada';
  static const String ltvRiskStatusHigh = 'Resiko Tinggi';

  // Agent Mode - Metrics
  static const String metricHarvestGuaranteePotential =
      'Potensi Jaminan Panen';
  static const String metricCultivationProgress = 'Progres Budidaya';
  static const String metricCurrentABW = 'Estimasi ABW Saat Ini';
  static const String metricHarvestABW = 'Estimasi ABW Saat Panen';
  static const String metricFeedNeeds = 'Estimasi Kebutuhan Pakan';
  static const String metricFeedNeedsUntilHarvest =
      'Estimasi Kebutuhan Pakan Hingga Panen';
  static const String metricMaxLoanCeiling = 'Plafon Pinjaman Maksimal';

  // Agent Mode - Loan Analysis
  static const String sectionLoanAnalysis = 'Analisis Potensi Pinjaman';
  static const String labelTotalCostNeeds = 'Total Kebutuhan Biaya';
  static const String labelRecommendedLoan = 'Pinjaman Yang Disarankan';
  static const String labelLoanCeilingTaken = 'Plafon Yang Diambil';
  static const String labelRemainingCredit = 'Sisa Kredit';
  static const String labelCreditLimit = 'Limit Kredit';

  // Button Labels - Additional
  /// Cancel button text
  static const String buttonCancel = 'Batal';

  /// Preview button text
  static const String buttonPreview = 'Preview';

  // Status Messages
  /// Coming soon message for distributor agent
  static const String messageDistributorComingSoon = 'Agen Distributor (coming soon)';

  // Download
  /// Download simulation title
  static const String titleDownloadSimulation = 'Unduh Simulasi';

  /// Download simulation subtitle
  static const String subtitleChooseFileType = 'Pilih tipe file';

  /// PDF option
  static const String optionPDF = 'PDF';

  /// CSV option
  static const String optionCSV = 'CSV';

  // Commodity Options
  /// Shrimp commodity
  static const String commodityShrimp = 'Udang';

  /// Tilapia commodity
  static const String commodityTilapia = 'Tilapia';

  /// Nila commodity
  static const String commodityNila = 'Nila';

  /// Fish commodity (legacy)
  static const String commodityFish = 'Ikan';

  // Commodity Selection Modal
  /// Title for commodity selection modal
  static const String titleSelectCommodity = 'Pilih Komoditas';

  /// Subtitle for commodity selection modal
  static const String subtitleSelectCommodity = 'Tentukan komoditas pilihanmu.';

  // Cultivation System Options
  /// RAS (Recirculating Aquaculture System)
  static const String systemRAS = 'RAS';

  /// Biofloc system
  static const String systemBiofloc = 'Biofloc';

  /// Traditional system
  static const String systemTraditional = 'Traditional';

  // Cultivation System Descriptions
  /// RAS system description
  static const String descriptionRAS =
      'Sistem tertutup dengan filtrasi penuh kualitas air.';

  /// Biofloc system description
  static const String descriptionBiofloc =
      'Bakteri floc mengolah limbah menjadi pakan alami.';

  /// Traditional system description
  static const String descriptionTraditional =
      'Mengandalkan kondisi alami dengan padat tebar rendah.';

  // Cultivation System Selection Modal
  /// Title for cultivation system selection modal
  static const String titleSelectCultivationSystem = 'Pilih Sistem Budidaya';

  /// Subtitle for cultivation system selection modal
  static const String subtitleSelectCultivationSystem =
      'Tentukan sistem budidaya pilihanmu.';

  // Units
  /// Square meters unit
  static const String unitSquareMeters = 'm²';

  /// Meters unit
  static const String unitMeters = 'm';

  /// Kilograms unit
  static const String unitKilograms = 'kg';

  /// Percentage unit
  static const String unitPercentage = '%';

  // Validation Messages
  /// Error when simulation name is empty
  static const String errorSimulationNameRequired =
      'Nama simulasi tidak boleh kosong';

  /// Error when commodity is not selected
  static const String errorCommodityRequired = 'Komoditas harus dipilih';

  /// Error when cultivation system is not selected
  static const String errorCultivationSystemRequired =
      'Sistem budidaya harus dipilih';

  /// Error when pond area is invalid
  static const String errorPondAreaInvalid = 'Luas kolam tidak valid';

  /// Error when pond depth is invalid
  static const String errorPondDepthInvalid = 'Kedalaman kolam tidak valid';

  /// Error when fry count is invalid
  static const String errorFryCountInvalid = 'Jumlah benur tidak valid';

  // Default Values
  /// Default pond name
  static const String defaultPondName = 'Kolam 1';

  /// Default pond area
  static const double defaultPondArea = 40;

  /// Default fry count
  static const int defaultFryCount = 1000;

  /// Default target harvest
  static const double defaultTargetHarvest = 20;

  /// Default target ADG
  static const double defaultTargetADG = 100;
}
