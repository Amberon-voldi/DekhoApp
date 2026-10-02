import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dekho/domain/models/models.dart';

class RecentlyViewedNotifier extends Notifier<List<Product>> {
  @override
  List<Product> build() => [];

  void add(Product product) {
    final currentList = state.toList();
    currentList.removeWhere((p) => p.id == product.id);
    currentList.insert(0, product);
    if (currentList.length > 20) {
      currentList.removeLast();
    }
    state = currentList;
  }

  void clear() {
    state = [];
  }
}

final recentlyViewedProvider = NotifierProvider<RecentlyViewedNotifier, List<Product>>(RecentlyViewedNotifier.new);
