import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/theme/app_colors.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppColors', () {
    test('should have correct primary colors', () {
      // Assert
      expect(AppColors.primary, isA<Color>());
      expect(AppColors.primary.value, equals(0xFF122E7A));
      expect(AppColors.primary20, isA<Color>());
      expect(AppColors.primary20.value, equals(0xFFE3E8F5));
    });

    test('should have correct gray colors', () {
      // Assert
      expect(AppColors.gray100, isA<Color>());
      expect(AppColors.gray100.value, equals(0xFF1A1A1A));
      expect(AppColors.gray70, isA<Color>());
      expect(AppColors.gray70.value, equals(0xFF6D6D6D));
      expect(AppColors.gray20, isA<Color>());
      expect(AppColors.gray20.value, equals(0xFFEEEEEE));
      expect(AppColors.gray05, isA<Color>());
      expect(AppColors.gray05.value, equals(0xFFF5F5F5));
    });

    test('should have correct info colors', () {
      // Assert
      expect(AppColors.infoLight, isA<Color>());
      expect(AppColors.infoLight.value, equals(0xFFE3F2FD));
    });

    test('should have correct neutral colors', () {
      // Assert
      expect(AppColors.white, isA<Color>());
      expect(AppColors.white.value, equals(0xFFFFFFFF));
      expect(AppColors.black, isA<Color>());
      expect(AppColors.black.value, equals(0xFF000000));
    });

    test('should have correct secondary colors', () {
      // Assert
      expect(AppColors.secondary, isA<Color>());
      expect(AppColors.secondary.value, equals(0xFFFA6619));
    });

    test('should have correct input data colors for Pakan', () {
      // Assert
      expect(AppColors.inputDataPakanBg, isA<Color>());
      expect(AppColors.inputDataPakanBg.value, equals(0x1426C3BB));
      expect(AppColors.inputDataPakanIcon, isA<Color>());
      expect(AppColors.inputDataPakanIcon.value, equals(0xFF26C3BB));
    });

    test('should have correct input data colors for Kualitas Air', () {
      // Assert
      expect(AppColors.inputDataKualitasAirBg, isA<Color>());
      expect(AppColors.inputDataKualitasAirBg.value, equals(0x14135CED));
      expect(AppColors.inputDataKualitasAirIcon, isA<Color>());
      expect(AppColors.inputDataKualitasAirIcon.value, equals(0xFF135CED));
    });

    test('should have correct input data colors for Pertumbuhan', () {
      // Assert
      expect(AppColors.inputDataPertumbuhanBg, isA<Color>());
      expect(AppColors.inputDataPertumbuhanBg.value, equals(0x148400FF));
      expect(AppColors.inputDataPertumbuhanIcon, isA<Color>());
      expect(AppColors.inputDataPertumbuhanIcon.value, equals(0xFF8400FF));
    });

    test('should have correct input data colors for Kimia', () {
      // Assert
      expect(AppColors.inputDataKimiaBg, isA<Color>());
      expect(AppColors.inputDataKimiaBg.value, equals(0x14FA6619));
      expect(AppColors.inputDataKimiaIcon, isA<Color>());
      expect(AppColors.inputDataKimiaIcon.value, equals(0xFFFA6619));
    });

    test('should have correct input data colors for Plankton', () {
      // Assert
      expect(AppColors.inputDataPlanktonBg, isA<Color>());
      expect(AppColors.inputDataPlanktonBg.value, equals(0x14137FEC));
      expect(AppColors.inputDataPlanktonIcon, isA<Color>());
      expect(AppColors.inputDataPlanktonIcon.value, equals(0xFF137FEC));
    });

    test('should have correct input data colors for Mikrobiologi', () {
      // Assert
      expect(AppColors.inputDataMikrobiologiBg, isA<Color>());
      expect(AppColors.inputDataMikrobiologiBg.value, equals(0x141BAA69));
      expect(AppColors.inputDataMikrobiologiIcon, isA<Color>());
      expect(AppColors.inputDataMikrobiologiIcon.value, equals(0xFF1BAA69));
    });

    test('should have correct input data colors for Penyakit', () {
      // Assert
      expect(AppColors.inputDataPenyakitBg, isA<Color>());
      expect(AppColors.inputDataPenyakitBg.value, equals(0x14BD7F3C));
      expect(AppColors.inputDataPenyakitIcon, isA<Color>());
      expect(AppColors.inputDataPenyakitIcon.value, equals(0xFFBD7F3C));
    });

    test('should have correct input data colors for Kematian', () {
      // Assert
      expect(AppColors.inputDataKematianBg, isA<Color>());
      expect(AppColors.inputDataKematianBg.value, equals(0x14D84639));
      expect(AppColors.inputDataKematianIcon, isA<Color>());
      expect(AppColors.inputDataKematianIcon.value, equals(0xFFD84639));
    });
  });
}

