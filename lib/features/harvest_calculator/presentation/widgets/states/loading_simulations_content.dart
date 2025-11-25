import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_design_constants.dart';
import 'package:flutter/material.dart';

/// Loading state content for simulations list.
class LoadingSimulationsContent extends StatelessWidget {
  /// Creates a new instance of [LoadingSimulationsContent].
  const LoadingSimulationsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                HarvestCalculatorDesignConstants.primary,
              ),
            ),
          ),
          SizedBox(height: HarvestCalculatorDesignConstants.spacing16),
          Text(
            'Memuat Simulasi...',
            style: TextStyle(
              fontSize: 14,
              color: HarvestCalculatorDesignConstants.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
