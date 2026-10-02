import 'product.dart';

class WishlistItem {
  final Product product;
  final DateTime addedAt;
  final double? previousBestPrice;

  const WishlistItem({
    required this.product,
    required this.addedAt,
    this.previousBestPrice,
  });

  double? get priceChange {
    if (previousBestPrice == null) return null;
    return product.bestPrice - previousBestPrice!;
  }
}
