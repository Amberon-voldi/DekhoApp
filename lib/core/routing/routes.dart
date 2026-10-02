class AppRoutes {
  AppRoutes._();
  static const String splash = '/';
  static const String home = '/home';
  static const String explore = '/explore';
  static const String wishlist = '/wishlist';
  static const String profile = '/profile';
  static const String search = '/search';
  static const String searchResults = '/search/results';
  static const String productDetail = '/product/:id';
  static const String compare = '/compare';
  static const String recentlyViewed = '/recently-viewed';

  static String productDetailPath(String id) => '/product/$id';
}
