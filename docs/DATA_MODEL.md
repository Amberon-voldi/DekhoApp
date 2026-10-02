# Dekho Data Models

This document outlines the core business models defined in the Domain layer (`lib/domain/models/`). These models represent the essential data structures of the Dekho application.

## 1. Product (`product.dart`)
Represents an item available for comparison.
```dart
class Product {
  final String id;
  final String name; // e.g., "iPhone 15 Pro"
  final String brand; // e.g., "Apple"
  final String variant; // e.g., "256GB, Natural Titanium"
  final String description;
  final List<String> images; // URLs or placeholder asset strings
  final String categoryId;
  final double rating; // 0.0 to 5.0
  final int reviewCount;
  final Map<String, String> specifications; // e.g., {"RAM": "8GB", "Processor": "A17 Pro"}
  final List<RetailerOffer> offers; // All available prices
}
```
**Computed Properties:**
- `bestPrice`: The absolute lowest price among all offers.
- `highestPrice`: The highest price among offers.
- `bestOffer`: The `RetailerOffer` object with the lowest price.
- `discountPercentage`: Computed from `bestOffer.originalPrice` vs `bestOffer.price`.

## 2. Retailer (`retailer.dart`)
An Enum representing supported e-commerce platforms. Includes UI helpers.
```dart
enum Retailer {
  amazon, flipkart, croma, myntra, reliance, tataCliq;
  
  String get displayName; // e.g., 'Amazon'
  Color get brandColor; // Associated brand color from AppColors
}
```

## 3. RetailerOffer (`retailer_offer.dart`)
A specific price offering from a retailer for a product.
```dart
class RetailerOffer {
  final Retailer retailer;
  final double price; // Current selling price
  final double? originalPrice; // MRP, if available
  final String deliveryInfo; // e.g., "Free delivery by Tomorrow"
  final bool inStock;
  final double? sellerRating;
  final String url; // Target URL for affiliate redirect
}
```

## 4. Category (`category.dart`)
Product classification for browsing.
```dart
class Category {
  final String id;
  final String name; // e.g., "Mobiles", "Laptops"
  final IconData icon; // LucideIcon reference
  final int productCount; // Number of items in this category
}
```

## 5. WishlistItem (`wishlist_item.dart`)
Represents a saved product for tracking.
```dart
class WishlistItem {
  final Product product;
  final DateTime addedAt;
  final double? previousBestPrice; // The price when it was added
}
```
**Computed Properties:**
- `priceChange`: Difference between current `product.bestPrice` and `previousBestPrice`. Used to show "Dropped by ₹500" badges.

## 6. SearchResult (`search_result.dart`)
Encapsulates a search response.
```dart
class SearchResult {
  final String query;
  final List<Product> products;
  final int totalCount;
}
```

## 7. ProductFilters & ProductSort (`product_repository.dart`)
Structures used to refine repository queries.
```dart
enum ProductSort { recommended, priceLowToHigh, priceHighToLow, highestDiscount, highestRated }

class ProductFilters {
  final double? minPrice;
  final double? maxPrice;
  final List<String>? brands;
  final List<Retailer>? retailers;
  final double? minRating;
  final double? minDiscount;
  final bool? inStockOnly;
}
```

## Relationships
- A `Product` belongs to one `Category`.
- A `Product` contains multiple `RetailerOffer`s.
- A `WishlistItem` contains one `Product`.
- A `SearchResult` contains multiple `Product`s.
