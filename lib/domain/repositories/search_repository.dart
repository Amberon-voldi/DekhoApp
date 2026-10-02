abstract class SearchRepository {
  Future<List<String>> getSuggestions(String query);
  Future<List<String>> getRecentSearches();
  Future<List<String>> getTrendingSearches();
  Future<void> addRecentSearch(String query);
  Future<void> clearRecentSearches();
}
