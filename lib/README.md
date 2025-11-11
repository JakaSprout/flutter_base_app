# Project Structure

The project structure uses **Feature-First Architecture** with **Clean Architecture** per feature, and **Material Design 3** for the design system.

## 📁 Folder Structure

```
lib/
 ├─ core/                    # Core functionality (shared)
 ├─ features/                # Feature modules (Feature-First)
 ├─ design_system/          # Design System (Material Design 3)
 │   ├─ theme/              # Material 3 theme configuration
 │   ├─ components/         # Custom components extending Material 3
 │   └─ layouts/            # Page layouts and screen templates
 ├─ router/                  # Navigation & Routing
 ├─ main.dart                # Default entry point (dev) + common initialization
 ├─ main_dev.dart            # Dev flavor entry point
 ├─ main_staging.dart        # Staging flavor entry point
 └─ main_prod.dart          # Prod flavor entry point
```

## 📚 Documentation

### Core Module
See [core/README.md](core/README.md) for complete documentation about core functionality.

**Purpose**: Shared functionality used across the entire application:
- Configuration management
- Network connectivity monitoring
- Error handling
- Network layer (Dio)
- Local database (Drift)
- Logging system
- Offline sync mechanism
- Utilities (extensions, validators, helpers)
- Dependency Injection (Riverpod)

### Features Module
See [features/README.md](features/README.md) for complete documentation about Feature-First Architecture.

**Purpose**: Feature modules with Clean Architecture per feature:
- Each feature has its own complete structure (data, domain, presentation)
- Features are independent and can be developed separately
- Follows Clean Architecture principles

### Design System Module
See [design_system/README.md](design_system/README.md) for complete documentation about Material Design 3.

**Purpose**: Design System using Material Design 3:
- **Material 3 Foundation**: Built-in Material 3 components and theme
- **Custom Components**: Components extending Material 3 for specific needs
- **Layouts**: Page layouts and screen templates
- **Fast Development**: Leverage Material 3 for rapid component development

### Router Module
See [router/README.md](router/README.md) for complete documentation about routing.

**Purpose**: Navigation & Routing using `go_router`:
- Declarative routing
- Deep linking support
- Route guards
- Type-safe navigation

## 🏗️ Architecture Principles

### Feature-First Architecture
- Each feature is an independent module
- Features do not depend on other features
- Clean Architecture per feature (data, domain, presentation)

### Clean Architecture
- **Data Layer**: Handle data operations (API, database)
- **Domain Layer**: Pure business logic (entities, repositories, use cases)
- **Presentation Layer**: UI and state management (providers, screens, widgets)

### Material Design 3
- Use Material 3 as foundation for faster development
- Extend Material 3 components when needed
- Follow Material Design guidelines for consistency

## 📖 Best Practices

1. **Error Handling**: Always use `Either<Failure, T>` with `.fold()`
   - See [Either Best Practices](../../docs/either_best_practices.md)

2. **SOLID Principles**: Follow SOLID principles
   - See [Coding Principles](../../docs/coding_principles.md)

3. **Offline-First**: Implement offline-first strategy
   - See [Offline-First Strategy](../../docs/offline_first_strategy.md)

4. **Security**: Follow security best practices
   - See [Security Best Practices](../../docs/security_best_practices.md)

5. **Performance**: Optimize for performance
   - See [Performance Optimization](../../docs/performance_optimization.md)

## 🚀 Getting Started

1. **Setup Flavor**: Select flavor (dev/staging/prod) in VS Code launch configuration
2. **Run App**: Use launch configuration in `.vscode/launch.json`
3. **Add Feature**: Copy structure from `features/example_feature/` for new feature
4. **Use Design System**: Use Material 3 components and custom components from `design_system/` for UI
   - See [Feature Structure Guide](../../docs/FEATURE_STRUCTURE_GUIDE.md) for detailed guide
5. **Register Routes**: Add new routes in `router/app_router.dart`

## 📝 Removed Template Files

The following files have been removed as they were templates from Flutter:
- `lib/pages/my_home_page.dart` (template from flutter_flavorizr)

The `lib/app.dart` file has been updated to use `go_router` and no longer uses template pages.
