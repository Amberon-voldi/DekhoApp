import 'package:dekho/domain/models/product.dart';
import 'package:dekho/domain/models/price_history.dart';
import 'package:dekho/domain/repositories/product_repository.dart';
import 'package:dekho/data/mock/mock_products.dart';
import 'package:dekho/data/mock/mock_price_history.dart';

class MockProductRepository implements ProductRepository {
  @override
  Future<List<Product>> searchProducts(String query,
      {ProductFilters? filters, ProductSort sort = ProductSort.recommended}) async {
    await Future.delayed(const Duration(milliseconds: 250));

    var results = mockProducts.where((p) {
      final matchesQuery = p.name.toLowerCase().contains(query.toLowerCase()) ||
          p.brand.toLowerCase().contains(query.toLowerCase()) ||
          p.description.toLowerCase().contains(query.toLowerCase());
      if (!matchesQuery) return false;

      if (filters != null) {
        if (filters.minPrice != null && p.bestPrice < filters.minPrice!) return false;
        if (filters.maxPrice != null && p.bestPrice > filters.maxPrice!) return false;
        if (filters.brands != null &&
            filters.brands!.isNotEmpty &&
            !filters.brands!.contains(p.brand)) {
          return false;
        }
        if (filters.retailers != null && filters.retailers!.isNotEmpty) {
          final hasRetailer =
              p.offers.any((o) => filters.retailers!.contains(o.retailer));
          if (!hasRetailer) return false;
        }
        if (filters.minRating != null && p.rating < filters.minRating!) return false;
      }
      return true;
    }).toList();

    switch (sort) {
      case ProductSort.priceLowToHigh:
        results.sort((a, b) => a.bestPrice.compareTo(b.bestPrice));
        break;
      case ProductSort.priceHighToLow:
        results.sort((a, b) => b.bestPrice.compareTo(a.bestPrice));
        break;
      case ProductSort.highestDiscount:
        results.sort((a, b) =>
            (b.discountPercentage ?? 0).compareTo(a.discountPercentage ?? 0));
        break;
      case ProductSort.highestRated:
        results.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case ProductSort.recommended:
        break;
    }

    return results;
  }

  @override
  Future<Product?> getProductById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return mockProducts.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Product>> getTrendingProducts() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return mockProducts.take(10).toList();
  }

  @override
  Future<List<Product>> getDealProducts() async {
    await Future.delayed(const Duration(milliseconds: 200));
    var results = List<Product>.from(mockProducts);
    results.sort((a, b) =>
        (b.discountPercentage ?? 0).compareTo(a.discountPercentage ?? 0));
    return results.take(10).toList();
  }

  @override
  Future<List<Product>> getSimilarProducts(String productId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final product = await getProductById(productId);
    if (product == null) return [];
    return mockProducts
        .where((p) => p.categoryId == product.categoryId && p.id != productId)
        .take(5)
        .toList();
  }

  @override
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return mockProducts.where((p) => p.categoryId == categoryId).toList();
  }

  @override
  Future<PriceHistorySummary> getPriceHistory(String productId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final product = await getProductById(productId) ?? mockProducts.first;
    final entries = generatePriceHistory(
      basePrice: product.bestPrice,
      retailer: product.bestOffer.retailer,
      months: 3,
    );
    return createPriceHistorySummary(
      currentPrice: product.bestPrice,
      entries: entries,
    );
  }
}
