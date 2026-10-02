# Dekho UI Screens

This document outlines all major screens in the Dekho application, their purpose, key components, and various states.

## 1. Splash Screen (`/`)
- **Purpose:** Initial branding display while the app initializes and checks auth/session state.
- **Key Components:** Dekho Logo, subtle animated background.
- **Transitions:** Automatically routes to `/home` after initialization.

## 2. Home Screen (`/home`)
- **Purpose:** Main discovery hub. Highlights trending products, top categories, and daily deals.
- **Key Components:**
  - `DekhoSearchBar` (read-only, tapping navigates to Search)
  - Horizontal list of `CategoryChip`s
  - "Trending Deals" section (horizontal scroll of `ProductCard`)
  - "Recommended for You" section
- **States:** Shimmer loading initially, populated lists when data arrives.

## 3. Search Screen (`/search`)
- **Purpose:** Active search input and suggestions.
- **Key Components:**
  - Active `DekhoSearchBar` with autofocus.
  - Recent Searches list (clearable).
  - Trending Searches list.
  - Auto-suggestions dropdown as user types.
- **Interactions:** Submitting search navigates to `/search/results`.

## 4. Search Results Screen (`/search/results?q=...`)
- **Purpose:** Display products matching the search query.
- **Key Components:**
  - `DekhoSearchBar` (pre-filled with query).
  - Filter & Sort buttons row.
  - Grid or List view of `ProductCard` or `ProductCardLarge`.
  - `FilterBottomSheet` and `SortBottomSheet` triggered by actions.
- **States:**
  - **Loading:** Grid of `ShimmerLoading.productCard()`.
  - **Empty:** `EmptyState` ("No products found for 'xyz'").
  - **Error:** `ErrorState` with retry button.

## 5. Product Detail Screen (`/product/:id`)
- **Purpose:** Comprehensive view of a single product, including all retailer prices.
- **Key Components:**
  - Image carousel/gallery.
  - Product Title, Brand, and `RatingBar`.
  - Main `PriceText` (Best Price) and `DiscountBadge`.
  - Action buttons: Share, `WishlistButton`.
  - "Compare Prices" section: List of `RetailerOfferCard`s sorted by price.
  - Specifications section.
  - Similar Products row.
- **Interactions:** Tapping a `RetailerOfferCard` "Buy Now" triggers the affiliate flow.

## 6. Compare Screen (`/compare`)
- **Purpose:** Side-by-side spec comparison of 2-3 products.
- **Key Components:**
  - Horizontal sticky header with product images and titles.
  - Vertical list of specification rows (Screen, Processor, Battery, etc.).
  - Highlights differences in specs.

## 7. Wishlist Screen (`/wishlist`)
- **Purpose:** Manage saved items and monitor price drops.
- **Key Components:**
  - List of `ProductCardLarge` representing `WishlistItem`s.
  - Indicator showing price increase/decrease since added.
- **States:**
  - **Empty:** `EmptyState` ("Your wishlist is empty").

## 8. Explore / Categories Screen (`/explore`)
- **Purpose:** Browse the full catalog hierarchy.
- **Key Components:**
  - Grid of all root categories.
  - Expandable sub-categories.

## 9. Profile & Settings Screen (`/profile`)
- **Purpose:** User account, preferences, and app information.
- **Key Components:**
  - Login/Signup CTA (if guest).
  - Price Alert settings.
  - Theme toggle (future).
  - Help & Support.

## 10. Recently Viewed Screen (`/recently-viewed`)
- **Purpose:** Quick access to browsing history.
- **Key Components:**
  - Chronological list of previously viewed products.
  - Clear history button.
