import 'package:flutter/material.dart';
import 'package:dekho/core/theme/app_colors.dart';
import 'package:dekho/core/theme/app_spacing.dart';
import 'package:dekho/core/theme/app_radius.dart';
import 'package:dekho/core/theme/app_typography.dart';

class DiscountBadge extends StatelessWidget {
  final double percentage;

  const DiscountBadge({
    super.key,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.success,
        borderRadius: AppRadius.full,
      ),
      child: Text(
        '${percentage.toStringAsFixed(0)}% off',
        style: AppTypography.label.copyWith(color: AppColors.white),
      ),
    );
  }
}
