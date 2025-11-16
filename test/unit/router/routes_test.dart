import 'package:flutter_base_app/router/routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Routes', () {
    test('should have correct route paths', () {
      // Assert
      expect(Routes.home, equals('/'));
      expect(Routes.graph, equals('/graph'));
      expect(Routes.inputData, equals('/input-data'));
      expect(Routes.pond, equals('/pond'));
      expect(Routes.profile, equals('/profile'));
      expect(Routes.splash, equals('/splash'));
      expect(Routes.login, equals('/login'));
    });

    test('should have correct route names', () {
      // Assert
      expect(Routes.homeName, equals('home'));
      expect(Routes.graphName, equals('graph'));
      expect(Routes.inputDataName, equals('input-data'));
      expect(Routes.pondName, equals('pond'));
      expect(Routes.profileName, equals('profile'));
      expect(Routes.splashName, equals('splash'));
      expect(Routes.loginName, equals('login'));
    });

    test('should have matching route paths and names', () {
      // Assert - Verify that route names correspond to their paths
      expect(Routes.home, equals('/'));
      expect(Routes.homeName, equals('home'));
      expect(Routes.login, equals('/login'));
      expect(Routes.loginName, equals('login'));
    });
  });
}

