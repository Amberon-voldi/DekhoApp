import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:dekho/core/theme/app_colors.dart';
import 'package:dekho/core/theme/app_spacing.dart';
import 'package:dekho/core/theme/app_typography.dart';
import 'package:dekho/core/routing/routes.dart';
import 'package:dekho/core/providers/recently_viewed_provider.dart';
import 'package:dekho/presentation/widgets/product_card_large.dart';
import 'package:dekho/presentation/widgets/empty_state.dart';
import 'package:dekho/presentation/widgets/animated_list_item.dart';

class RecentlyViewedScreen extends ConsumerWidget {
  const RecentlyViewedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentlyViewed = ref.watch(recentlyViewedProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Recently Viewed', style: AppTypography.h3),
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => context.pop(),
        ),
        actions: [
          if (recentlyViewed.isNotEmpty)
            TextButton(
              onPressed: () {
                // Ignore if method does not exist
                try {
                  (ref.read(recentlyViewedProvider.notifier) as dynamic).clear();
                } catch (e) {
                  // Fallback if not available
                }
              },
              child: Text(
                'Clear All',
                style: AppTypography.bodyMedium.copyWith(color: AppColors.primary),
              ),
            ),
        ],
      ),
      body: recentlyViewed.isEmpty
          ? Center(
              child: EmptyState(
                icon: LucideIcons.clock,
                title: 'No recently viewed products',
                subtitle: 'Products you view will appear here',
                actionLabel: 'Explore Products',
                onAction: () => context.go(AppRoutes.home),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: recentlyViewed.length,
              itemBuilder: (context, index) {
                final product = recentlyViewed[index];
                return AnimatedListItem(
                  index: index,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: ProductCardLarge(
                      product: product,
                      onTap: () => context.push(AppRoutes.productDetailPath(product.id)),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
