import 'package:dekho/domain/repositories/search_repository.dart';
import 'package:dekho/data/mock/mock_search.dart';
import 'package:dekho/data/mock/mock_products.dart';

class MockSearchRepository implements SearchRepository {
  final List<String> _recentSearches = ['iphone', 'macbook', 'samsung'];

  @override
  Future<List<String>> getSuggestions(String query) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final lowerQuery = query.toLowerCase();
    
    for (final key in mockSuggestions.keys) {
      if (lowerQuery.startsWith(key)) {
        return mockSuggestions[key]!;
      }
    }
    
    return mockProducts
        .where((p) => p.name.toLowerCase().contains(lowerQuery) || p.brand.toLowerCase().contains(lowerQuery))
        .map((p) => p.name)
        .toSet()
        .take(5)
        .toList();
  }

  @override
  Future<List<String>> getRecentSearches() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.from(_recentSearches);
  }

  @override
  Future<List<String>> getTrendingSearches() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return mockTrendingSearches;
  }

  @override
  Future<void> addRecentSearch(String query) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _recentSearches.remove(query);
    _recentSearches.insert(0, query);
    if (_recentSearches.length > 10) {
      _recentSearches.removeLast();
    }
  }

  @override
  Future<void> clearRecentSearches() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _recentSearches.clear();
  }
}
