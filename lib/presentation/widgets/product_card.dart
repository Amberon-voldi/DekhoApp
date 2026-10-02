import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:dekho/core/theme/app_colors.dart';
import 'package:dekho/core/theme/app_spacing.dart';
import 'package:dekho/core/theme/app_radius.dart';
import 'package:dekho/core/theme/app_typography.dart';
import 'package:dekho/core/theme/app_shadows.dart';
import 'package:dekho/core/theme/app_motion.dart';
import 'package:dekho/core/utils/formatters.dart';
import 'package:dekho/domain/models/product.dart';
import 'package:dekho/presentation/widgets/product_image.dart';
import 'package:dekho/presentation/widgets/wishlist_button.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppMotion.fast,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: AppMotion.microInteraction),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final discount = product.discountPercentage;
    final bestOffer = product.bestOffer;

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.lg,
            border: Border.all(color: AppColors.border),
            boxShadow: AppShadows.card,
          ),
          child: ClipRRect(
            borderRadius: AppRadius.lg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Product Image Area with Discount & Wishlist
                Stack(
                  children: [
                    Container(
                      height: 125,
                      width: double.infinity,
                      color: AppColors.neutral50,
                      padding: const EdgeInsets.all(AppSpacing.xs),
                      child: ProductImage(
                        imageUrl: product.images.isNotEmpty ? product.images.first : '',
                        fallbackBrand: product.brand,
                      ),
                    ),
                    if (discount != null && discount > 0)
                      Positioned(
                        top: 6,
                        left: 6,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.discountSurface,
                            borderRadius: AppRadius.xs,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                LucideIcons.arrowDown,
                                size: 10,
                                color: AppColors.discount,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '${discount.toStringAsFixed(0)}% OFF',
                                style: AppTypography.labelMedium.copyWith(
                                  color: AppColors.discount,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: WishlistButton(productId: product.id),
                    ),
                  ],
                ),

                // Product Details
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        product.brand.toUpperCase(),
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.textTertiary,
                          letterSpacing: 0.5,
                          fontSize: 10,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        product.name,
                        style: AppTypography.titleMedium.copyWith(
                          color: AppColors.text,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),

                      // Rating
                      Row(
                        children: [
                          const Icon(
                            LucideIcons.star,
                            size: 11,
                            color: AppColors.warning,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            product.rating.toStringAsFixed(1),
                            style: AppTypography.caption.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.text,
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '(${CurrencyFormatter.formatCompact(product.reviewCount.toDouble()).replaceAll('₹', '')})',
                            style: AppTypography.caption.copyWith(fontSize: 10),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),

                      // Price
                      Text(
                        CurrencyFormatter.format(product.bestPrice),
                        style: AppTypography.priceMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 3),

                      // Best price retailer tag
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLow,
                          borderRadius: AppRadius.xs,
                          border: Border.all(
                            color: AppColors.border.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              LucideIcons.trophy,
                              size: 11,
                              color: AppColors.bestDeal,
                            ),
                            const SizedBox(width: 3),
                            Flexible(
                              child: Text(
                                'Best: ${bestOffer.retailer.displayName}',
                                style: AppTypography.caption.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary,
                                  fontSize: 10,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
