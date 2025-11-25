# JAPFA AFMS Mobile App

A production-ready Flutter offline-first mobile application for **Agro Farm Management System (AFMS)** built with **Riverpod**, **Clean Architecture**, and **Material Design 3**. Designed specifically for aquaculture farmers working in remote areas with unstable internet connectivity.

## 🚀 Features

### 🏢 Business Features

- **Harvest Calculator**: Advanced simulation engine for biomass, feed, and revenue calculations
- **Pond Management**: Complete aquaculture pond monitoring and management system
- **Lab Requests**: Laboratory analysis request and result tracking
- **Input Data**: Comprehensive data collection for farm operations
- **Analytics & Graphs**: Real-time data visualization and reporting
- **User Management**: Authentication, profile management, and role-based access

### 🏗️ Technical Features

- **Offline-First Architecture**: 100% functional offline with automatic sync when online
- **Clean Architecture**: Feature-First with Clean Architecture per feature
- **Material Design 3**: Modern UI with Material You design system
- **State Management**: Riverpod with Hooks for reactive state management
- **Dependency Injection**: Riverpod for type-safe DI
- **Routing**: GoRouter for declarative navigation
- **Local Database**: Drift (SQLite) with complex queries and offline sync
- **Network**: Dio with interceptors, retry logic, and connectivity monitoring
- **Sync Mechanism**: Queue-based sync with conflict resolution and background processing
- **Error Handling**: Either pattern with dartz for functional error management
- **Logging**: Talker for comprehensive logging with flavor-based configuration
- **Security**: Flutter Secure Storage for sensitive data (tokens, credentials)
- **Code Generation**: Freezed, Riverpod Generator, Drift, JSON Serializable

## 📁 Project Structure

