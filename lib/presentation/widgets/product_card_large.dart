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

class ProductCardLarge extends StatefulWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCardLarge({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  State<ProductCardLarge> createState() => _ProductCardLargeState();
}

class _ProductCardLargeState extends State<ProductCardLarge>
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
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
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
    final bestOffer = product.bestOffer;
    final savings = bestOffer.savings > 0 ? bestOffer.savings : 2500.0;

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
            borderRadius: AppRadius.md,
            border: Border.all(color: AppColors.border),
            boxShadow: AppShadows.subtle,
          ),
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Row(
            children: [
              // Product Image container
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

              // Product Info & Price
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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

                    // Price + Slashed Original
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          CurrencyFormatter.format(product.bestPrice),
                          style: AppTypography.priceMedium.copyWith(
                            color: AppColors.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        if (product.bestOriginalPrice != null) ...[
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            CurrencyFormatter.format(product.bestOriginalPrice!),
                            style: AppTypography.caption.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Dropped by badge
                    Row(
                      children: [
                        const Icon(
                          LucideIcons.arrowDown,
                          size: 12,
                          color: AppColors.discount,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          'Dropped by ${CurrencyFormatter.format(savings)} today',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.discount,
                            fontWeight: FontWeight.w700,
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
      ),
    );
  }
}
