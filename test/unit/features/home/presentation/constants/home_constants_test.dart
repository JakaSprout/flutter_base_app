import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/home/presentation/constants/home_constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeConstants', () {
    test('should have correct default values', () {
      // Assert
      expect(HomeConstants.defaultUserName, equals('Danang Winaryo'));
      expect(HomeConstants.defaultJobTitle, equals('Techician'));
      expect(HomeConstants.defaultCompanyName, equals('PT. Tambak Bersama'));
    });

    test('should have correct company labels', () {
      // Assert
      expect(HomeConstants.companyLabel, equals('Nama Perusahaan:'));
      expect(HomeConstants.companySelectionLabel, equals('Nama PT'));
    });

    test('should have correct block filter constants', () {
      // Assert
      expect(HomeConstants.blockFilterLabel, equals('Blok yang ditampilkan'));
      expect(HomeConstants.defaultBlock, equals('Semua Blok'));
    });

    test('should have correct dashboard summary constants', () {
      // Assert
      expect(HomeConstants.defaultActivePonds, equals(8));
      expect(HomeConstants.cardEstimasiBiomassaTitle, equals('Estimasi Biomassa'));
      expect(HomeConstants.cardTotalPakanTitle, equals('Total Pakan'));
      expect(HomeConstants.cardBiayaPakanTitle, equals('Biaya Pakan'));
      expect(HomeConstants.cardEstimasiSRTitle, equals('Estimasi SR'));
    });

    test('should have correct default dashboard values', () {
      // Assert
      expect(HomeConstants.defaultEstimasiBiomassa, equals('0'));
      expect(HomeConstants.defaultTotalPakan, equals('1.000'));
      expect(HomeConstants.defaultBiayaPakan, equals('20'));
      expect(HomeConstants.defaultEstimasiSR, equals('100'));
    });

    test('should generate correct active ponds subtitle', () {
      // Act
      final subtitle1 = HomeConstants.activePondsSubtitle(8);
      final subtitle2 = HomeConstants.activePondsSubtitle(10);

      // Assert
      expect(subtitle1, equals('dari 8 kolam aktif'));
      expect(subtitle2, equals('dari 10 kolam aktif'));
    });

    test('should have correct show/hide labels', () {
      // Assert
      expect(HomeConstants.showAllLabel, equals('Tampilkan Semua'));
      expect(HomeConstants.hideLabel, equals('Sembunyikan'));
    });

    test('should have correct input data section constants', () {
      // Assert
      expect(HomeConstants.inputDataSectionTitle, equals('Input Data'));
      expect(HomeConstants.inputDataSeeAllLabel, equals('Lihat Semua'));
    });

    test('should have correct input data item labels', () {
      // Assert
      expect(HomeConstants.inputDataPakan, equals('Pakan'));
      expect(HomeConstants.inputDataKualitasAir, equals('Kualitas Air'));
      expect(HomeConstants.inputDataPertumbuhan, equals('Pertumbuhan'));
      expect(HomeConstants.inputDataKimia, equals('Kimia'));
      expect(HomeConstants.inputDataPlankton, equals('Plankton'));
      expect(HomeConstants.inputDataMikrobiologi, equals('Mikrobiologi'));
      expect(HomeConstants.inputDataPenyakit, equals('Penyakit'));
      expect(HomeConstants.inputDataKematian, equals('Kematian'));
    });

    test('should have correct pond list section constants', () {
      // Assert
      expect(HomeConstants.pondListSectionTitle, equals('Daftar Kolam'));
      expect(HomeConstants.pondListSeeAllLabel, equals('Lihat Semua'));
    });

    test('should return default ponds list', () {
      // Act
      final ponds = HomeConstants.defaultPonds;

      // Assert
      expect(ponds.length, equals(8));
      expect(ponds[0].name, equals('Kolam A1'));
      expect(ponds[0].id, equals('TKH00A1'));
      expect(ponds.last.name, equals('Kolam B1'));
      expect(ponds.last.id, equals('TKH00A3'));
    });

    test('should return harvest calculator cards', () {
      // Act
      final cards = HomeConstants.harvestCalculatorCards;

      // Assert
      expect(cards.length, equals(2));
      expect(cards[0].id, equals('harvest_calculator'));
      expect(cards[0].title, equals('Kalkulator Panen'));
      expect(cards[0].description, contains('potensi hasil panen'));
      expect(cards[1].id, equals('lab_analysis'));
      expect(cards[1].title, equals('Analisis Lab'));
      expect(cards[1].description, contains('analisis laboratorium'));
    });
  });

  group('HarvestCalculatorCardData', () {
    test('should create card data with all properties', () {
      // Arrange & Act
      const card = HarvestCalculatorCardData(
        id: 'test_id',
        title: 'Test Title',
        description: 'Test Description',
        imagePath: 'assets/test.jpg',
        backgroundColor: Colors.white,
      );

      // Assert
      expect(card.id, equals('test_id'));
      expect(card.title, equals('Test Title'));
      expect(card.description, equals('Test Description'));
      expect(card.imagePath, equals('assets/test.jpg'));
      expect(card.backgroundColor, equals(Colors.white));
    });
  });

  group('PondData', () {
    test('should create pond data with name and id', () {
      // Arrange & Act
      const pond = PondData(name: 'Kolam A1', id: 'TKH00A1');

      // Assert
      expect(pond.name, equals('Kolam A1'));
      expect(pond.id, equals('TKH00A1'));
    });
  });
}

