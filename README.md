# Dekho

Dekho is a Flutter shopping comparison app that helps users find products,
compare prices across multiple retailers, and choose the best available deal.
The app is designed for a fast, focused product-discovery experience with
search, filtering, price history, wishlists, coupons, and retailer links.

## Features

- Browse products by category and explore featured deals
- Search products with sorting and filtering
- Compare offers from Amazon, Flipkart, Croma, and Reliance Digital
- View product details, ratings, specifications, discounts, and price history
- Save products to a wishlist
- Track recently viewed products
- Discover and browse coupons
- Support light and dark themes
- Open the selected retailer listing directly from an offer

## Tech stack

- **Flutter** and **Dart**
- **Riverpod** for application state management
- **GoRouter** for navigation
- **Google Fonts**, **Lucide Icons**, and **Flutter Staggered Grid View**
- Repository-based domain/data structure ready for API integration

## Project structure

```text
lib/
├── core/          # Theme, routing, providers, and shared utilities
├── data/          # Mock data, network services, and repository implementations
├── domain/        # Product models and repository contracts
├── presentation/  # Screens and reusable UI widgets
└── main.dart      # Application entry point
```

## Getting started

### Prerequisites

- Flutter SDK with Dart 3.9.2 or later
- Android Studio or Xcode, depending on the target platform

### Run locally

```bash
flutter pub get
flutter run
```

### Analyze and test

```bash
flutter analyze
flutter test
```

## Current status

Dekho is currently a functional UI prototype. Product, search, wishlist, and
coupon flows use local mock repositories, while the data and repository layers
are structured so live product and retailer APIs can be connected later.
