import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dekho/core/theme/app_colors.dart';
import 'package:dekho/core/theme/app_spacing.dart';
import 'package:dekho/core/theme/app_radius.dart';
import 'package:dekho/core/theme/app_typography.dart';
class FilterBottomSheet extends ConsumerWidget {
  const FilterBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: AppRadius.xl.topLeft),
      ),
      builder: (context) => const FilterBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Filters', style: AppTypography.h2),
            const SizedBox(height: AppSpacing.lg),
            
            Text('Price Range', style: AppTypography.h3),
            const SizedBox(height: AppSpacing.sm),
            RangeSlider(
              values: const RangeValues(0, 10000),
              min: 0,
              max: 50000,
              activeColor: AppColors.primary,
              inactiveColor: AppColors.neutral200,
              onChanged: (values) {},
            ),
            
            const SizedBox(height: AppSpacing.lg),
            Text('Brand', style: AppTypography.h3),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                _buildChip('Apple', true),
                _buildChip('Samsung', false),
                _buildChip('Sony', false),
              ],
            ),
            
            const SizedBox(height: AppSpacing.lg),
            Text('Retailer', style: AppTypography.h3),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                _buildChip('Amazon', true),
                _buildChip('Flipkart', true),
                _buildChip('Croma', false),
              ],
            ),
            
            const SizedBox(height: AppSpacing.lg),
            Text('Rating', style: AppTypography.h3),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              children: [
                _buildChoiceChip('4+ & above', true),
                _buildChoiceChip('3+ & above', false),
              ],
            ),
            
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('In Stock Only', style: AppTypography.bodyMedium),
                Switch(
                  value: true,
                  onChanged: (val) {},
                  activeTrackColor: AppColors.primary,
                ),
              ],
            ),
            
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Reset', style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(borderRadius: AppRadius.sm),
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                    ),
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {},
      selectedColor: AppColors.primarySurface,
      checkmarkColor: AppColors.primary,
      labelStyle: AppTypography.bodySmall.copyWith(
        color: isSelected ? AppColors.primary : AppColors.text,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
      ),
      backgroundColor: AppColors.neutral50,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.sm,
        side: BorderSide(color: isSelected ? AppColors.primary : AppColors.border),
      ),
    );
  }

  Widget _buildChoiceChip(String label, bool isSelected) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {},
      selectedColor: AppColors.primarySurface,
      labelStyle: AppTypography.bodySmall.copyWith(
        color: isSelected ? AppColors.primary : AppColors.text,
      ),
      backgroundColor: AppColors.neutral50,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.sm,
        side: BorderSide(color: isSelected ? AppColors.primary : AppColors.border),
      ),
    );
  }
}
