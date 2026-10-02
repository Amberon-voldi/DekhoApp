import 'package:dekho/domain/models/product.dart';
import 'package:dekho/domain/models/wishlist_item.dart';
import 'package:dekho/domain/repositories/wishlist_repository.dart';

class MockWishlistRepository implements WishlistRepository {
  final List<WishlistItem> _wishlist = [];

  @override
  Future<List<WishlistItem>> getWishlistItems() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_wishlist);
  }

  @override
  Future<void> addToWishlist(Product product) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final exists = _wishlist.any((item) => item.product.id == product.id);
    if (!exists) {
      _wishlist.add(WishlistItem(
        product: product,
        addedAt: DateTime.now(),
        previousBestPrice: product.bestPrice + (product.bestPrice * 0.05),
      ));
    }
  }

  @override
  Future<void> removeFromWishlist(String productId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _wishlist.removeWhere((item) => item.product.id == productId);
  }

  @override
  Future<bool> isWishlisted(String productId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _wishlist.any((item) => item.product.id == productId);
  }
}
