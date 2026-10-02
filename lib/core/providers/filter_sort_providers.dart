import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dekho/domain/repositories/repositories.dart';
import 'package:dekho/domain/models/models.dart';

class SelectedSortNotifier extends Notifier<ProductSort> {
  @override
  ProductSort build() => ProductSort.recommended;
  void set(ProductSort sort) => state = sort;
}

final selectedSortProvider = NotifierProvider<SelectedSortNotifier, ProductSort>(SelectedSortNotifier.new);

class ProductFiltersNotifier extends Notifier<ProductFilters> {
  @override
  ProductFilters build() => const ProductFilters();

  void setPriceRange(double? min, double? max) {
    state = state.copyWith(minPrice: min, maxPrice: max);
  }
  void setBrands(List<String>? brands) {
    state = state.copyWith(brands: brands);
  }
  void setRetailers(List<Retailer>? retailers) {
    state = state.copyWith(retailers: retailers);
  }
  void setMinRating(double? minRating) {
    state = state.copyWith(minRating: minRating);
  }
  void setMinDiscount(double? minDiscount) {
    state = state.copyWith(minDiscount: minDiscount);
  }
  void setInStockOnly(bool? inStockOnly) {
    state = state.copyWith(inStockOnly: inStockOnly);
  }
  void reset() {
    state = const ProductFilters();
  }
}

final productFiltersProvider = NotifierProvider<ProductFiltersNotifier, ProductFilters>(ProductFiltersNotifier.new);
