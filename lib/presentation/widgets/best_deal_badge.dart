import 'package:flutter/material.dart';
import 'package:dekho/core/theme/app_colors.dart';
import 'package:dekho/core/theme/app_spacing.dart';
import 'package:dekho/core/theme/app_radius.dart';
import 'package:dekho/core/theme/app_typography.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BestDealBadge extends StatelessWidget {
  const BestDealBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xxs),
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: AppRadius.full,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(LucideIcons.trophy, size: 14, color: AppColors.primary),
          const SizedBox(width: AppSpacing.xxs),
          Text('Best Deal', style: AppTypography.label.copyWith(color: AppColors.primary)),
        ],
      ),
    );
  }
}
