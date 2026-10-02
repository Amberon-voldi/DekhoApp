import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dekho/domain/models/models.dart';
import 'package:dekho/core/providers/repository_providers.dart';
import 'package:dekho/core/providers/filter_sort_providers.dart';

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';
  void set(String query) => state = query;
}

final searchQueryProvider =
    NotifierProvider<SearchQueryNotifier, String>(SearchQueryNotifier.new);

final searchResultsProvider = FutureProvider<List<Product>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];

  final sort = ref.watch(selectedSortProvider);
  final filters = ref.watch(productFiltersProvider);
  final repository = ref.watch(productRepositoryProvider);

  return repository.searchProducts(
    query,
    filters: filters.hasActiveFilters ? filters : null,
    sort: sort,
  );
});

final searchQueryResultsProvider =
    FutureProvider.family<List<Product>, String>((ref, query) async {
  final sort = ref.watch(selectedSortProvider);
  final filters = ref.watch(productFiltersProvider);
  final repository = ref.watch(productRepositoryProvider);

  return repository.searchProducts(
    query,
    filters: filters.hasActiveFilters ? filters : null,
    sort: sort,
  );
});

final searchSuggestionsProvider =
    FutureProvider<List<String>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.length < 2) return [];

  final repository = ref.watch(searchRepositoryProvider);
  return repository.getSuggestions(query);
});

final recentSearchesProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.watch(searchRepositoryProvider);
  return repository.getRecentSearches();
});

final trendingSearchesProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.watch(searchRepositoryProvider);
  return repository.getTrendingSearches();
});
