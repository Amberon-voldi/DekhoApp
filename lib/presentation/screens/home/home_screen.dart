import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:dekho/core/theme/app_colors.dart';
import 'package:dekho/core/theme/app_spacing.dart';
import 'package:dekho/core/theme/app_radius.dart';
import 'package:dekho/core/theme/app_typography.dart';
import 'package:dekho/core/routing/routes.dart';
import 'package:dekho/core/providers/product_providers.dart';
import 'package:dekho/core/providers/recently_viewed_provider.dart';
import 'package:dekho/data/mock/mock_categories.dart';
import 'package:dekho/presentation/widgets/search_bar_widget.dart';
import 'package:dekho/presentation/widgets/category_chip.dart';
import 'package:dekho/presentation/widgets/category_banner_carousel.dart';
import 'package:dekho/presentation/widgets/product_card.dart';
import 'package:dekho/presentation/widgets/product_card_large.dart';
import 'package:dekho/presentation/widgets/section_header.dart';
import 'package:dekho/presentation/widgets/shimmer_loading.dart';
import 'package:dekho/presentation/widgets/animated_list_item.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendingProducts = ref.watch(trendingProductsProvider);
    final dealProducts = ref.watch(dealProductsProvider);
    final recentlyViewed = ref.watch(recentlyViewedProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
         
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.md,
                  AppSpacing.lg,
                  AppSpacing.sm,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: AppRadius.md,
                          ),
                          child: const Icon(
                            LucideIcons.shoppingBag,
                            color: AppColors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          'Dekho',
                          style: AppTypography.displayMedium.copyWith(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                            letterSpacing: -0.8,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // Notification button
                        Stack(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.border),
                              ),
                              child: const Icon(
                                LucideIcons.bell,
                                size: 19,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Positioned(
                              top: 2,
                              right: 2,
                              child: Container(
                                width: 9,
                                height: 9,
                                decoration: const BoxDecoration(
                                  color: AppColors.error,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: AppSpacing.sm),

                        // Profile Avatar
                        GestureDetector(
                          onTap: () => context.push(AppRoutes.profile),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerHigh,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.border),
                            ),
                            child: const Center(
                              child: Icon(
                                LucideIcons.user,
                                size: 20,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ─── Search Bar Area ──────────────────────────────
            SliverToBoxAdapter(
              child: AnimatedListItem(
                index: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.sm,
                    AppSpacing.lg,
                    AppSpacing.md,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Find the best deal',
                        style: AppTypography.titleLarge.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.text,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      DekhoSearchBar(
                        enabled: false,
                        onTap: () => context.push(AppRoutes.search),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ─── Trending Query Chips ─────────────────────────
            SliverToBoxAdapter(
              child: AnimatedListItem(
                index: 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Row(
                    children: [
                      'iPhone 16',
                      'Nike Air',
                      'Smart TV',
                      'MacBook M3',
                      'Sony WH-1000XM5',
                      'PlayStation 5',
                    ].map((term) {
                      return Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.sm),
                        child: ActionChip(
                          label: Text(
                            term,
                            style: AppTypography.labelMedium.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          backgroundColor: AppColors.surface,
                          side: const BorderSide(color: AppColors.border),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: 4,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: AppRadius.full,
                          ),
                          onPressed: () => context.push(
                            '${AppRoutes.searchResults}?q=${Uri.encodeComponent(term)}',
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            // ─── Hero Category Banners ───────────────────────
            SliverToBoxAdapter(
              child: AnimatedListItem(
                index: 2,
                child: CategoryBannerCarousel(
                  categories: mockCategories.take(4).toList(),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.lg),
            ),

            // ─── Categories (Circles) ─────────────────────────
            SliverToBoxAdapter(
              child: AnimatedListItem(
                index: 3,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Row(
                    children: mockCategories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.md),
                        child: CategoryChip(
                          category: category,
                          onTap: () => context.push(
                            '${AppRoutes.searchResults}?q=${Uri.encodeComponent(category.name)}',
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.lg),
            ),

            // ─── Today's Best Deals (Carousel) ────────────────
            SliverToBoxAdapter(
              child: AnimatedListItem(
                index: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.errorSurface,
                              borderRadius: AppRadius.xs,
                            ),
                            child: const Icon(
                              LucideIcons.flame,
                              size: 18,
                              color: AppColors.error,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            "Today's Best Deals",
                            style: AppTypography.titleLarge.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () => context.push(AppRoutes.explore),
                            child: Text(
                              'View All',
                              style: AppTypography.labelLarge.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    SizedBox(
                      height: 275,
                      child: dealProducts.when(
                        data: (products) => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
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
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                          itemCount: 3,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(right: AppSpacing.md),
                            child: SizedBox(
                              width: 190,
                              child: ShimmerLoading.productCard(),
                            ),
                          ),
                        ),
                        error: (err, stack) => const Center(
                          child: Text('Failed to load deals'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.xl),
            ),

            // ─── Price Drops Section ──────────────────────────
            SliverToBoxAdapter(
              child: AnimatedListItem(
                index: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.successSurface,
                              borderRadius: AppRadius.xs,
                            ),
                            child: const Icon(
                              LucideIcons.trendingDown,
                              size: 18,
                              color: AppColors.success,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            'Price Drops',
                            style: AppTypography.titleLarge.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    trendingProducts.when(
                      data: (products) => ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                        itemCount: products.take(4).length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                            child: ProductCardLarge(
                              product: product,
                              onTap: () => context.push(
                                AppRoutes.productDetailPath(product.id),
                              ),
                            ),
                          );
                        },
                      ),
                      loading: () => ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                        itemCount: 3,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: SizedBox(
                            height: 100,
                            child: ShimmerLoading.productCard(),
                          ),
                        ),
                      ),
                      error: (err, stack) => const Center(
                        child: Text('Failed to load price drops'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ─── Recently Viewed Section ──────────────────────
            if (recentlyViewed.isNotEmpty)
              SliverToBoxAdapter(
                child: AnimatedListItem(
                  index: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppSpacing.lg),
                      SectionHeader(
                        title: 'Recently Viewed',
                        actionLabel: 'See all',
                        onAction: () => context.push(AppRoutes.recentlyViewed),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      SizedBox(
                        height: 275,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                          itemCount: recentlyViewed.length,
                          itemBuilder: (context, index) {
                            final product = recentlyViewed[index];
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
                      ),
                    ],
                  ),
                ),
              ),

            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.xxxl),
            ),
          ],
        ),
      ),
    );
  }
}
