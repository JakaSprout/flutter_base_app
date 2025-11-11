# Flutter Base App

A production-ready Flutter offline-first application template with **Riverpod**, **Clean Architecture**, and **Material Design 3**.

## 🚀 Features

- **Offline-First Architecture**: Local-first with sync mechanism
- **Clean Architecture**: Feature-First with Clean Architecture per feature
- **Material Design 3**: Modern UI with Material You design system
- **State Management**: Riverpod with code generation
- **Dependency Injection**: Riverpod for DI
- **Routing**: GoRouter for declarative navigation
- **Local Database**: Drift (SQLite) for offline storage
- **Network**: Dio with interceptors and retry logic
- **Sync Mechanism**: Batch sync + SSE (Server-Sent Events) for real-time updates
- **Error Handling**: Either pattern with dartz
- **Logging**: Talker for comprehensive logging
- **Security**: Flutter Secure Storage for sensitive data
- **Code Generation**: Freezed, Riverpod Generator, Drift, JSON Serializable

## 📁 Project Structure

```
lib/
 ├─ core/                    # Core functionality (shared)
 │   ├─ config/             # App configuration
 │   ├─ connectivity/       # Network connectivity monitoring
 │   ├─ database/           # Local database (Drift)
 │   ├─ di/                 # Dependency injection (Riverpod)
 │   ├─ error/              # Error handling
 │   ├─ logging/            # Logging system
 │   ├─ network/            # Network layer (Dio)
 │   ├─ sync/               # Offline sync mechanism
 │   └─ utils/              # Utilities
 │
 ├─ features/               # Feature modules (Feature-First)
 │   └─ example_feature/    # Example feature template
 │       ├─ data/           # Data layer
 │       ├─ domain/         # Domain layer
 │       └─ presentation/   # Presentation layer
 │
 ├─ design_system/          # Design System (Material Design 3)
 │   ├─ theme/              # Material 3 theme configuration
 │   ├─ components/          # Custom components extending Material 3
 │   └─ layouts/            # Page layouts and screen templates
 │
 ├─ router/                 # Navigation & Routing
 │   ├─ app_router.dart     # Main router configuration
 │   ├─ routes.dart         # Route constants
 │   └─ guards/             # Route guards
 │
 ├─ main.dart               # Default entry point (dev)
 ├─ main_dev.dart           # Dev flavor entry point
 ├─ main_staging.dart       # Staging flavor entry point
 └─ main_prod.dart          # Prod flavor entry point
```

## 🏗️ Architecture

### Feature-First Architecture

Each feature is an independent module with:
- **Data Layer**: API calls, database operations, models
- **Domain Layer**: Business logic, entities, use cases
- **Presentation Layer**: UI, state management, screens

### Clean Architecture

- **Separation of Concerns**: Clear boundaries between layers
- **Dependency Rule**: Dependencies point inward (presentation → domain → data)
- **Testability**: Each layer can be tested independently

### Material Design 3

- **Built-in Components**: Use Material 3 components directly
- **Custom Components**: Extend Material 3 when needed
- **Theme System**: Material 3 color scheme and typography
- **Fast Development**: Less custom code, faster time to market

## 🛠️ Tech Stack

- **Flutter**: >=3.35.0
- **Dart**: >=3.9.0
- **Riverpod**: 2.4.10 (State Management & DI)
- **GoRouter**: 14.0.2 (Routing)
- **Drift**: 2.14.0 (Local Database)
- **Dio**: 5.4.3 (HTTP Client)
- **Material Design 3**: Built-in Flutter Material 3

## 📦 Getting Started

### Prerequisites

- Flutter SDK >=3.35.0
- Dart SDK >=3.9.0
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the repository**

```bash
git clone <repository-url>
cd flutter_base_app
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Generate code**

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. **Run the app**

```bash
# Dev flavor
flutter run --flavor dev -t lib/main_dev.dart

# Staging flavor
flutter run --flavor staging -t lib/main_staging.dart

# Prod flavor
flutter run --flavor prod -t lib/main_prod.dart
```

## 📚 Documentation

Comprehensive documentation is available in the `docs/` directory:

- [Project Structure](docs/PROJECT_STRUCTURE.md) - Detailed project structure
- [Feature Structure Guide](docs/FEATURE_STRUCTURE_GUIDE.md) - How to structure features
- [Material Design 3 Setup](docs/MATERIAL_DESIGN_3_SETUP.md) - Material 3 configuration
- [Offline-First Strategy](docs/offline_first_strategy.md) - Sync mechanism
- [Riverpod Best Practices](docs/riverpod_best_practices.md) - State management guide
- [Coding Principles](docs/coding_principles.md) - Code quality guidelines
- [Security Best Practices](docs/security_best_practices.md) - Security guidelines

## 🎯 Key Features

### Offline-First

- Local database with Drift
- Queue-based sync mechanism
- Batch sync with SSE for real-time updates
- Automatic retry on failure

### State Management

- Riverpod with code generation
- Type-safe providers
- Automatic dependency injection
- Easy testing with provider overrides

### Material Design 3

- Material You design system
- Dynamic color theming
- Built-in accessibility
- Platform adaptation

### Error Handling

- Either pattern with dartz
- Type-safe error handling
- Comprehensive error mapping
- Global error handler

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage
```

## 📝 Code Generation

```bash
# Generate code (one-time)
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (development)
flutter pub run build_runner watch --delete-conflicting-outputs
```

## 🚀 Building

```bash
# Android
flutter build apk --flavor prod -t lib/main_prod.dart

# iOS
flutter build ios --flavor prod -t lib/main_prod.dart
```

## 📖 Contributing

1. Follow the [Coding Principles](docs/coding_principles.md)
2. Use [Feature-First Architecture](lib/features/README.md)
3. Follow [Material Design 3 Guidelines](docs/MATERIAL_DESIGN_3_SETUP.md)
4. Write tests for new features
5. Update documentation

## 📄 License

[Your License Here]

## 🙏 Acknowledgments

- Flutter Team
- Riverpod Team
- Material Design Team
- All open-source contributors

---

**Built with ❤️ using Flutter**
