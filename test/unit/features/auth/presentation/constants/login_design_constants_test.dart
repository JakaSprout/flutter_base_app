import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/auth/presentation/constants/login_design_constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginDesignConstants', () {
    test('should have correct border radius values', () {
      // Assert
      expect(LoginDesignConstants.cardBorderRadius, equals(16));
      expect(LoginDesignConstants.inputBorderRadius, equals(8));
    });

    test('should have correct padding and spacing values', () {
      // Assert
      expect(LoginDesignConstants.cardPadding, equals(24));
      expect(LoginDesignConstants.spacingSmall, equals(8));
      expect(LoginDesignConstants.spacingMedium, equals(16));
      expect(LoginDesignConstants.spacingLarge, equals(24));
      expect(LoginDesignConstants.spacingXLarge, equals(32));
    });

    test('should have correct size values', () {
      // Assert
      expect(LoginDesignConstants.logoHeight, equals(28));
      expect(LoginDesignConstants.buttonHeight, equals(48));
      expect(LoginDesignConstants.loadingIndicatorSize, equals(20));
      expect(LoginDesignConstants.loadingIndicatorStrokeWidth, equals(2));
    });

    test('should have correct background color', () {
      // Assert
      expect(LoginDesignConstants.backgroundBlue, isA<Color>());
      expect(LoginDesignConstants.backgroundBlue.value, equals(0xFF122E7A));
    });

    test('should have correct input padding values', () {
      // Assert
      expect(LoginDesignConstants.inputPaddingHorizontal, equals(16));
      expect(LoginDesignConstants.inputPaddingVertical, equals(16));
    });

    test('should have correct shadow values', () {
      // Assert
      expect(LoginDesignConstants.boxShadowOpacity, equals(0.1));
      expect(LoginDesignConstants.boxShadowBlurRadius, equals(10));
      expect(LoginDesignConstants.boxShadowOffsetY, equals(4));
    });

    test('should have correct constraints', () {
      // Assert
      expect(LoginDesignConstants.maxCardWidth, equals(400));
    });
  });
}
