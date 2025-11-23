import 'package:app_mobile_afms/core/error/failures.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/simulation_parameters.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/entities/simulation_result.dart';
import 'package:app_mobile_afms/features/harvest_calculator/domain/services/simulation_orchestrator.dart';
import 'package:app_mobile_afms/features/harvest_calculator/presentation/constants/harvest_calculator_constants.dart';
import 'package:dartz/dartz.dart';

/// Use case for running harvest simulations.
///
/// This use case validates input parameters and orchestrates
/// the simulation execution through the SimulationOrchestrator.
class RunSimulationUseCase {
  const RunSimulationUseCase();

  /// Executes a harvest simulation with the given parameters.
  ///
  /// Returns Either<Failure, SimulationResult> where:
  /// - Right: Successful simulation result
  /// - Left: Failure with error details
  Future<Either<Failure, SimulationResult>> execute(
    SimulationParameters parameters,
  ) async {
    try {
      // Validate input parameters
      final validationError = _validateParameters(parameters);
      if (validationError != null) {
        return Left(validationError);
      }

      // Run simulation
      final result = SimulationOrchestrator.runSimulation(parameters);

      return Right(result);
    } catch (e, stackTrace) {
      return Left(
        SimulationFailure(
          message: HarvestCalculatorConstants.errorSimulationExecutionFailed(e),
          error: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  /// Validates simulation parameters before running simulation.
  /// Validates simulation parameters before running simulation.
  Failure? _validateParameters(SimulationParameters parameters) {
    final isAgentMode = parameters.simulationType == 'agent';

    // Validate basic pond parameters (skip for agent mode)
    final basicValidation = _validateBasicPondParameters(
      parameters,
      isAgentMode,
    );
    if (basicValidation != null) return basicValidation;

    // Validate target parameters
    final targetValidation = _validateTargetParameters(parameters, isAgentMode);
    if (targetValidation != null) return targetValidation;

    // Validate current DOC parameters
    final currentDocValidation = _validateCurrentDocParameters(
      parameters,
      isAgentMode,
    );
    if (currentDocValidation != null) return currentDocValidation;

    // Validate technical parameters (skip for agent mode)
    final technicalValidation = _validateTechnicalParameters(
      parameters,
      isAgentMode,
    );
    if (technicalValidation != null) return technicalValidation;

    // Validate price parameters
    final priceValidation = _validatePriceParameters(parameters);
    if (priceValidation != null) return priceValidation;

    // Validate harvest events
    final harvestValidation = _validateHarvestEvents(parameters, isAgentMode);
    if (harvestValidation != null) return harvestValidation;

    // Validate agent-specific parameters
    final agentValidation = _validateAgentParameters(parameters, isAgentMode);
    if (agentValidation != null) return agentValidation;

    return null; // No validation errors
  }

  /// Validates basic pond parameters (area, density, initial weight).
  Failure? _validateBasicPondParameters(
    SimulationParameters parameters,
    bool isAgentMode,
  ) {
    if (isAgentMode) return null; // Skip for agent mode

    if (parameters.pondArea <= 0) {
      return const ValidationFailure(
        message: HarvestCalculatorConstants.errorPondAreaTooSmall,
      );
    }

    if (parameters.stockingDensity <= 0) {
      return const ValidationFailure(
        message: HarvestCalculatorConstants.errorStockingDensityTooSmall,
      );
    }

    if (parameters.initialWeight <= 0) {
      return const ValidationFailure(
        message: HarvestCalculatorConstants.errorInitialWeightTooSmall,
      );
    }

    return null;
  }

  /// Validates target parameters (SR, harvest weight, FCR, DOC).
  Failure? _validateTargetParameters(
    SimulationParameters parameters,
    bool isAgentMode,
  ) {
    if (parameters.targetSR < 0 || parameters.targetSR > 100) {
      return const ValidationFailure(
        message: HarvestCalculatorConstants.errorTargetSrOutOfRange,
      );
    }

    if (!isAgentMode && parameters.targetHarvestWeight <= 0) {
      return const ValidationFailure(
        message: HarvestCalculatorConstants.errorTargetHarvestWeightTooSmall,
      );
    }

    if (parameters.estimatedFCR <= 0) {
      return const ValidationFailure(
        message: HarvestCalculatorConstants.errorEstimatedFcrTooSmall,
      );
    }

    if (parameters.targetDOC <= 0) {
      return const ValidationFailure(
        message: HarvestCalculatorConstants.errorTargetDocTooSmall,
      );
    }

    return null;
  }

  /// Validates current DOC parameters based on simulation mode.
  Failure? _validateCurrentDocParameters(
    SimulationParameters parameters,
    bool isAgentMode,
  ) {
    if (isAgentMode) {
      // Agent mode: currentDOC is required
      if (parameters.currentDOC == null || parameters.currentDOC! <= 0) {
        return const ValidationFailure(
          message: HarvestCalculatorConstants.errorCurrentDocRequiredForAgent,
        );
      }
      if (parameters.currentDOC! >= parameters.targetDOC) {
        return const ValidationFailure(
          message: HarvestCalculatorConstants.errorCurrentDocSmallerThanTarget,
        );
      }
    } else if (parameters.currentDOC != null) {
      // Cycle mode: if currentDOC is provided (mid-cycle), validate it
      if (parameters.currentDOC! <= 0) {
        return const ValidationFailure(
          message: HarvestCalculatorConstants.errorCurrentDocTooSmall,
        );
      }
      if (parameters.currentDOC! >= parameters.targetDOC) {
        return const ValidationFailure(
          message: HarvestCalculatorConstants.errorCurrentDocSmallerThanTarget,
        );
      }
    }

    return null;
  }

  /// Validates technical parameters (ADG, loss percentage, capacity).
  Failure? _validateTechnicalParameters(
    SimulationParameters parameters,
    bool isAgentMode,
  ) {
    if (isAgentMode) return null; // Skip for agent mode

    if (parameters.estimatedADG <= 0) {
      return const ValidationFailure(
        message: HarvestCalculatorConstants.errorEstimatedAdgTooSmall,
      );
    }

    if (parameters.dailyLossPercentage < 0 ||
        parameters.dailyLossPercentage > 100) {
      return const ValidationFailure(
        message: HarvestCalculatorConstants.errorDailyLossPercentageOutOfRange,
      );
    }

    if (parameters.capacityKgPerM2 <= 0) {
      return const ValidationFailure(
        message: HarvestCalculatorConstants.errorCapacityPerM2TooSmall,
      );
    }

    if (parameters.capacityKgPerPond <= 0) {
      return const ValidationFailure(
        message: HarvestCalculatorConstants.errorCapacityPerPondTooSmall,
      );
    }

    return null;
  }

  /// Validates price parameters (selling price, feed price, feeding rate).
  Failure? _validatePriceParameters(SimulationParameters parameters) {
    final isAgentMode = parameters.simulationType == 'agent';

    // Skip selling price validation for agent mode (agent uses harvest purchase price instead)
    if (!isAgentMode && parameters.sellingPricePerKg <= 0) {
      return const ValidationFailure(
        message: HarvestCalculatorConstants.errorSellingPricePerKgTooSmall,
      );
    }

    if (parameters.feedPricePerKg <= 0) {
      return const ValidationFailure(
        message: HarvestCalculatorConstants.errorFeedPricePerKgTooSmall,
      );
    }

    // Skip feeding rate validation for agent mode (agent doesn't have feeding rate field)
    if (!isAgentMode &&
        (parameters.feedingRatePercentage <= 0 ||
            parameters.feedingRatePercentage > 100)) {
      return const ValidationFailure(
        message:
            HarvestCalculatorConstants.errorFeedingRatePercentageOutOfRange,
      );
    }

    return null;
  }

  /// Validates harvest events parameters.
  Failure? _validateHarvestEvents(
    SimulationParameters parameters,
    bool isAgentMode,
  ) {
    for (final event in parameters.harvestEvents) {
      final isFinalHarvest =
          event.description?.toLowerCase().contains('raya') ?? false;
      final isAutomaticHarvest =
          event.description?.toLowerCase().contains('otomatis') ?? false;
      final isAgentModeHarvest = isAgentMode && !isFinalHarvest;

      // For manual harvests, validate DOC range
      if (!isAutomaticHarvest && !isFinalHarvest && !isAgentModeHarvest) {
        final maxAllowedDoc = parameters.targetDOC - 1;
        if (event.doc <= 0 || event.doc > maxAllowedDoc) {
          return ValidationFailure(
            message: HarvestCalculatorConstants.errorManualHarvestDocOutOfRange(
              maxAllowedDoc,
            ),
          );
        }
      }

      if (event.percentage <= 0 || event.percentage > 100) {
        return const ValidationFailure(
          message: HarvestCalculatorConstants.errorHarvestPercentageOutOfRange,
        );
      }
    }

    return null;
  }

  /// Validates agent-specific parameters.
  Failure? _validateAgentParameters(
    SimulationParameters parameters,
    bool isAgentMode,
  ) {
    if (!isAgentMode) return null; // Skip for non-agent modes

    // Validate current biomass for agent mode
    if (parameters.currentBiomass == null || parameters.currentBiomass! <= 0) {
      return const ValidationFailure(
        message: HarvestCalculatorConstants.errorCurrentBiomassRequired,
      );
    }

    // Validate stocking for agent mode (manual input)
    if (parameters.stocking == null || parameters.stocking! <= 0) {
      return const ValidationFailure(
        message: HarvestCalculatorConstants.errorStockingRequired,
      );
    }

    if (parameters.totalFeedPaymentObligation == null ||
        parameters.totalFeedPaymentObligation! <= 0) {
      return const ValidationFailure(
        message:
            HarvestCalculatorConstants.errorTotalFeedPaymentObligationRequired,
      );
    }

    if (parameters.estimatedHarvestYield == null ||
        parameters.estimatedHarvestYield! <= 0) {
      return const ValidationFailure(
        message: HarvestCalculatorConstants.errorEstimatedHarvestYieldRequired,
      );
    }

    return null;
  }
}

/// Failure types for simulation operations
class SimulationFailure extends Failure {
  const SimulationFailure({
    required super.message,
    this.error,
    this.stackTrace,
  });

  final Object? error;
  final StackTrace? stackTrace;

  List<Object?> get props => [message, error, stackTrace];
}
