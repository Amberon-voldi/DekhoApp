# Dekho Mock Data Infrastructure

During Phase 1 of development, Dekho relies entirely on a mock data layer to populate the UI. This allows the frontend team to build and test all features (search, filtering, UI states) without waiting for the backend APIs.

## Architecture of Mock Data

The mock data is located in `lib/data/mock/`.

### 1. Hardcoded Entities
- **`mock_categories.dart`**: Contains ~10 standard categories (Mobiles, Laptops, Audio, TVs, Appliances, etc.) populated with `LucideIcons`.
- **`mock_products.dart`**: Contains a large list (~30) of `Product` objects. These are highly detailed to ensure UI fidelity.

### 2. Realistic Data Construction
To make the app feel real, the mock data uses accurate information:
- **Names:** Actual product names (e.g., "Apple iPhone 15 Pro Max").
- **Prices:** Realistic INR values (e.g., ₹1,48,900) instead of random numbers.
- **Retailers:** Real platforms (Amazon, Flipkart, Croma) distributed logically. Not every product is available on every platform.
- **Variations:** Some products have massive discounts, others have none, testing the UI's handling of badges and price calculations.

### 3. Mock Repositories
The repository implementations (e.g., `MockProductRepository` in `lib/data/mock/mock_product_repository.dart`) implement the domain contracts but serve the hardcoded data.

**Key Feature: Network Simulation**
All mock repository methods include an artificial delay to simulate network latency. This is crucial for testing loading states (Shimmer effects) in the UI.

```dart
// Example from MockProductRepository
@override
Future<List<Product>> searchProducts(String query, {ProductFilters? filters, ProductSort sort = ProductSort.recommended}) async {
  // Simulate network delay
  await Future.delayed(const Duration(milliseconds: 800));
  
  // Implementation of actual search logic against the mock_products list
  var results = mockProducts.where((p) => 
    p.name.toLowerCase().contains(query.toLowerCase()) || 
    p.brand.toLowerCase().contains(query.toLowerCase())
  ).toList();
  
  // Application of mock filters and sorting...
  return results;
}
```

## How to Add New Mock Products

1. Open `lib/data/mock/mock_products.dart`.
2. Locate the `final List<Product> mockProducts = [...]` list.
3. Instantiate a new `Product` object.
4. Provide realistic text strings for `name`, `brand`, and `description`.
5. For `images`, use placeholder strings like `'macbook_air_1'` (the UI will handle generating colored placeholder blocks based on these strings).
6. Create 2-4 `RetailerOffer` objects in the `offers` array. Ensure one represents the "Best Deal".
7. Assign a valid `categoryId` matching an ID from `mock_categories.dart`.

## Transitioning Away
Because the UI relies on Riverpod providers that inject the `ProductRepository` interface, switching away from mock data simply requires changing the provider in `lib/core/providers/repository_providers.dart` to return an `ApiProductRepository`.
