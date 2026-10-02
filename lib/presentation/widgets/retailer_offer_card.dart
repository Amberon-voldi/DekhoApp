import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:dekho/core/theme/theme.dart';
import 'package:dekho/core/utils/formatters.dart';
import 'package:dekho/domain/models/models.dart';

class RetailerOfferCard extends StatefulWidget {
  final RetailerOffer offer;
  final bool isBestDeal;
  final VoidCallback? onBuyNow;

  const RetailerOfferCard({
    super.key,
    required this.offer,
    this.isBestDeal = false,
    this.onBuyNow,
  });

  @override
  State<RetailerOfferCard> createState() => _RetailerOfferCardState();
}

class _RetailerOfferCardState extends State<RetailerOfferCard>
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
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
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
    final offer = widget.offer;
    final isBest = widget.isBestDeal;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onBuyNow,
        borderRadius: AppRadius.lg,
        child: Container(
          decoration: BoxDecoration(
            color: isBest ? AppColors.surfaceContainerLow : AppColors.surface,
            borderRadius: AppRadius.lg,
            border: Border.all(
              color: isBest
                  ? AppColors.primary.withValues(alpha: 0.5)
                  : AppColors.border,
              width: isBest ? 1.5 : 1,
            ),
          ),
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              // Store icon/avatar badge
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: AppRadius.md,
                  border: Border.all(color: AppColors.border),
                ),
                alignment: Alignment.center,
                child: Text(
                  offer.retailer.displayName.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: offer.retailer.brandColor,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              // Retailer Info & Delivery
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          offer.retailer.displayName,
                          style: AppTypography.titleMedium.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (isBest) ...[
                          const SizedBox(width: AppSpacing.xs),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.bestDealSurface,
                              borderRadius: AppRadius.xs,
                            ),
                            child: Text(
                              'LOWEST',
                              style: AppTypography.labelMedium.copyWith(
                                color: AppColors.bestDeal,
                                fontWeight: FontWeight.w800,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(
                          LucideIcons.truck,
                          size: 13,
                          color: isBest
                              ? AppColors.success
                              : AppColors.textTertiary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            offer.deliveryInfo,
                            style: AppTypography.caption.copyWith(
                              color: isBest
                                  ? AppColors.success
                                  : AppColors.textSecondary,
                              fontWeight: isBest
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Price and Buy CTA
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    CurrencyFormatter.format(offer.price),
                    style: AppTypography.priceMedium.copyWith(
                      fontSize: 17,
                      color: isBest ? AppColors.primary : AppColors.text,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (offer.originalPrice != null)
                    Text(
                      CurrencyFormatter.format(offer.originalPrice!),
                      style: AppTypography.caption.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  const SizedBox(height: 6),

                  // Tactile Buy Button
                  GestureDetector(
                    onTapDown: (_) => _controller.forward(),
                    onTapUp: (_) {
                      _controller.reverse();
                      widget.onBuyNow?.call();
                    },
                    onTapCancel: () => _controller.reverse(),
                    child: AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder: (context, child) => Transform.scale(
                        scale: _scaleAnimation.value,
                        child: child,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isBest ? AppColors.primary : Colors.transparent,
                          borderRadius: AppRadius.full,
                          border: isBest
                              ? null
                              : Border.all(color: AppColors.border),
                        ),
                        child: Text(
                          'Buy Now',
                          style: AppTypography.labelMedium.copyWith(
                            color:
                                isBest ? AppColors.white : AppColors.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
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
    );
  }
}
