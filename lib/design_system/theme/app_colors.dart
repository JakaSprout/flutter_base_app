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

  // TODO: Add more colors as needed from Figma design system
  // - Success colors
  // - Warning colors
  // - Error colors
  // - etc.
}
