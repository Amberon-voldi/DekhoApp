import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dekho/domain/repositories/repositories.dart';
import 'package:dekho/data/repositories/remote_product_repository.dart';
import 'package:dekho/data/mock/mock_search_repository.dart';
import 'package:dekho/data/mock/mock_wishlist_repository.dart';

final remoteProductRepositoryProvider = Provider<RemoteProductRepository>((ref) {
  return RemoteProductRepository();
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ref.watch(remoteProductRepositoryProvider);
});

final searchRepositoryProvider = Provider<SearchRepository>((ref) => MockSearchRepository());
final wishlistRepositoryProvider = Provider<WishlistRepository>((ref) => MockWishlistRepository());
