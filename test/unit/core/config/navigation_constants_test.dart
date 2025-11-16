import 'package:flutter_base_app/core/config/navigation_constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NavigationConstants', () {
    test('should have correct navigation labels', () {
      // Assert
      expect(NavigationConstants.navHome, equals('Beranda'));
      expect(NavigationConstants.navGraph, equals('Grafik'));
      expect(NavigationConstants.navInputData, equals('Input Data'));
      expect(NavigationConstants.navPond, equals('Kolam'));
      expect(NavigationConstants.navProfile, equals('Profil'));
    });

    test('should have correct screen titles', () {
      // Assert
      expect(NavigationConstants.screenHomeTitle, equals('Beranda'));
      expect(NavigationConstants.screenGraphTitle, equals('Graph'));
      expect(NavigationConstants.screenInputDataTitle, equals('Input Data'));
      expect(NavigationConstants.screenPondTitle, equals('Kolam'));
      expect(NavigationConstants.screenProfileTitle, equals('Profil'));
      expect(NavigationConstants.screenSplashTitle, equals('Splash Screen'));
    });

    test('should have correct placeholder messages', () {
      // Assert
      expect(NavigationConstants.placeholderHome, contains('Home screen'));
      expect(NavigationConstants.placeholderGraph, contains('Graph screen'));
      expect(NavigationConstants.placeholderInputData, contains('Input Data screen'));
      expect(NavigationConstants.placeholderPond, contains('Pond screen'));
      expect(NavigationConstants.placeholderProfile, contains('Profile screen'));
    });
  });
}

