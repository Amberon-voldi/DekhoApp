import 'product.dart';

class SearchResult {
  final String query;
  final List<Product> products;
  final int totalCount;

  const SearchResult({
    required this.query,
    required this.products,
    required this.totalCount,
  });
}
