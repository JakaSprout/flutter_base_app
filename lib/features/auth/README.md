# Auth Feature Documentation

## Architecture Overview

Feature auth mengikuti **Clean Architecture** dengan pemisahan layer yang jelas:

- **Domain Layer**: Entities, Use Cases, Repository Interfaces, Services
- **Data Layer**: Repository Implementations, Data Sources, Models
- **Presentation Layer**: Screens, Widgets, Providers, Hooks

## Naming Conventions

### Providers

#### Use Case Providers
Use case providers menggunakan pattern: `*Provider` atau `*UseCaseProvider`

```dart
@Riverpod(keepAlive: true)
LoginWithPhone loginWithPhone(LoginWithPhoneRef ref) { ... }
// Generated: loginWithPhoneProvider

@Riverpod(keepAlive: true)
Logout logoutUseCase(LogoutUseCaseRef ref) { ... }
// Generated: logoutUseCaseProvider
```

#### Action Providers
Action providers (yang memanggil use cases) menggunakan pattern: `*Provider`

```dart
@riverpod
Future<LoginResponse> phoneLogin(PhoneLoginRef ref, PhoneLoginRequest request) { ... }
// Generated: phoneLoginProvider

@riverpod
Future<void> logout(LogoutRef ref) { ... }
// Generated: logoutProvider
```

### Use Cases

Use cases menggunakan pattern: `*UseCase` atau langsung nama action

```dart
class LoginWithPhone { ... }
class LoginWithEmail { ... }
class Logout { ... }
class RefreshToken { ... }
```

### Services

Services menggunakan pattern: `*Service`

```dart
class AuthService { ... }
```

### Hooks

Custom hooks menggunakan pattern: `use*`

```dart
FormGroup useLoginForm() { ... }
void useLoginFormValidation(...) { ... }
({ValueNotifier<bool> isLoading, Future<void> Function() handleLogin}) useLogin(...) { ... }
```

## Helper Functions & Extensions

### Either Extensions

File: `lib/core/utils/either_extensions.dart`

Extension methods untuk `Either<Failure, T>`:
- `toFuture()`: Convert Either ke Future
- `toValue()`: Convert Either ke value secara synchronous

**Usage:**
```dart
final result = await loginWithPhone(request);
return result.toFuture(); // Instead of: result.fold((f) => throw f, (d) => d)
```

## Constants

### Auth Constants

File: `lib/features/auth/presentation/constants/auth_constants.dart`

Berisi semua constants untuk auth feature:
- UI strings (titles, hints, error messages)
- Validation constants
- **Timing constants** (new):
  - `tokenExpirationThreshold`: Duration(minutes: 5)
  - `providerInvalidationDelay`: Duration(milliseconds: 100)
  - `sessionTimeoutRetryDelay`: Duration(minutes: 1)
  - `defaultSessionCheckInterval`: Duration(minutes: 5)

## Service Methods

### AuthService

#### Token Management
- `saveTokens(LoginResponse)`: Save tokens after login
- `clearTokens()`: Clear all tokens
- `clearTokensAndVerify()`: Clear tokens and verify they are cleared (new)

#### Token Retrieval
- `getAccessToken()`: Get current access token
- `getRefreshToken()`: Get current refresh token
- `getTokenExpiration()`: Get token expiration DateTime

#### Token Validation
- `isAuthenticated()`: Check if user is authenticated
- `validateSession()`: Validate current session
- `isTokenExpired()`: Check if token is expired
- `willTokenExpireSoon({Duration? threshold})`: Check if token will expire soon

**Note:** `willTokenExpireSoon()` sekarang menggunakan `AuthConstants.tokenExpirationThreshold` sebagai default.

## Best Practices

### 1. Error Handling

Gunakan `EitherExtensions` untuk convert Either ke Future:

```dart
// ✅ Good
final result = await useCase(request);
return result.toFuture();

// ❌ Avoid
return result.fold<Future<T>>((f) => throw f, (d) => d);
```

### 2. Constants

Jangan hardcode magic values, gunakan constants:

```dart
// ✅ Good
await Future.delayed(AuthConstants.providerInvalidationDelay);

// ❌ Avoid
await Future.delayed(const Duration(milliseconds: 100));
```

### 3. Service Methods

Gunakan service methods yang sudah tersedia:

```dart
// ✅ Good
await authService.clearTokensAndVerify();

// ❌ Avoid (duplicate verification logic)
await authService.clearTokens();
final token = await authService.getAccessToken();
if (token != null) { ... }
```

### 4. Form Validation

Gunakan custom hooks untuk form management:

```dart
// ✅ Good
final form = useLoginForm();
useLoginFormValidation(form: form, isPhoneMode: isPhoneMode.value);

// ❌ Avoid (manual form setup in widget)
final form = useMemoized(() => FormGroup({...}), []);
```

## Testing

### Unit Tests

Test files should be located in `test/unit/features/auth/`:
- Use cases
- Services
- Repositories
- Data sources

### Widget Tests

Test files should be located in `test/widget/features/auth/`:
- Screens
- Widgets
- Hooks (if testable)

## Future Improvements

### Priority 2 (Considered)
- [ ] Use case consolidation (if needed)
- [ ] SecureStorage interface implementation (if multiple implementations needed)

### Priority 3 (Nice to Have)
- [ ] Comprehensive unit tests
- [ ] Integration tests
- [ ] E2E tests for auth flow

## Related Files

- `AUTH_FEATURE_ARCHITECTURE_REVIEW.md`: Detailed architecture review
- `LOGIN_SCREEN_BEST_PRACTICES_REVIEW.md`: Login screen best practices review

