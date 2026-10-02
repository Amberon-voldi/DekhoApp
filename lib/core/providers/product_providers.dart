import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dekho/domain/models/models.dart';
import 'package:dekho/core/providers/repository_providers.dart';

final trendingProductsProvider = FutureProvider<List<Product>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getTrendingProducts();
});

final dealProductsProvider = FutureProvider<List<Product>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getDealProducts();
});

final productDetailProvider =
    FutureProvider.family<Product?, String>((ref, id) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProductById(id);
});

final similarProductsProvider =
    FutureProvider.family<List<Product>, String>((ref, productId) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getSimilarProducts(productId);
});

final categoryProductsProvider =
    FutureProvider.family<List<Product>, String>((ref, categoryId) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProductsByCategory(categoryId);
});

final priceHistoryProvider =
    FutureProvider.family<PriceHistorySummary, String>((ref, productId) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getPriceHistory(productId);
});
