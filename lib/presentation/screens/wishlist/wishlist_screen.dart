import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:dekho/core/theme/theme.dart';
import 'package:dekho/core/routing/routes.dart';
import 'package:dekho/core/providers/providers.dart';
import 'package:dekho/core/utils/formatters.dart';
import 'package:dekho/presentation/widgets/product_image.dart';
import 'package:dekho/presentation/widgets/empty_state.dart';
import 'package:dekho/presentation/widgets/animated_list_item.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistItems = ref.watch(wishlistItemsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: AppRadius.sm,
              ),
              child: const Icon(
                LucideIcons.heart,
                color: AppColors.primary,
                size: 18,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'Wishlist',
              style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
      body: wishlistItems.isEmpty
          ? EmptyState(
              icon: LucideIcons.heart,
              title: 'Your wishlist is empty',
              subtitle: 'Save products to track price drops and compare stores.',
              actionLabel: 'Start Exploring',
              onAction: () => context.go(AppRoutes.home),
            )
          : ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: wishlistItems.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                final item = wishlistItems[index];
                return AnimatedListItem(
                  index: index,
                  child: Dismissible(
                    key: Key(item.product.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: AppRadius.md,
                      ),
                      child: const Icon(
                        LucideIcons.trash2,
                        color: AppColors.white,
                      ),
                    ),
                    onDismissed: (_) {
                      ref
                          .read(wishlistItemsProvider.notifier)
                          .remove(item.product.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${item.product.name} removed from wishlist',
                          ),
                        ),
                      );
                    },
                    child: _WishlistCard(
                      item: item,
                      onTap: () => context.push(
                        AppRoutes.productDetailPath(item.product.id),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class _WishlistCard extends StatelessWidget {
  final dynamic item;
  final VoidCallback onTap;

  const _WishlistCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final product = item.product;
    final priceChange = item.priceChange;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.md,
          border: Border.all(color: AppColors.border),
          boxShadow: AppShadows.subtle,
        ),
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: AppRadius.sm,
              ),
              padding: const EdgeInsets.all(AppSpacing.xs),
              child: ProductImage(
                imageUrl: product.images.isNotEmpty ? product.images.first : '',
                fallbackBrand: product.brand,
                borderRadius: AppRadius.xs,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.brand.toUpperCase(),
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.name,
                    style: AppTypography.titleMedium.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        CurrencyFormatter.format(product.bestPrice),
                        style: AppTypography.priceMedium.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      if (priceChange != null) ...[
                        Icon(
                          priceChange > 0
                              ? LucideIcons.trendingUp
                              : LucideIcons.trendingDown,
                          size: 13,
                          color: priceChange > 0
                              ? AppColors.error
                              : AppColors.success,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          CurrencyFormatter.format(priceChange.abs()),
                          style: AppTypography.caption.copyWith(
                            fontWeight: FontWeight.w700,
                            color: priceChange > 0
                                ? AppColors.error
                                : AppColors.success,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        LucideIcons.trophy,
                        size: 11,
                        color: AppColors.bestDeal,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Best on ${product.bestOffer.retailer.displayName}',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              LucideIcons.chevronRight,
              size: 18,
              color: AppColors.textTertiary,
            ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
