import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dekho/core/theme/app_colors.dart';
import 'package:dekho/core/theme/app_spacing.dart';
import 'package:dekho/core/theme/app_radius.dart';
import 'package:dekho/core/theme/app_typography.dart';
import 'package:dekho/core/providers/filter_sort_providers.dart';
import 'package:dekho/domain/repositories/product_repository.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SortBottomSheet extends ConsumerWidget {
  const SortBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: AppRadius.xl.topLeft),
      ),
      builder: (context) => const SortBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSort = ref.watch(selectedSortProvider);
    final options = {
      ProductSort.recommended: 'Recommended',
      ProductSort.priceLowToHigh: 'Price: Low → High',
      ProductSort.priceHighToLow: 'Price: High → Low',
      ProductSort.highestDiscount: 'Highest Discount',
      ProductSort.highestRated: 'Highest Rated',
    };

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Text('Sort By', style: AppTypography.h2),
            ),
            const SizedBox(height: AppSpacing.md),
            ...options.entries.map((entry) => _buildOption(context, ref, entry.key, entry.value, selectedSort == entry.key)),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context, WidgetRef ref, ProductSort sort, String title, bool isSelected) {
    return InkWell(
      onTap: () {
        ref.read(selectedSortProvider.notifier).set(sort);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
        child: Row(
          children: [
            Text(
              title,
              style: AppTypography.bodyMedium.copyWith(
                color: isSelected ? AppColors.primary : AppColors.text,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(LucideIcons.check, color: AppColors.primary, size: 20),
          ],
        ),
      ),
    );
  }
}
