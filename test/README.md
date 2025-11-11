# Testing Guide

This directory contains **unit tests** for the Flutter Base App project.

## 📁 Directory Structure

```
test/
├── helpers/              # Test utilities and helpers
│   ├── test_helpers.dart      # Common test setup functions
│   └── mock_factories.dart    # Mock objects and test data factories
└── unit/                 # Unit tests
    ├── core/            # Core module tests
    │   └── sync/        # Sync service tests
    └── design_system/   # Design system tests
        └── theme/        # Theme provider tests
```

## 🧪 Running Tests

### Run All Unit Tests

```bash
flutter test
```

### Run Tests with Coverage

```bash
flutter test --coverage
```

### Run Specific Test File

```bash
# SyncQueue tests
flutter test test/unit/core/sync/sync_queue_test.dart

# SyncService tests
flutter test test/unit/core/sync/sync_service_test.dart

# Theme Provider tests
flutter test test/unit/design_system/theme/theme_provider_test.dart
```

### Run Tests in Watch Mode

```bash
flutter test --watch
```

### Run Tests with Verbose Output

```bash
flutter test --verbose
```

## 📊 Test Coverage

### Generate Coverage Report

```bash
flutter test --coverage
```

### View Coverage Report

Coverage data is generated in `coverage/lcov.info`. You can use tools like:

- **VS Code**: Install "Coverage Gutters" extension
- **IntelliJ/Android Studio**: Built-in coverage viewer
- **Online**: Upload to [codecov.io](https://codecov.io) or similar

## 🛠️ Test Helpers

### TestHelpers

Common utilities for test setup:

```dart
import 'package:flutter_base_app/test/helpers/test_helpers.dart';

// Create ProviderContainer with test overrides
final container = TestHelpers.createContainer();

// Create test AppConfig
final config = TestHelpers.createTestConfig(
  apiBaseUrl: 'https://test-api.example.com',
);
```

### Mock Factories

Create test data and mocks:

```dart
import 'package:flutter_base_app/test/helpers/mock_factories.dart';

// Create test SyncItem
final syncItem = createTestSyncItem(
  entityType: 'user',
  entityId: 'user-123',
);

// Create mock Dio
final mockDio = MockDio();

// Create test Response
final response = createTestDioResponse(
  data: {'success': true},
  statusCode: 200,
);
```

## 📝 Writing Unit Tests

### Basic Structure

Test individual functions, classes, or services in isolation:

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MyService', () {
    test('should do something', () {
      // Arrange
      final service = MyService();

      // Act
      final result = service.doSomething();

      // Assert
      expect(result, equals(expectedValue));
    });
  });
}
```

## 🎯 Best Practices

### 1. Test Structure (AAA Pattern)

- **Arrange**: Set up test data and dependencies
- **Act**: Execute the code being tested
- **Assert**: Verify the results

### 2. Test Naming

Use descriptive test names:

```dart
// ✅ Good
test('should return error when network request fails', () {});

// ❌ Bad
test('test1', () {});
```

### 3. Group Related Tests

Use `group()` to organize related tests:

```dart
group('SyncService', () {
  group('addToQueue', () {
    test('should add item to queue', () {});
    test('should throw when queue is full', () {});
  });
});
```

### 4. Use Mocks for Dependencies

Mock external dependencies to isolate tests:

```dart
final mockDio = MockDio();
when(() => mockDio.get('/api/data')).thenAnswer(
  (_) async => createTestDioResponse(),
);
```

### 5. Test Edge Cases

Don't just test happy paths:

```dart
test('should handle null input', () {});
test('should handle empty list', () {});
test('should handle network timeout', () {});
```

### 6. Keep Tests Independent

Each test should be able to run independently:

```dart
setUp(() {
  // Reset state before each test
});

tearDown(() {
  // Clean up after each test
});
```

## 📚 Resources

- [Flutter Testing Documentation](https://docs.flutter.dev/testing)
- [Mocktail Documentation](https://pub.dev/packages/mocktail)
- [Riverpod Testing Guide](https://riverpod.dev/docs/concepts/testing)

## 🚀 Next Steps

- [ ] Add more unit tests for core modules (database, network, connectivity)
- [ ] Setup test coverage reporting in CI/CD
- [ ] Add unit tests for new features as they are developed