```
lib/
 ├─ core/                    # Shared core functionality
 │   ├─ config/             # App configuration & environment settings
 │   ├─ connectivity/       # Network connectivity monitoring
 │   ├─ database/           # Local database (Drift + SQLite)
 │   │   ├─ tables/         # Database table definitions
 │   │   └─ database.dart   # Database configuration
 │   ├─ di/                 # Dependency injection (Riverpod providers)
 │   ├─ error/              # Error handling & Either patterns
 │   ├─ logging/            # Logging system (Talker)
 │   ├─ network/            # Network layer (Dio + interceptors)
 │   ├─ sync/               # Offline sync mechanism
 │   └─ utils/              # Shared utilities & helpers
 │
 ├─ features/               # Feature modules (Feature-First Architecture)
 │   ├─ auth/               # Authentication & user management
 │   │   ├─ data/           # Login API, token management
 │   │   ├─ domain/         # Auth business logic & entities
 │   │   └─ presentation/   # Login UI & auth state management
 │   │
 │   ├─ harvest_calculator/ # Harvest simulation engine
 │   │   ├─ data/           # Simulation data & calculations
 │   │   ├─ domain/         # Biomass, feed, revenue calculators
 │   │   └─ presentation/   # Simulation UI & results display
 │   │
 │   ├─ home/               # Dashboard & home screen
 │   ├─ lab_request/        # Laboratory analysis requests
 │   ├─ pond/               # Pond management system
 │   ├─ profile/            # User profile management
 │   ├─ input_data/         # Data collection forms
 │   └─ graph/              # Analytics & data visualization
 │
 ├─ design_system/          # Material Design 3 Design System
 │   ├─ theme/              # Material 3 theme configuration
 │   ├─ components/         # Reusable UI components
 │   └─ layouts/            # Screen layouts & templates
 │
 ├─ router/                 # Navigation & Routing
 │   ├─ app_router.dart     # Main router configuration
 │   ├─ routes.dart         # Route constants & paths
 │   └─ guards/             # Route guards & auth protection
 │
 ├─ main.dart               # Default entry point
 ├─ main_dev.dart           # Development flavor entry point
 ├─ main_staging.dart       # Staging flavor entry point
 └─ main_prod.dart          # Production flavor entry point
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

### Core Framework

- **Flutter**: >=3.35.0
- **Dart**: >=3.9.0

### State Management & Architecture

- **Riverpod**: ^2.4.10 (Reactive state management & dependency injection)
- **Flutter Hooks**: ^0.20.5 (Functional component logic)
- **Riverpod Annotation**: ^2.6.1 (Code generation for Riverpod)

### Navigation & Routing

- **GoRouter**: ^14.0.2 (Declarative routing with deep linking)

### Data & Storage

- **Drift**: ^2.14.0 (Type-safe SQLite ORM)
- **Drift Flutter**: ^0.2.7 (Flutter integration for Drift)
- **SQLite3 Flutter Libs**: ^0.5.21 (SQLite native libraries)

### Networking & Connectivity

- **Dio**: ^5.4.3 (HTTP client with interceptors)
- **Eventsource**: ^0.4.0 (Server-Sent Events for real-time sync)
- **Connectivity Plus**: ^6.0.5 (Network connectivity monitoring)

### Security & Storage

- **Flutter Secure Storage**: ^9.2.2 (Encrypted local storage)

### UI & Design

- **Flutter SVG**: ^1.1.6 (SVG icon support from Figma)
- **Flutter ScreenUtil**: ^5.9.3 (Responsive design utilities)
- **Reactive Forms**: ^18.1.1 (Advanced form management)
- **Flutter ECharts**: ^2.5.0 (Chart and graph visualization)
- **Data Table 2**: ^2.7.1 (Advanced data tables)

### Utilities

- **Freezed**: ^2.4.1 (Immutable data classes)
- **JSON Serializable**: ^4.9.0 (JSON serialization)
- **UUID**: ^4.5.2 (Unique identifier generation)
- **Intl**: ^0.20.2 (Internationalization)
- **Shimmer Animation**: ^2.2.2 (Loading animations)
- **Shared Preferences**: ^2.2.2 (Simple key-value storage)
- **Device Info Plus**: ^10.1.0 (Device information)
- **Package Info Plus**: ^8.0.0 (App package information)

### Development Tools

- **Talker Flutter**: ^4.2.3 (Advanced logging)
- **Drift DB Viewer**: ^2.1.0 (Database inspection)
- **Very Good Analysis**: ^6.0.0 (Code linting)
- **Flutter Flavorizr**: ^2.2.1 (Multi-flavor setup)
- **Flutter Launcher Icons**: ^0.14.4 (App icon generation)
- **Flutter Native Splash**: ^2.4.7 (Splash screen generation)

## 🎯 Business Context

**JAPFA AFMS (Agro Farm Management System)** is a comprehensive mobile application designed for aquaculture farmers and farm managers. The app addresses critical challenges faced by farmers working in remote locations with limited or unstable internet connectivity.

### Key Business Problems Solved

1. **Offline Harvest Planning**: Farmers can create detailed harvest simulations offline, calculating biomass, feed requirements, and revenue projections without internet access.

2. **Real-time Pond Monitoring**: Track pond conditions, water quality parameters, and operational metrics with offline data collection and automatic sync.

3. **Laboratory Coordination**: Streamlined lab analysis requests and result tracking for quality control and compliance.

4. **Data-Driven Decision Making**: Comprehensive analytics and visualization tools for farm performance optimization.

### Target Users

- **Farm Managers**: Oversee multiple ponds and make strategic decisions
- **Farm Operators**: Daily pond operations and data collection
- **Quality Control Staff**: Lab coordination and analysis tracking
- **Field Technicians**: Remote monitoring and troubleshooting

### Core Value Proposition

- **100% Offline Functionality**: Full feature set works without internet
- **Automatic Sync**: Seamless data synchronization when connectivity is available
- **Complex Calculations**: Advanced harvest simulation engine for optimal yield planning
- **Real-time Analytics**: Data-driven insights for farm optimization
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
cd app-mobile-afms
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

## 🤝 Contributing

### Code Quality Standards

- **SOLID Principles**: Ensure all code follows SOLID design principles
- **Clean Architecture**: Maintain separation between Data, Domain, and Presentation layers
- **Offline-First Mindset**: All features must work 100% offline
- **Either Pattern**: Always use `.fold()` for Either<Failure, T> error handling
- **Type Safety**: Leverage Dart's type system and code generation tools

### Commit Standards

- Use conventional commit format
- Reference issue numbers in commit messages
- Include documentation updates in the same PR as code changes

## 📄 License

[Your License Here]
