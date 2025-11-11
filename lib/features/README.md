# Features Module

Feature modules use **Feature-First Architecture** with **Clean Architecture** per feature.

## Feature-First Architecture Principles

Each feature is an independent module that has:

- Its own Clean Architecture structure (data, domain, presentation)
- Its own dependencies (does not depend on other features)
- Can be developed and tested separately

## Feature Structure

Each feature follows Clean Architecture structure:

```
feature_name/
 ├─ data/                    # Data Layer (implementation)
 │   ├─ datasources/         # Data sources
 │   │   ├─ remote/          # Remote data sources (API calls)
 │   │   └─ local/           # Local data sources (Drift database)
 │   ├─ models/              # Data models (Freezed)
 │   │   └─ mappers/          # Model ↔ Entity mappers
 │   └─ repositories/        # Repository implementations
 │
 ├─ domain/                  # Domain Layer (business logic)
 │   ├─ entities/            # Domain entities (pure business objects)
 │   ├─ repositories/        # Repository interfaces (contracts)
 │   └─ usecases/            # Use cases (business logic)
 │
 └─ presentation/            # Presentation Layer (UI)
     ├─ providers/           # Riverpod providers for feature
     ├─ screens/             # Feature screens (using Material 3 layouts)
     ├─ widgets/             # Feature-specific widgets (using Material 3 components)
     └─ controllers/         # Feature controllers (optional)
```

## Data Layer

**Purpose**: Handle data operations (API calls, database operations)

- **datasources/remote/**: API calls using Dio client from `core/network/`
- **datasources/local/**: Database operations using Drift from `core/database/`
- **models/**: Freezed models with JSON serialization
- **mappers/**: Convert models to entities (data → domain)
- **repositories/**: Implement repository interfaces from domain layer

**Best Practices**:

- Always return `Either<Failure, T>` from repository methods
- Use `.fold()` to handle Either (see [Either Best Practices](../../docs/either_best_practices.md))
- Handle offline: save to local first, queue sync operation

## Domain Layer

**Purpose**: Pure business logic without framework dependencies

- **entities/**: Pure Dart classes (no Freezed, no JSON) - business objects
- **repositories/**: Abstract classes/interfaces (contracts)
- **usecases/**: Business logic that uses repositories

**Best Practices**:

- Entities must be pure Dart (no framework dependencies)
- Repository interfaces only define contracts
- Use cases contain business logic

## Presentation Layer

**Purpose**: UI and state management using Material Design 3

### Structure

- **providers/**: Riverpod providers for feature state
- **screens/**: Feature screens using Material 3 layouts
- **widgets/**: Feature-specific widgets using Material 3 components
- **controllers/**: Optional controllers for complex state management

### Using Material Design 3

#### Screens

Use Material 3 layouts from `design_system/layouts/`:

```dart
// ✅ GOOD: Use Material 3 layout
import 'package:flutter_base_app/design_system/layouts/base_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Home',
      body: ListView(...),
    );
  }
}
```

Or use Material 3 Scaffold directly:

```dart
// ✅ GOOD: Use Material 3 Scaffold
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: ListView(...),
    );
  }
}
```

#### Widgets

Use Material 3 components from `design_system/components/` or built-in Material 3:

```dart
// ✅ GOOD: Use Material 3 built-in components
ElevatedButton(
  onPressed: () {},
  child: Text('Submit'),
)

TextField(
  decoration: InputDecoration(labelText: 'Email'),
)

Card(
  child: ListTile(
    title: Text('Title'),
    subtitle: Text('Subtitle'),
  ),
)
```

```dart
// ✅ GOOD: Use custom components extending Material 3
import 'package:flutter_base_app/design_system/components/buttons/app_button.dart';

AppButton.primary(
  onPressed: () {},
  child: Text('Submit'),
)
```

### Best Practices

1. **Use Material 3 First**: Always check if Material 3 provides what you need
2. **Use Design System**: Use components from `design_system/` for consistency
3. **Feature-Specific Widgets**: Create widgets in `widgets/` only for feature-specific needs
4. **Reuse Layouts**: Use layouts from `design_system/layouts/` for common screen patterns
5. **State Management**: Use Riverpod providers for state management
6. **Error Handling**: Handle errors with `.fold()` on Either results

### Example: Feature Screen Structure

```dart
// features/user_profile/presentation/screens/user_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_base_app/design_system/layouts/base_screen.dart';
import 'package:flutter_base_app/design_system/components/cards/app_card.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Profile',
      body: ListView(
        children: [
          AppCard(
            child: Column(
              children: [
                // Use Material 3 components
                Text('User Name', style: Theme.of(context).textTheme.titleLarge),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Edit'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

## Example Feature

See `example_feature/` for a complete feature structure template.

## Adding a New Feature

1. Copy structure from `example_feature/` to `features/your_feature/`
2. Rename all files and classes according to feature name
3. Implement according to feature requirements
4. Use Material 3 components and layouts from `design_system/`
5. Register routes in `router/app_router.dart`

## Design System Integration

### Material 3 Components

- **Built-in**: Use Material 3 components directly (ElevatedButton, TextField, Card, etc.)
- **Custom**: Use custom components from `design_system/components/` when needed

### Layouts

- Use layouts from `design_system/layouts/` for common screen patterns
- Or use Material 3 Scaffold directly for custom layouts

### Theme

- Access Material 3 theme via `Theme.of(context)`
- Use Material 3 color scheme: `Theme.of(context).colorScheme`
- Use Material 3 typography: `Theme.of(context).textTheme`
