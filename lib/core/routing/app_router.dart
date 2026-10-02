import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routes.dart';

// Screens
import 'package:dekho/presentation/screens/splash/splash_screen.dart';
import 'package:dekho/presentation/screens/home/home_screen.dart';
import 'package:dekho/presentation/screens/explore/explore_screen.dart';
import 'package:dekho/presentation/screens/wishlist/wishlist_screen.dart';
import 'package:dekho/presentation/screens/profile/profile_screen.dart';
import 'package:dekho/presentation/screens/search/search_screen.dart';
import 'package:dekho/presentation/screens/search/search_results_screen.dart';
import 'package:dekho/presentation/screens/product/product_detail_screen.dart';
import 'package:dekho/presentation/screens/compare/compare_screen.dart';
import 'package:dekho/presentation/screens/recently_viewed/recently_viewed_screen.dart';

// Shell
import 'package:dekho/presentation/widgets/bottom_nav_shell.dart';

import 'package:dekho/domain/models/product.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeTabNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'homeTab');
final _exploreTabNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'exploreTab');
final _wishlistTabNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'wishlistTab');
final _profileTabNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'profileTab');

CustomTransitionPage<void> _buildFadeTransitionPage(
    BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

CustomTransitionPage<void> _buildSlideUpTransitionPage(
    BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        pageBuilder: (context, state) =>
            _buildFadeTransitionPage(context, state, const SplashScreen()),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BottomNavShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeTabNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.home,
                pageBuilder: (context, state) =>
                    _buildFadeTransitionPage(context, state, const HomeScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _exploreTabNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.explore,
                pageBuilder: (context, state) => _buildFadeTransitionPage(
                    context, state, const ExploreScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _wishlistTabNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.wishlist,
                pageBuilder: (context, state) => _buildFadeTransitionPage(
                    context, state, const WishlistScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _profileTabNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                pageBuilder: (context, state) => _buildFadeTransitionPage(
                    context, state, const ProfileScreen()),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.search,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) =>
            _buildSlideUpTransitionPage(context, state, const SearchScreen()),
      ),
      GoRoute(
        path: AppRoutes.searchResults,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final query = state.uri.queryParameters['q'] ??
              state.uri.queryParameters['query'] ??
              '';
          return _buildFadeTransitionPage(
              context, state, SearchResultsScreen(query: query));
        },
      ),
      GoRoute(
        path: AppRoutes.productDetail,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return _buildFadeTransitionPage(
              context, state, ProductDetailScreen(id: id));
        },
      ),
      GoRoute(
        path: AppRoutes.compare,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final product = state.extra as Product;
          return _buildFadeTransitionPage(context, state, CompareScreen(product: product));
        },
      ),
      GoRoute(
        path: AppRoutes.recentlyViewed,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => _buildFadeTransitionPage(
            context, state, const RecentlyViewedScreen()),
      ),
    ],
  );
});
