import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dekho/domain/models/models.dart';
import 'package:dekho/core/providers/repository_providers.dart';

class WishlistNotifier extends Notifier<List<WishlistItem>> {
  @override
  List<WishlistItem> build() {
    load();
    return [];
  }

  Future<void> load() async {
    final repository = ref.read(wishlistRepositoryProvider);
    state = await repository.getWishlistItems();
  }

  Future<void> add(Product product) async {
    final repository = ref.read(wishlistRepositoryProvider);
    await repository.addToWishlist(product);
    await load();
  }

  Future<void> remove(String productId) async {
    final repository = ref.read(wishlistRepositoryProvider);
    await repository.removeFromWishlist(productId);
    await load();
  }

  Future<void> toggle(Product product) async {
    final isWishlisted = state.any((item) => item.product.id == product.id);
    if (isWishlisted) {
      await remove(product.id);
    } else {
      await add(product);
    }
  }
}

final wishlistItemsProvider = NotifierProvider<WishlistNotifier, List<WishlistItem>>(WishlistNotifier.new);

final isWishlistedProvider = Provider.family<bool, String>((ref, productId) {
  final items = ref.watch(wishlistItemsProvider);
  return items.any((item) => item.product.id == productId);
});
