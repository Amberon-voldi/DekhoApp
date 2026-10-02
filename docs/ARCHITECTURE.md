# Dekho Architecture

The Dekho Flutter app follows a robust **Clean Architecture** combined with **Riverpod** for state management and **GoRouter** for declarative navigation. This ensures scalability, testability, and a clear separation of concerns.

## Architectural Layers

### 1. Domain Layer (`lib/domain/`)
The innermost layer. It contains the core business rules and logic. It is completely independent of the UI, state management, or data fetching implementations.
- **Models:** Pure Dart classes representing business entities (`Product`, `Retailer`, `Category`, `RetailerOffer`, `SearchResult`, `WishlistItem`).
- **Repositories (Contracts):** Abstract classes defining the interface for data access (`ProductRepository`, `SearchRepository`, `WishlistRepository`).

### 2. Data Layer (`lib/data/`)
The layer responsible for implementing the repository contracts and managing data sources.
- **Mock Implementations:** Currently, the app relies entirely on mock data sources (`MockProductRepository`, etc.) to facilitate UI development without a backend. These simulate network delays to ensure the UI handles loading states gracefully.
- **Future Data Sources:** Will include API clients (e.g., using `http` or `dio`), local databases (e.g., Hive or SQLite for caching), and analytics services.

### 3. Presentation Layer (`lib/presentation/`)
The UI layer responsible for rendering data and capturing user input.
- **Screens:** Full-page widgets corresponding to distinct routes (e.g., `HomeScreen`, `ProductDetailScreen`). Organized in separate folders if they have specific local widgets.
- **Widgets:** Reusable UI components conforming to the Design System (`ProductCard`, `PriceText`, `RatingBar`).
- **State Holders (Notifiers):** Riverpod `Notifier` or `StateNotifier` classes that manage the state of the UI and interact with the Domain layer.

## State Management: Riverpod
We use `flutter_riverpod` for dependency injection and state management.
- **Providers (`lib/core/providers/`):** Define how state is created, updated, and accessed.
- **Repository Providers:** Provide concrete implementations of repositories (currently mocks).
- **FutureProviders:** Used for asynchronous data fetching (e.g., `trendingProductsProvider`). Automatically handle loading/error/data states.
- **StateProviders/StateNotifierProviders:** Used for mutable state (e.g., `searchQueryProvider`, `wishlistItemsProvider`).
- **Consumers:** UI widgets extend `ConsumerWidget` or `ConsumerStatefulWidget` to reactively rebuild when provider state changes.

## Navigation: GoRouter
We use `go_router` for declarative routing.
- **Configuration (`lib/core/routing/app_router.dart`):** Defines the route tree, paths, and builders.
- **Deep Linking:** Native support for parsing URLs like `/product/123`.
- **Bottom Navigation:** Utilizes `StatefulShellRoute` to maintain the state of tabs in the `BottomNavShell` (Home, Explore, Wishlist, Profile).

## Future Backend Integration Plan (Phase 2)
When transitioning from Mock Data to a real backend:
1. **New Data Source:** Create `ApiProductRepository` implementing `ProductRepository`.
2. **Provider Update:** Simply update `productRepositoryProvider` in `lib/core/providers/repository_providers.dart` to return the new `ApiProductRepository` instead of the mock.
3. **No UI Changes:** Because the Presentation layer depends entirely on the Domain layer abstractions (via Riverpod), the UI code will remain completely untouched.

This architecture guarantees that our frontend is decoupled from the backend implementation, allowing parallel development.
