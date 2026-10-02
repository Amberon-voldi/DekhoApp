import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:dekho/core/theme/theme.dart';
import 'package:dekho/core/utils/formatters.dart';
import 'package:dekho/core/utils/url_helper.dart';
import 'package:dekho/domain/models/models.dart';
import 'package:dekho/presentation/widgets/product_image.dart';
import 'package:dekho/presentation/widgets/empty_state.dart';
import 'package:dekho/presentation/widgets/retailer_offer_card.dart';

class CompareScreen extends ConsumerWidget {
  final Product product;

  const CompareScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (product.offers.length <= 1) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          elevation: 0,
          title: Text(
            'Compare Prices',
            style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.w800),
          ),
          leading: IconButton(
            icon: const Icon(LucideIcons.arrowLeft, color: AppColors.text),
            onPressed: () => context.pop(),
          ),
        ),
        body: EmptyState(
          icon: LucideIcons.store,
          title: 'Not enough offers',
          subtitle: 'Check back later for more price comparisons on this product.',
          actionLabel: 'Go Back',
          onAction: () => context.pop(),
        ),
      );
    }

    final bestPrice = product.bestPrice;
    final highestDiscount = product.offers
        .map((o) => o.discountPercentage ?? 0)
        .reduce((a, b) => a > b ? a : b);
    final highestRating = product.offers
        .map((o) => o.sellerRating ?? 0)
        .reduce((a, b) => a > b ? a : b);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text(
          'Compare Prices',
          style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.w800),
        ),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppColors.text),
          onPressed: () => context.pop(),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Product header overview
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.surface,
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: AppRadius.sm,
                    ),
                    padding: const EdgeInsets.all(AppSpacing.xs),
                    child: ProductImage(
                      imageUrl: product.images.isNotEmpty ? product.images.first : '',
                      fallbackBrand: product.brand,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.brand.toUpperCase(),
                          style: AppTypography.labelMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          product.name,
                          style: AppTypography.titleMedium.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          product.variant,
                          style: AppTypography.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSpacing.md),
          ),

          // Comparison Data Table Card
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppRadius.lg,
                  border: Border.all(color: AppColors.border),
                  boxShadow: AppShadows.subtle,
                ),
                child: DataTable(
                  headingRowColor:
                      WidgetStateProperty.all(AppColors.surfaceContainerLow),
                  columnSpacing: AppSpacing.xl,
                  horizontalMargin: AppSpacing.lg,
                  columns: [
                    DataColumn(
                      label: Text(
                        'Metrics',
                        style: AppTypography.labelLarge.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    ...product.offers.map((offer) => DataColumn(
                          label: Text(
                            offer.retailer.displayName,
                            style: AppTypography.labelLarge.copyWith(
                              color: offer.retailer.brandColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        )),
                  ],
                  rows: [
                    _buildRow('Price', product.offers, (offer) {
                      final isBest = offer.price == bestPrice;
                      return Text(
                        CurrencyFormatter.format(offer.price),
                        style: AppTypography.priceSmall.copyWith(
                          color: isBest ? AppColors.primary : AppColors.text,
                          fontWeight: isBest ? FontWeight.w900 : FontWeight.w600,
                        ),
                      );
                    }),
                    _buildRow('Original Price', product.offers, (offer) {
                      return Text(
                        offer.originalPrice != null
                            ? CurrencyFormatter.format(offer.originalPrice!)
                            : '-',
                        style: AppTypography.bodySmall.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: AppColors.textTertiary,
                        ),
                      );
                    }),
                    _buildRow('Discount', product.offers, (offer) {
                      final discount = offer.discountPercentage ?? 0;
                      final isBest = discount > 0 && discount == highestDiscount;
                      return Text(
                        discount > 0 ? '${discount.toStringAsFixed(0)}% OFF' : '-',
                        style: AppTypography.bodyMedium.copyWith(
                          color: isBest ? AppColors.discount : AppColors.text,
                          fontWeight: isBest ? FontWeight.w800 : FontWeight.w500,
                        ),
                      );
                    }),
                    _buildRow('Delivery', product.offers, (offer) {
                      return Text(
                        offer.deliveryInfo,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      );
                    }),
                    _buildRow('Rating', product.offers, (offer) {
                      final rating = offer.sellerRating ?? 0;
                      final isBest = rating > 0 && rating == highestRating;
                      return Row(
                        children: [
                          Icon(
                            LucideIcons.star,
                            size: 13,
                            color: isBest
                                ? AppColors.warning
                                : AppColors.textTertiary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            rating > 0 ? rating.toStringAsFixed(1) : '-',
                            style: AppTypography.bodyMedium.copyWith(
                              fontWeight:
                                  isBest ? FontWeight.w800 : FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    }),
                    _buildRow('In Stock', product.offers, (offer) {
                      return Icon(
                        offer.inStock
                            ? LucideIcons.checkCircle2
                            : LucideIcons.xCircle,
                        size: 18,
                        color: offer.inStock
                            ? AppColors.success
                            : AppColors.error,
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSpacing.lg),
          ),

          // Best Deal Card
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Best Deal Winner 🏆',
                    style: AppTypography.titleLarge.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  RetailerOfferCard(
                    offer: product.bestOffer,
                    isBestDeal: true,
                    onBuyNow: () => UrlHelper.launchRetailerOffer(
                      context,
                      product.bestOffer,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(String label, List<RetailerOffer> offers,
      Widget Function(RetailerOffer) builder) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            label,
            style: AppTypography.labelMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        ...offers.map((offer) => DataCell(builder(offer))),
      ],
    );
  }
}
