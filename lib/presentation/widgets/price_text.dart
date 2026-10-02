import 'package:flutter/material.dart';
import 'package:dekho/core/theme/app_colors.dart';
import 'package:dekho/core/theme/app_spacing.dart';
import 'package:dekho/core/theme/app_typography.dart';
import 'package:dekho/core/utils/formatters.dart';
import 'package:dekho/presentation/widgets/discount_badge.dart';

class PriceText extends StatelessWidget {
  final double price;
  final double? originalPrice;
  final TextStyle? style;
  final bool showDiscount;
  final bool large;

  const PriceText({
    super.key,
    required this.price,
    this.originalPrice,
    this.style,
    this.showDiscount = true,
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = large ? AppTypography.priceLarge : AppTypography.price;
    final mergedStyle = style ?? defaultStyle;
    
    final hasDiscount = originalPrice != null && originalPrice! > price;
    final double discountPercentage = hasDiscount ? ((originalPrice! - price) / originalPrice! * 100) : 0;

    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            CurrencyFormatter.format(price),
            style: mergedStyle,
          ),
          if (hasDiscount) ...[
            const SizedBox(width: AppSpacing.xs),
            Text(
              CurrencyFormatter.format(originalPrice!),
              style: AppTypography.bodySmall.copyWith(
                decoration: TextDecoration.lineThrough,
                color: AppColors.textTertiary,
              ),
            ),
            if (showDiscount) ...[
              const SizedBox(width: AppSpacing.xs),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: DiscountBadge(percentage: discountPercentage),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
