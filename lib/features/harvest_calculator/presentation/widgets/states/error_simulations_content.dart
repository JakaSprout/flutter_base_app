import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter/material.dart';

/// Error state content for simulations list.
class ErrorSimulationsContent extends StatelessWidget {
  /// Creates a new instance of [ErrorSimulationsContent].
  const ErrorSimulationsContent({
    required this.error,
    required this.onRetry,
    super.key,
  });

  /// The error message to display.
  final String error;

  /// Callback when retry button is pressed.
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(
          HarvestCalculatorDesignConstants.spacing16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: HarvestCalculatorDesignConstants.errorColor,
            ),
            const SizedBox(height: HarvestCalculatorDesignConstants.spacing16),
            const Text(
              'Gagal Memuat Simulasi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: HarvestCalculatorDesignConstants.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: HarvestCalculatorDesignConstants.spacing8),
            Text(
              error,
              style: const TextStyle(
                fontSize: 14,
                color: HarvestCalculatorDesignConstants.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: HarvestCalculatorDesignConstants.spacing24),
            SizedBox(
              width: 200,
              child: OutlinedButton(
                onPressed: onRetry,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: HarvestCalculatorDesignConstants.primary,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      HarvestCalculatorDesignConstants.buttonBorderRadius,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: HarvestCalculatorDesignConstants.spacing16,
                    vertical: HarvestCalculatorDesignConstants.spacing12,
                  ),
                ),
                child: const Text(
                  'Coba Lagi',
                  style: TextStyle(
                    color: HarvestCalculatorDesignConstants.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
