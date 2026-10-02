import 'package:dekho/domain/models/product.dart';
import 'package:dekho/domain/models/wishlist_item.dart';

abstract class WishlistRepository {
  Future<List<WishlistItem>> getWishlistItems();
  Future<void> addToWishlist(Product product);
  Future<void> removeFromWishlist(String productId);
  Future<bool> isWishlisted(String productId);
}
