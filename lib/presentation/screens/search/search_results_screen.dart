import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:dekho/core/theme/theme.dart';
import 'package:dekho/core/routing/routes.dart';
import 'package:dekho/core/providers/providers.dart';
import 'package:dekho/presentation/widgets/product_card.dart';
import 'package:dekho/presentation/widgets/shimmer_loading.dart';
import 'package:dekho/presentation/widgets/empty_state.dart';
import 'package:dekho/presentation/widgets/error_state.dart';
import 'package:dekho/presentation/widgets/animated_list_item.dart';
import 'package:dekho/presentation/widgets/filter_bottom_sheet.dart';
import 'package:dekho/presentation/widgets/sort_bottom_sheet.dart';

class SearchResultsScreen extends ConsumerStatefulWidget {
  final String query;

  const SearchResultsScreen({
    super.key,
    required this.query,
  });

  @override
  ConsumerState<SearchResultsScreen> createState() =>
      _SearchResultsScreenState();
}

class _SearchResultsScreenState extends ConsumerState<SearchResultsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(searchQueryProvider.notifier).set(widget.query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final resultsAsync = ref.watch(searchQueryResultsProvider(widget.query));
    final filters = ref.watch(productFiltersProvider);
    final selectedSort = ref.watch(selectedSortProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppColors.text),
          onPressed: () => context.pop(),
        ),
        title: Text(
          widget.query,
          style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          // Filter & Sort Control Bar
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                Expanded(
                  child: resultsAsync.maybeWhen(
                    data: (products) => Text(
                      '${products.length} products found',
                      style: AppTypography.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    orElse: () => const SizedBox.shrink(),
                  ),
                ),
                _FilterChip(
                  label: 'Filters',
                  icon: LucideIcons.slidersHorizontal,
                  isActive: filters.hasActiveFilters,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => const FilterBottomSheet(),
                    );
                  },
                ),
                const SizedBox(width: AppSpacing.sm),
                _FilterChip(
                  label: selectedSort.name,
                  icon: LucideIcons.arrowUpDown,
                  isActive: false,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => const SortBottomSheet(),
                    );
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.divider),

          // Results Grid
          Expanded(
            child: resultsAsync.when(
              loading: () => ShimmerLoading.productList(),
              error: (error, _) => ErrorState(
                message: 'Something went wrong',
                onRetry: () =>
                    ref.refresh(searchQueryResultsProvider(widget.query)),
              ),
              data: (products) {
                if (products.isEmpty) {
                  return const EmptyState(
                    title: 'No results found',
                    subtitle: 'Try adjusting your search or filters.',
                    icon: LucideIcons.search,
                  );
                }

                return GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppSpacing.md,
                    crossAxisSpacing: AppSpacing.md,
                    childAspectRatio: 0.68,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return AnimatedListItem(
                      index: index,
                      child: ProductCard(
                        product: product,
                        onTap: () => context.push(
                          AppRoutes.productDetailPath(product.id),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primarySurface : AppColors.surface,
          border: Border.all(
            color: isActive ? AppColors.primary : AppColors.border,
          ),
          borderRadius: AppRadius.full,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14,
              color: isActive ? AppColors.primary : AppColors.text,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: AppTypography.labelMedium.copyWith(
                color: isActive ? AppColors.primary : AppColors.text,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (isActive) ...[
              const SizedBox(width: AppSpacing.xs),
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
