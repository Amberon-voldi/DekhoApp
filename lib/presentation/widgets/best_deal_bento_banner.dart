import 'package:flutter/material.dart';
import 'package:dekho/core/theme/app_colors.dart';
import 'package:dekho/core/theme/app_spacing.dart';
import 'package:dekho/core/theme/app_radius.dart';
import 'package:dekho/core/theme/app_typography.dart';
import 'package:dekho/core/theme/app_shadows.dart';
import 'package:dekho/core/utils/formatters.dart';
import 'package:dekho/domain/models/product.dart';

class BestDealBentoBanner extends StatelessWidget {
  final Product product;

  const BestDealBentoBanner({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final bestOffer = product.bestOffer;
    final savings = product.priceDifference > 0
        ? product.priceDifference
        : (bestOffer.savings > 0 ? bestOffer.savings : 3000.0);

    return Container(
      decoration: BoxDecoration(
        borderRadius: AppRadius.lg,
        gradient: const LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primaryDark,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: AppShadows.elevated,
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🏆', style: TextStyle(fontSize: 18)),
              const SizedBox(width: AppSpacing.xs),
              Text(
                'DEKHO BEST DEAL',
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.white,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.2),
                  borderRadius: AppRadius.xs,
                ),
                child: Text(
                  'on ${bestOffer.retailer.displayName}',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                CurrencyFormatter.format(bestOffer.price),
                style: AppTypography.priceLarge.copyWith(
                  color: AppColors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
              if (bestOffer.originalPrice != null) ...[
                const SizedBox(width: AppSpacing.sm),
                Text(
                  CurrencyFormatter.format(bestOffer.originalPrice!),
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.white.withValues(alpha: 0.65),
                    decoration: TextDecoration.lineThrough,
                    decorationColor: AppColors.white.withValues(alpha: 0.65),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.xs),

          Text(
            'Save ${CurrencyFormatter.format(savings)} compared to average market price.',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
