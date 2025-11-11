# Core Module

Core functionality used across the entire application (shared across features).

## Structure

### `config/`

Application configuration that differs per flavor (Dev/Staging/Prod):

- **app_config.dart**: App configuration (API URLs, keys per flavor)
- **flavor_config.dart**: Flavor-specific configurations
- **constants.dart**: App-wide constants

### `connectivity/`

Network connectivity monitoring for offline detection:

- **connectivity_service.dart**: Service to monitor internet connection
- **connectivity_provider.dart**: Riverpod provider for connectivity state
- **connectivity_models.dart**: Models for connectivity status

### `error/`

Error handling layer with `Either<Failure, T>` pattern using `dartz`:

- **failures.dart**: Base Failure class and specific failures
- **error_mapper.dart**: Mapper to convert exceptions to Failures
- **error_handler.dart**: Global error handler

**📖 Best Practices**: See [Either Best Practices](../docs/either_best_practices.md)

### `network/`

Network layer with Dio, including interceptors:

- **dio_client.dart**: Dio client setup with interceptors
- **interceptors/**: Dio interceptors
  - **logging_interceptor.dart**: Request/response logging
  - **error_interceptor.dart**: Error handling interceptor
  - **retry_interceptor.dart**: Retry logic for network failures
  - **auth_interceptor.dart**: Authentication interceptor (placeholder)
- **network_exceptions.dart**: Network-specific exceptions

### `database/`

Local database setup with Drift:

- **app_database.dart**: Main database class with Drift
- **migrations/**: Database migrations
  - **migration_1.dart**: Initial migration
- **database_provider.dart**: Riverpod provider for database

### `logging/`

Logging system with Talker:

- **logger.dart**: Logger setup with Talker
- **logger_provider.dart**: Riverpod provider for logger
- **log_levels.dart**: Log level configuration per flavor

### `sync/`

Offline Sync Mechanism (cross-cutting concern used by all features):

- **services/**: Sync services
  - **sync_service.dart**: Main sync service
  - **sync_queue.dart**: Queue manager for pending operations
  - **sync_executor.dart**: Sync executor with retry logic
- **providers/**: Sync-related providers
  - **sync_status_provider.dart**: Sync status state
  - **sync_queue_provider.dart**: Sync queue state
- **models/**: Sync models
  - **sync_item.dart**: Sync queue item model
  - **sync_status.dart**: Sync status model

**📖 Full details**: See [Offline-First Strategy](../docs/offline_first_strategy.md)

### `utils/`

Utility functions used across the app:

- **extensions/**: Dart extensions
  - **string_extensions.dart**: String utility extensions
  - **datetime_extensions.dart**: DateTime utility extensions
  - **context_extensions.dart**: BuildContext utility extensions
- **validators/**: Input validators
  - **input_validators.dart**: Common input validators
- **helpers/**: Helper functions
  - **date_helper.dart**: Date formatting/parsing helpers
  - **format_helper.dart**: Data formatting helpers

### `di/`

Dependency Injection with Riverpod:

- **providers/**: Core providers
  - **logger_provider.dart**: Logger provider
  - **database_provider.dart**: Database provider
  - **dio_provider.dart**: Dio client provider
  - **connectivity_provider.dart**: Connectivity provider
  - **sync_provider.dart**: Sync service provider
- **provider_overrides.dart**: Provider overrides for testing

## Principles

1. **Shared & Reusable**: All code in `core/` must be usable by multiple features
2. **No Feature-Specific Logic**: Do not place logic specific to one feature
3. **Dependency Injection**: Use Riverpod for all dependencies
4. **Error Handling**: Always use `Either<Failure, T>` pattern with `.fold()`
