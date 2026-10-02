import 'package:flutter/material.dart';
import 'package:dekho/core/theme/app_colors.dart';
import 'package:dekho/core/theme/app_spacing.dart';
import 'package:dekho/core/theme/app_typography.dart';
import 'package:lucide_icons/lucide_icons.dart';

class RatingBar extends StatelessWidget {
  final double rating;
  final int? reviewCount;
  final double size;

  const RatingBar({
    super.key,
    required this.rating,
    this.reviewCount,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          rating >= 1 ? LucideIcons.star : (rating >= 0.5 ? LucideIcons.starHalf : LucideIcons.star),
          color: AppColors.warning,
          size: size,
        ),
        const SizedBox(width: AppSpacing.xxs),
        Text(
          rating.toStringAsFixed(1),
          style: AppTypography.caption.copyWith(fontWeight: FontWeight.w600),
        ),
        if (reviewCount != null) ...[
          const SizedBox(width: AppSpacing.xxs),
          Text(
            '($reviewCount)',
            style: AppTypography.caption,
          ),
        ],
      ],
    );
  }
}
