# Dekho Technical Decisions Log

This document records major architectural and technical choices made during the development of Dekho, providing context on *why* these decisions were made.

## 1. State Management: Riverpod
**Decision:** Use `flutter_riverpod` instead of Provider, Bloc, or GetX.
**Rationale:**
- **Compile-safe:** Catches ProviderNotFoundExceptions at compile time.
- **Lightweight vs Bloc:** Less boilerplate for simple state changes while remaining scalable.
- **Built-in DI:** Riverpod acts as a powerful Dependency Injection framework, allowing us to easily swap Mock Repositories for API Repositories.
- **Async Handling:** `FutureProvider` dramatically simplifies loading/error/data states for network requests.

## 2. Navigation: GoRouter
**Decision:** Use `go_router` for app routing.
**Rationale:**
- **Declarative:** URL-based routing is essential for future deep-linking (e.g., sharing a product link `dekho.app/product/123`).
- **Flutter Favorite:** Officially recommended by the Flutter team.
- **Bottom Navigation:** Excellent support for stateful nested navigation (`StatefulShellRoute`), maintaining state when switching tabs.

## 3. Typography: Plus Jakarta Sans
**Decision:** Use Plus Jakarta Sans via the `google_fonts` package.
**Rationale:**
- **Modern & Premium:** Geometric sans-serif that looks highly professional and trustworthy.
- **Legibility:** Excellent legibility at small sizes (crucial for dense spec lists and metadata).
- **Tabular Figures:** Strong support for tabular numbers, which is critical for a price comparison app aligning numbers vertically.

## 4. Brand Color: Electric Indigo (`#6366F1`)
**Decision:** Select a primary purple/indigo hue over blue, red, or green.
**Rationale:**
- **Distinctive:** Stands out from competitor retailer apps (Amazon is Orange/Black, Flipkart is Blue).
- **Psychology:** Purple/Indigo conveys premium quality, trust, and intelligence (smart shopping).

## 5. Clean Architecture
**Decision:** Separate code into Domain, Data, and Presentation layers.
**Rationale:**
- **Testability:** Business logic (Domain) can be unit-tested without Flutter dependencies.
- **Parallel Development:** UI team can build screens using Domain interfaces while the Backend team builds the API.
- **Maintainability:** Clear boundaries prevent "spaghetti code" where UI logic mixes with data fetching.

## 6. Mock Data Layer Strategy
**Decision:** Build a highly realistic, hardcoded mock data layer with simulated network delays for Phase 1.
**Rationale:**
- Allows perfect validation of the UI and UX flows before committing to backend schemas.
- Simulated delays ensure the UI gracefully handles loading states (Shimmer effects), preventing jarring transitions when real network requests are implemented later.
