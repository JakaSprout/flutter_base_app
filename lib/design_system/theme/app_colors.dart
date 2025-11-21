import 'package:flutter/material.dart';

/// Design tokens for colors based on Figma design system.
///
/// This class contains all color constants used across the application
/// to ensure consistency and maintainability.
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary Colors
  /// Primary/60 (Base) - Main brand color
  static const Color primary = Color(0xFF122E7A);

  /// Primary/20 - Light primary color for borders, backgrounds
  static const Color primary20 = Color(0xFFE3E8F5);

  // Gray Colors
  /// Gray/100 - Dark gray for text
  static const Color gray100 = Color(0xFF1A1A1A);

  /// Gray/70 - Medium gray for inactive states
  static const Color gray70 = Color(0xFF6D6D6D);

  /// Gray/60 - Medium gray for labels
  static const Color gray60 = Color(0xFF8A8A8A);

  /// Gray/40 - Border gray
  static const Color gray40 = Color(0xFFBDBDBD);

  /// Gray/20 - Light gray for borders
  static const Color gray20 = Color(0xFFE3E3E3);

  /// Gray/10 - Very light gray for dividers
  static const Color gray10 = Color(0xFFEBEBEB);

  /// Gray/05 - Very light gray for card backgrounds
  static const Color gray05 = Color(0xFFF5F5F5);

  // Info Colors
  /// Info/Light - Light blue for info backgrounds
  static const Color infoLight = Color(0xFFE3F2FD);

  // Neutral Colors
  /// Neutral/White
  static const Color white = Color(0xFFFFFFFF);

  /// Neutral/Black
  static const Color black = Color(0xFF000000);

  // Semantic Colors
  /// Success base
  static const Color success = Color(0xFF1BAA69);

  /// Success light background
  static const Color successLight = Color(0xFFE8F8F0);

  /// Success dark text
  static const Color successDark = Color(0xFF0F6B44);

  /// Error base
  static const Color error = Color(0xFFD84639);

  /// Error light background
  static const Color errorLight = Color(0xFFFCE9E7);

  // Secondary Colors
  /// Secondary/60 (Base) - Orange for CTAs and links
  static const Color secondary = Color(0xFFFA6619);

  // Input Data Section Colors (with 8% opacity backgrounds)
  /// Pakan - Teal background
  // rgba(38, 195, 187, 0.08)
  static const Color inputDataPakanBg = Color(0x1426C3BB);
  static const Color inputDataPakanIcon = Color(0xFF26C3BB);

  /// Kualitas Air - Blue background
  // rgba(19, 92, 237, 0.08)
  static const Color inputDataKualitasAirBg = Color(0x14135CED);
  static const Color inputDataKualitasAirIcon = Color(0xFF135CED);

  /// Pertumbuhan - Purple background
  // rgba(132, 0, 255, 0.08)
  static const Color inputDataPertumbuhanBg = Color(0x148400FF);
  static const Color inputDataPertumbuhanIcon = Color(0xFF8400FF);

  /// Kimia - Orange background
  // rgba(250, 102, 25, 0.08)
  static const Color inputDataKimiaBg = Color(0x14FA6619);
  static const Color inputDataKimiaIcon = Color(0xFFFA6619);

  /// Plankton - Blue background
  // rgba(19, 127, 236, 0.08)
  static const Color inputDataPlanktonBg = Color(0x14137FEC);
  static const Color inputDataPlanktonIcon = Color(0xFF137FEC);

  /// Mikrobiologi - Green background
  // rgba(27, 170, 105, 0.08)
  static const Color inputDataMikrobiologiBg = Color(0x141BAA69);
  static const Color inputDataMikrobiologiIcon = Color(0xFF1BAA69);

  /// Penyakit - Brown background
  // rgba(189, 127, 60, 0.08)
  static const Color inputDataPenyakitBg = Color(0x14BD7F3C);
  static const Color inputDataPenyakitIcon = Color(0xFFBD7F3C);

  /// Kematian - Red background
  // rgba(216, 70, 57, 0.08)
  static const Color inputDataKematianBg = Color(0x14D84639);
  static const Color inputDataKematianIcon = Color(0xFFD84639);

  // Text Colors
  /// Text primary color (Neutral/90)
  static const Color textPrimary = Color(0xFF1E1E1E);

  /// Text secondary color (Neutral/50)
  static const Color textSecondary = Color(0xFF464445);

  // Warning Colors
  /// Warning base color
  static const Color warning = Color(0xFFFDBA74);

  // Chart Colors - Loan Analysis
  /// Chart purple color for Total Cost Needs
  static const Color chartPurple = Color(0xFF9333EA);

  /// Chart blue-500 color for Loan Ceiling Taken
  static const Color chartBlue500 = Color(0xFF3B82F6);

  /// Chart blue-300 color for Remaining Credit
  static const Color chartBlue300 = Color(0xFF93C5FD);

  // Background Colors
  /// Action chip background color
  static const Color actionChipBackground = Color(0xFFF7F7F7);

  /// Simulation card icon background blue
  static const Color simulationCardIconBackgroundBlue = Color(0xFFE7ECFA);

  /// Simulation card icon background orange
  static const Color simulationCardIconBackgroundOrange = Color(0xFFFFF4E6);

  /// Success banner background color (Light green)
  static const Color successBannerBackground = Color(0xFFD7F5DF);

  /// Light background gray
  static const Color lightBackgroundGray = Color(0xFFF4F4F4);

  /// Light background gray variant
  static const Color lightBackgroundGrayAlt = Color(0xFFF4F4F6);

  /// Blue background variant
  static const Color blueBackground = Color(0xFFE6ECFF);

  /// Light blue background
  static const Color lightBlueBackground = Color(0xFFE3F2FD);

  // Neutral Colors (Extended)
  /// Neutral/80 color (Dark gray)
  static const Color neutral80 = Color(0xFF2F2D2E);

  /// Neutral/50 color (Medium gray)
  static const Color neutral50 = Color(0xFF464445);

  // Accent Colors
  /// Blue accent color
  static const Color blueAccent = Color(0xFF60A5FA);

  /// Orange accent color
  static const Color orangeAccent = Color(0xFFF97316);

  /// Green accent color
  static const Color greenAccent = Color(0xFF22C55E);

  /// Dark blue accent color
  static const Color darkBlueAccent = Color(0xFF1D4ED8);
}
