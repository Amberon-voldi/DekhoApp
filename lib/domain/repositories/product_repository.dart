import 'package:dekho/domain/models/product.dart';
import 'package:dekho/domain/models/price_history.dart';
import 'package:dekho/domain/models/retailer.dart';

enum ProductSort { recommended, priceLowToHigh, priceHighToLow, highestDiscount, highestRated }

class ProductFilters {
  final double? minPrice;
  final double? maxPrice;
  final List<String>? brands;
  final List<Retailer>? retailers;
  final double? minRating;
  final double? minDiscount;
  final bool? inStockOnly;

  const ProductFilters({
    this.minPrice,
    this.maxPrice,
    this.brands,
    this.retailers,
    this.minRating,
    this.minDiscount,
    this.inStockOnly,
  });

  ProductFilters copyWith({
    double? minPrice,
    double? maxPrice,
    List<String>? brands,
    List<Retailer>? retailers,
    double? minRating,
    double? minDiscount,
    bool? inStockOnly,
  }) {
    return ProductFilters(
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      brands: brands ?? this.brands,
      retailers: retailers ?? this.retailers,
      minRating: minRating ?? this.minRating,
      minDiscount: minDiscount ?? this.minDiscount,
      inStockOnly: inStockOnly ?? this.inStockOnly,
    );
  }

  bool get hasActiveFilters =>
      minPrice != null ||
      maxPrice != null ||
      (brands != null && brands!.isNotEmpty) ||
      (retailers != null && retailers!.isNotEmpty) ||
      minRating != null ||
      minDiscount != null ||
      inStockOnly == true;
}

abstract class ProductRepository {
  Future<List<Product>> searchProducts(String query,
      {ProductFilters? filters, ProductSort sort = ProductSort.recommended});
  Future<Product?> getProductById(String id);
  Future<List<Product>> getTrendingProducts();
  Future<List<Product>> getDealProducts();
  Future<List<Product>> getSimilarProducts(String productId);
  Future<List<Product>> getProductsByCategory(String categoryId);
  Future<PriceHistorySummary> getPriceHistory(String productId);
}
