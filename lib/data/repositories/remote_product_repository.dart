import 'package:dekho/domain/models/models.dart';
import 'package:dekho/domain/repositories/product_repository.dart';
import 'package:dekho/data/network/product_api_service.dart';
import 'package:dekho/data/mock/mock_price_history.dart';

class RemoteProductRepository implements ProductRepository {
  final ProductApiService _apiService;
  final Map<String, Product> _productCache = {};
  List<Product>? _cachedProducts;

  RemoteProductRepository({ProductApiService? apiService})
      : _apiService = apiService ?? ProductApiService();

  void _cacheItems(Iterable<Product> items) {
    for (final item in items) {
      _productCache[item.id] = item;
    }
  }

  Future<List<Product>> _getOrFetchAll() async {
    if (_cachedProducts != null && _cachedProducts!.isNotEmpty) {
      return _cachedProducts!;
    }
    final fetched = await _apiService.fetchProducts(limit: 100);
    _cachedProducts = fetched;
    _cacheItems(fetched);
    return fetched;
  }

  @override
  Future<List<Product>> searchProducts(
    String query, {
    ProductFilters? filters,
    ProductSort sort = ProductSort.recommended,
  }) async {
    List<Product> products;

    if (query.trim().isEmpty) {
      products = await _getOrFetchAll();
    } else {
      products = await _apiService.searchProducts(query);
      _cacheItems(products);
    }

    var results = products.where((p) {
      if (filters != null) {
        if (filters.minPrice != null && p.bestPrice < filters.minPrice!) {
          return false;
        }
        if (filters.maxPrice != null && p.bestPrice > filters.maxPrice!) {
          return false;
        }
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
        if (filters.minRating != null && p.rating < filters.minRating!) {
          return false;
        }
        if (filters.minDiscount != null &&
            (p.discountPercentage ?? 0) < filters.minDiscount!) {
          return false;
        }
        if (filters.inStockOnly == true && !p.bestOffer.inStock) {
          return false;
        }
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
    if (_productCache.containsKey(id)) {
      return _productCache[id];
    }
    final fetched = await _apiService.getProductById(id);
    if (fetched != null) {
      _productCache[fetched.id] = fetched;
    }
    return fetched;
  }

  @override
  Future<List<Product>> getTrendingProducts() async {
    final all = await _getOrFetchAll();
    return all.take(12).toList();
  }

  @override
  Future<List<Product>> getDealProducts() async {
    final all = await _getOrFetchAll();
    final sorted = List<Product>.from(all);
    sorted.sort((a, b) =>
        (b.discountPercentage ?? 0).compareTo(a.discountPercentage ?? 0));
    return sorted.take(10).toList();
  }

  @override
  Future<List<Product>> getSimilarProducts(String productId) async {
    final product = await getProductById(productId);
    if (product == null) return [];
    final all = await _getOrFetchAll();
    return all
        .where((p) =>
            (p.categoryId.toLowerCase() == product.categoryId.toLowerCase() ||
                p.brand.toLowerCase() == product.brand.toLowerCase()) &&
            p.id != productId)
        .take(6)
        .toList();
  }

  @override
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    final products = await _apiService.fetchProductsByCategory(categoryId);
    _cacheItems(products);
    return products;
  }

  @override
  Future<PriceHistorySummary> getPriceHistory(String productId) async {
    final product = await getProductById(productId);
    final basePrice = product?.bestPrice ?? 29999.0;
    final retailer = product?.bestOffer.retailer ?? Retailer.amazon;

    final entries = generatePriceHistory(
      basePrice: basePrice,
      retailer: retailer,
      months: 3,
    );

    return createPriceHistorySummary(
      currentPrice: basePrice,
      entries: entries,
    );
  }
}
