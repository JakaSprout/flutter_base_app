import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';

/// Constants for Home feature.
///
/// Contains all text constants and default values for Home screen
/// to avoid hardcoded strings throughout the feature.
class HomeConstants {
  // Private constructor to prevent instantiation
  HomeConstants._();

  // Default Values
  /// Default user name
  static const String defaultUserName = 'Danang Winaryo';

  /// Default job title
  static const String defaultJobTitle = 'Techician';

  /// Default company name
  static const String defaultCompanyName = 'PT. Tambak Bersama';

  // Labels
  /// Company label text (old, for backward compatibility)
  static const String companyLabel = 'Nama Perusahaan:';

  /// Company selection label text (new design)
  static const String companySelectionLabel = 'Nama PT';

  // Block Filter Section
  /// Block filter label text
  static const String blockFilterLabel = 'Blok yang ditampilkan';

  /// Default block name
  static const String defaultBlock = 'Semua Blok';

  // Dashboard Summary Cards Section
  /// Default number of active ponds
  static const int defaultActivePonds = 8;

  /// Card titles
  static const String cardEstimasiBiomassaTitle = 'Estimasi Biomassa';
  static const String cardTotalPakanTitle = 'Total Pakan';
  static const String cardBiayaPakanTitle = 'Biaya Pakan';
  static const String cardEstimasiSRTitle = 'Estimasi SR';

  /// Default values (without units, units are passed separately)
  static const String defaultEstimasiBiomassa = '0';
  static const String defaultTotalPakan = '1.000';
  static const String defaultBiayaPakan = '20';
  static const String defaultEstimasiSR = '100';

  /// Subtitle template
  static String activePondsSubtitle(int activePonds) {
    return 'dari $activePonds kolam aktif';
  }

  /// Show all label
  static const String showAllLabel = 'Tampilkan Semua';

  /// Hide label (for collapse)
  static const String hideLabel = 'Sembunyikan';

  // Input Data Section
  /// Input Data section title
  static const String inputDataSectionTitle = 'Input Data';

  /// See all label for Input Data section
  static const String inputDataSeeAllLabel = 'Lihat Semua';

  /// Input Data item labels
  static const String inputDataPakan = 'Pakan';
  static const String inputDataKualitasAir = 'Kualitas Air';
  static const String inputDataPertumbuhan = 'Pertumbuhan';
  static const String inputDataKimia = 'Kimia';
  static const String inputDataPlankton = 'Plankton';
  static const String inputDataMikrobiologi = 'Mikrobiologi';
  static const String inputDataPenyakit = 'Penyakit';
  static const String inputDataKematian = 'Kematian';

  // Pond List Section
  /// Pond List section title
  static const String pondListSectionTitle = 'Daftar Kolam';

  /// See all label for Pond List section
  static const String pondListSeeAllLabel = 'Lihat Semua';

  /// Default list of ponds for display
  static List<PondData> get defaultPonds {
    return const [
      PondData(name: 'Kolam A1', id: 'TKH00A1'),
      PondData(name: 'Kolam A2', id: 'TKH00A2'),
      PondData(name: 'Kolam A3', id: 'TKH00A3'),
      PondData(name: 'Kolam B1', id: 'TKH00B1'),
      PondData(name: 'Kolam B2', id: 'TKH00B2'),
      PondData(name: 'Kolam C1', id: 'TKH00C1'),
      PondData(name: 'Kolam C2', id: 'TKH00C2'),
      PondData(name: 'Kolam B1', id: 'TKH00A3'),
    ];
  }

  // Harvest Calculator Section
  /// Harvest Calculator cards data
  static List<HarvestCalculatorCardData> get harvestCalculatorCards {
    return const [
      HarvestCalculatorCardData(
        id: 'harvest_calculator',
        title: 'Kalkulator Panen',
        description: 'Hitung potensi hasil panen Kamu.',
        imagePath: 'assets/images/kalkulator-panen.jpg',
        backgroundColor: AppColors.white,
      ),
      HarvestCalculatorCardData(
        id: 'lab_analysis',
        title: 'Analisis Lab',
        description: 'Lakukan analisis laboratorium untuk kualitas air.',
        imagePath: 'assets/images/analisis-lab.jpg',
        backgroundColor: AppColors.white,
      ),
    ];
  }
}

/// Harvest Calculator Card Data Model.
class HarvestCalculatorCardData {
  /// Creates a new instance of [HarvestCalculatorCardData].
  const HarvestCalculatorCardData({
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

  /// Background color for the card
  final Color backgroundColor;
}

/// Pond data model for list items.
class PondData {
  /// Creates a new instance of [PondData].
  const PondData({required this.name, required this.id});

  /// Pond name (e.g., "Kolam A1")
  final String name;

  /// Pond ID (e.g., "TKH00A1")
  final String id;
}
