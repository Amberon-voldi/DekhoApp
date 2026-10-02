import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dekho/core/theme/theme.dart';
import 'package:dekho/core/routing/routes.dart';
import 'package:dekho/core/providers/product_providers.dart';
import 'package:dekho/data/mock/mock_categories.dart';
import 'package:dekho/presentation/widgets/search_bar_widget.dart';
import 'package:dekho/presentation/widgets/category_banner_carousel.dart';
import 'package:dekho/presentation/widgets/product_card.dart';
import 'package:dekho/presentation/widgets/section_header.dart';
import 'package:dekho/presentation/widgets/shimmer_loading.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendingAsync = ref.watch(trendingProductsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Explore Categories',
          style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.w800),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: DekhoSearchBar(
                enabled: false,
                onTap: () => context.push(AppRoutes.search),
              ),
            ),
          ),

          // Featured Category Banners Carousel
          SliverToBoxAdapter(
            child: CategoryBannerCarousel(
              categories: mockCategories.take(5).toList(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSpacing.lg),
          ),

          // Trending Live Products Row
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: SectionHeader(
                    title: 'Trending Deals 🔥',
                    actionLabel: 'Search all',
                    onAction: () => context.push(AppRoutes.search),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                SizedBox(
                  height: 275,
                  child: trendingAsync.when(
                    data: (products) => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: AppSpacing.md),
                          child: SizedBox(
                            width: 175,
                            child: ProductCard(
                              product: product,
                              onTap: () => context.push(
                                AppRoutes.productDetailPath(product.id),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    loading: () => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      itemCount: 3,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.md),
                        child: SizedBox(
                          width: 190,
                          child: ShimmerLoading.productCard(),
                        ),
                      ),
                    ),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),

          // Categories Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Text(
                'All Categories',
                style: AppTypography.titleLarge.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSpacing.md),
          ),

          // All Categories Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
                childAspectRatio: 0.95,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final category = mockCategories[index];

                  return GestureDetector(
                    onTap: () => context.push(
                      '${AppRoutes.searchResults}?q=${Uri.encodeComponent(category.name)}',
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: AppRadius.lg,
                        boxShadow: AppShadows.card,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: ClipRRect(
                        borderRadius: AppRadius.lg,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Category Image
                            if (category.imageUrl != null)
                              CachedNetworkImage(
                                imageUrl: category.imageUrl!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  color: AppColors.surfaceContainerLow,
                                ),
                                errorWidget: (context, url, error) =>
                                    Container(
                                  color: AppColors.surfaceContainerLow,
                                  child: Icon(
                                    category.icon,
                                    size: 36,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),

                            // Gradient Overlay for readability
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    AppColors.black.withValues(alpha: 0.75),
                                  ],
                                ),
                              ),
                            ),

                            // Details
                            Padding(
                              padding: const EdgeInsets.all(AppSpacing.md),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category.name,
                                    style: AppTypography.titleMedium.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${category.productCount}+ deals',
                                    style: AppTypography.caption.copyWith(
                                      color: AppColors.white
                                          .withValues(alpha: 0.85),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: mockCategories.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSpacing.xxxl),
          ),
        ],
      ),
    );
  }
}
