# Router Module

Navigation & Routing using `go_router` for declarative routing and deep linking.

## Structure

### `app_router.dart`
Main router configuration with go_router:
- Setup routes for all features
- Configure navigation guards
- Handle deep linking

### `routes.dart`
Route constants and path definitions:
- Route path constants
- Route name constants
- Route parameter definitions

### `guards/`
Route guards for protection:
- **auth_guard.dart**: Authentication guard (placeholder)
- Other guards as needed

### `navigation/`
Navigation helpers:
- **navigation_service.dart**: Helper functions for navigation

## Best Practices

1. **Declarative Routes**: Define all routes in one place
2. **Type-Safe Navigation**: Use constants for route paths
3. **Guards**: Use guards for authentication/authorization
4. **Deep Linking**: Support deep linking for better UX

## Usage

```dart
// Navigate using router
context.go(Routes.home);
context.push(Routes.details(id: '123'));

// Using navigation service
NavigationService.goToHome();
NavigationService.goToDetails(id: '123');
```
