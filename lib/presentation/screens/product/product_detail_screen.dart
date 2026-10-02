import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:dekho/core/theme/theme.dart';
import 'package:dekho/core/routing/routes.dart';
import 'package:dekho/core/providers/providers.dart';
import 'package:dekho/core/utils/formatters.dart';
import 'package:dekho/core/utils/url_helper.dart';
import 'package:dekho/domain/models/models.dart';
import 'package:dekho/presentation/widgets/product_image.dart';
import 'package:dekho/presentation/widgets/product_card.dart';
import 'package:dekho/presentation/widgets/retailer_offer_card.dart';
import 'package:dekho/presentation/widgets/best_deal_bento_banner.dart';
import 'package:dekho/presentation/widgets/price_history_chart.dart';
import 'package:dekho/presentation/widgets/shimmer_loading.dart';
import 'package:dekho/presentation/widgets/wishlist_button.dart';
import 'package:dekho/presentation/widgets/section_header.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final String id;

  const ProductDetailScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen>
    with TickerProviderStateMixin {
  late final AnimationController _fabController;
  late final Animation<double> _fabScale;
  bool _showAppBarTitle = false;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: AppMotion.standard,
    );
    _fabScale = CurvedAnimation(
      parent: _fabController,
      curve: AppMotion.spring,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final product =
          await ref.read(productDetailProvider(widget.id).future);
      if (product != null) {
        ref.read(recentlyViewedProvider.notifier).add(product);
      }
    });
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productAsync = ref.watch(productDetailProvider(widget.id));
    final priceHistoryAsync = ref.watch(priceHistoryProvider(widget.id));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: productAsync.when(
        loading: () => ShimmerLoading.productDetail(),
        error: (err, _) => _ProductErrorState(
          error: err.toString(),
          onRetry: () => ref.invalidate(productDetailProvider(widget.id)),
        ),
        data: (product) {
          if (product == null) {
            return _ProductNotFoundState(onGoBack: () => context.pop());
          }

          final bestOffer = product.bestOffer;

          return Stack(
            children: [
              NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  final offset = notification.metrics.pixels;
                  final shouldShowTitle = offset > 320;
                  if (shouldShowTitle != _showAppBarTitle) {
                    setState(() => _showAppBarTitle = shouldShowTitle);
                  }
                  // Show FAB after scrolling past hero
                  if (offset > 500 && !_fabController.isCompleted) {
                    _fabController.forward();
                  } else if (offset <= 500 && _fabController.isCompleted) {
                    _fabController.reverse();
                  }
                  return false;
                },
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // ─── App Bar & Image Gallery ──────────────────────
                    SliverAppBar(
                      expandedHeight: 400,
                      pinned: true,
                      backgroundColor: AppColors.surface,
                      surfaceTintColor: Colors.transparent,
                      leading: Padding(
                        padding: const EdgeInsets.only(left: AppSpacing.sm),
                        child: IconButton(
                          icon: Container(
                            padding: const EdgeInsets.all(AppSpacing.xs),
                            decoration: BoxDecoration(
                              color: AppColors.surface.withValues(alpha: 0.9),
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.border),
                            ),
                            child: const Icon(
                              LucideIcons.arrowLeft,
                              color: AppColors.text,
                              size: 20,
                            ),
                          ),
                          onPressed: () => context.pop(),
                        ),
                      ),
                      title: AnimatedOpacity(
                        opacity: _showAppBarTitle ? 1.0 : 0.0,
                        duration: AppMotion.fast,
                        child: Text(
                          product.name,
                          style: AppTypography.titleMedium.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      actions: [
                        IconButton(
                          icon: Container(
                            padding: const EdgeInsets.all(AppSpacing.xs),
                            decoration: BoxDecoration(
                              color: AppColors.surface.withValues(alpha: 0.9),
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.border),
                            ),
                            child: const Icon(
                              LucideIcons.share2,
                              color: AppColors.text,
                              size: 20,
                            ),
                          ),
                          onPressed: () => _handleShare(product),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: AppSpacing.md),
                          padding: const EdgeInsets.all(AppSpacing.xs),
                          decoration: BoxDecoration(
                            color: AppColors.surface.withValues(alpha: 0.9),
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.border),
                          ),
                          child: WishlistButton(productId: product.id),
                        ),
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        background: _ProductGallery(product: product),
                      ),
                    ),

                    // ─── Main Details Body ────────────────────────────
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ─── Header Section ────────────────────────
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              AppSpacing.lg,
                              AppSpacing.lg,
                              AppSpacing.lg,
                              0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Brand & Badges Row
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: AppSpacing.sm,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primarySurface,
                                        borderRadius: AppRadius.xs,
                                      ),
                                      child: Text(
                                        product.brand.toUpperCase(),
                                        style: AppTypography.labelLarge.copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 1.2,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: AppSpacing.sm,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.successSurface,
                                        borderRadius: AppRadius.sm,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            LucideIcons.truck,
                                            size: 13,
                                            color: AppColors.success,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Free Delivery',
                                            style: AppTypography.labelMedium.copyWith(
                                              color: AppColors.success,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: AppSpacing.xs),
                                    if (product.offers.every((o) => o.inStock))
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: AppSpacing.sm,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.successSurface,
                                          borderRadius: AppRadius.sm,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              LucideIcons.checkCircle,
                                              size: 13,
                                              color: AppColors.success,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              'In Stock',
                                              style: AppTypography.labelMedium.copyWith(
                                                color: AppColors.success,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: AppSpacing.sm),

                                // Product Title
                                Text(
                                  product.name,
                                  style: AppTypography.headlineLarge.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.xxs),
                                Text(
                                  product.variant,
                                  style: AppTypography.bodyMedium.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.sm),

                                // Rating Bar
                                _RatingSection(product: product),
                                const SizedBox(height: AppSpacing.lg),

                                // ─── Dekho Best Deal Bento Banner ─────
                                BestDealBentoBanner(product: product),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),

                          // ─── Key Highlights ────────────────────────
                          _KeyHighlightsRow(product: product),
                          const SizedBox(height: AppSpacing.lg),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ─── Quick Specs Grid ──────────────────
                                if (product.specifications.isNotEmpty) ...[
                                  _QuickSpecsGrid(specs: product.specifications),
                                  const SizedBox(height: AppSpacing.lg),
                                ],

                                // ─── Price History Chart ───────────────
                                priceHistoryAsync.when(
                                  data: (summary) =>
                                      PriceHistoryChart(summary: summary),
                                  loading: () => _ChartShimmer(),
                                  error: (_, __) => const SizedBox.shrink(),
                                ),
                                const SizedBox(height: AppSpacing.xl),

                                // ─── Store Price Comparison ────────────
                                _ComparePricesHeader(product: product),
                                const SizedBox(height: AppSpacing.md),

                                // Retailer Offers List
                                ...product.offers.map((offer) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: AppSpacing.sm,
                                    ),
                                    child: RetailerOfferCard(
                                      offer: offer,
                                      isBestDeal: offer == product.bestOffer,
                                      onBuyNow: () => _handleBuyNow(offer),
                                    ),
                                  );
                                }),
                                const SizedBox(height: AppSpacing.xl),

                                // ─── Detailed Specifications ──────────
                                if (product.specifications.isNotEmpty) ...[
                                  _SpecificationsAccordion(
                                    specifications: product.specifications,
                                  ),
                                  const SizedBox(height: AppSpacing.xl),
                                ],

                                // ─── Product Description ──────────────
                                if (product.description.isNotEmpty) ...[
                                  _ProductDescriptionSection(
                                    description: product.description,
                                  ),
                                  const SizedBox(height: AppSpacing.xl),
                                ],

                                // ─── Trust & Info Section ─────────────
                                _TrustInfoSection(),
                                const SizedBox(height: AppSpacing.xl),

                                // ─── Similar Products Carousel ────────
                                SectionHeader(title: 'Similar Products'),
                                const SizedBox(height: AppSpacing.md),
                              ],
                            ),
                          ),

                          // Similar products (full-bleed horizontal scroll)
                          Padding(
                            padding: const EdgeInsets.only(left: AppSpacing.lg),
                            child: _SimilarProductsSection(
                              productId: product.id,
                            ),
                          ),

                          // Extra padding for sticky bottom bar
                          const SizedBox(height: 120),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ─── Sticky Bottom Action Bar ─────────────────────────
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _StickyBottomBar(
                  bestOffer: bestOffer,
                  product: product,
                  onBuyNow: () => _handleBuyNow(bestOffer),
                  onCompare: () {
                    context.push(AppRoutes.compare, extra: product);
                  },
                ),
              ),

              // ─── Scroll-to-top FAB ────────────────────────────────
              Positioned(
                bottom: 100 + MediaQuery.of(context).padding.bottom,
                right: AppSpacing.md,
                child: ScaleTransition(
                  scale: _fabScale,
                  child: FloatingActionButton.small(
                    onPressed: () {
                      // Handled via scroll controller if needed
                    },
                    backgroundColor: AppColors.primary,
                    child: const Icon(
                      LucideIcons.chevronUp,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _handleShare(Product product) {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing ${product.name}...'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.md),
        backgroundColor: AppColors.neutral800,
      ),
    );
  }

  void _handleBuyNow(RetailerOffer offer) {
    UrlHelper.launchRetailerOffer(context, offer);
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// GALLERY
// ═════════════════════════════════════════════════════════════════════════════

class _ProductGallery extends StatefulWidget {
  final Product product;

  const _ProductGallery({required this.product});

  @override
  State<_ProductGallery> createState() => _ProductGalleryState();
}

class _ProductGalleryState extends State<_ProductGallery> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images =
        widget.product.images.isNotEmpty ? widget.product.images : [''];

    return Stack(
      children: [
        // Image page view
        PageView.builder(
          controller: _controller,
          onPageChanged: (index) => setState(() => _currentIndex = index),
          itemCount: images.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Could open full-screen image viewer
              },
              child: Container(
                color: AppColors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.xxl,
                ),
                child: Center(
                  child: Hero(
                    tag: 'product-image-${widget.product.id}',
                    child: ProductImage(
                      imageUrl: images[index],
                      fallbackBrand: widget.product.brand,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        // Image counter badge
        if (images.length > 1)
          Positioned(
            top: MediaQuery.of(context).padding.top + 56,
            right: AppSpacing.md,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: AppColors.black.withValues(alpha: 0.6),
                borderRadius: AppRadius.full,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    LucideIcons.image,
                    size: 12,
                    color: AppColors.white,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${_currentIndex + 1}/${images.length}',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),

        // Page indicator dots
        if (images.length > 1)
          Positioned(
            bottom: AppSpacing.md,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                (index) => AnimatedContainer(
                  duration: AppMotion.fast,
                  width: _currentIndex == index ? 24 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    borderRadius: AppRadius.full,
                    color: _currentIndex == index
                        ? AppColors.primary
                        : AppColors.neutral300,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// RATING SECTION
// ═════════════════════════════════════════════════════════════════════════════

class _RatingSection extends StatelessWidget {
  final Product product;

  const _RatingSection({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: AppRadius.sm,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xs,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: _ratingColor(product.rating),
              borderRadius: AppRadius.xs,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  product.rating.toStringAsFixed(1),
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 2),
                const Icon(Icons.star_rounded, size: 14, color: AppColors.white),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            _formatReviewCount(product.reviewCount),
            style: AppTypography.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            'ratings',
            style: AppTypography.caption,
          ),
        ],
      ),
    );
  }

  Color _ratingColor(double rating) {
    if (rating >= 4.0) return AppColors.success;
    if (rating >= 3.0) return AppColors.warning;
    return AppColors.error;
  }

  String _formatReviewCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// KEY HIGHLIGHTS (horizontal scroll chips)
// ═════════════════════════════════════════════════════════════════════════════

class _KeyHighlightsRow extends StatelessWidget {
  final Product product;

  const _KeyHighlightsRow({required this.product});

  @override
  Widget build(BuildContext context) {
    final highlights = _buildHighlights(product);
    if (highlights.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        itemCount: highlights.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final h = highlights[index];
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppRadius.full,
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(h.icon, size: 16, color: AppColors.primary),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  h.label,
                  style: AppTypography.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<_HighlightItem> _buildHighlights(Product product) {
    final items = <_HighlightItem>[];
    final specs = product.specifications;

    if (product.bestOffer.discountPercentage != null &&
        product.bestOffer.discountPercentage! > 0) {
      items.add(_HighlightItem(
        icon: LucideIcons.percent,
        label: '${product.bestOffer.discountPercentage!.toStringAsFixed(0)}% Off',
      ));
    }

    items.add(_HighlightItem(
      icon: LucideIcons.store,
      label: '${product.storeCount} Stores',
    ));

    if (specs.containsKey('Battery') || specs.containsKey('Battery Life')) {
      items.add(_HighlightItem(
        icon: LucideIcons.batteryCharging,
        label: specs['Battery'] ?? specs['Battery Life'] ?? '',
      ));
    }

    if (specs.containsKey('Display')) {
      items.add(_HighlightItem(
        icon: LucideIcons.monitor,
        label: 'Super Display',
      ));
    }

    if (specs.containsKey('Processor') || specs.containsKey('Chip')) {
      items.add(_HighlightItem(
        icon: LucideIcons.cpu,
        label: specs['Processor']?.split('(').first.trim() ??
            specs['Chip']?.split('(').first.trim() ??
            '',
      ));
    }

    items.add(_HighlightItem(
      icon: LucideIcons.shieldCheck,
      label: 'Verified Stores',
    ));

    return items;
  }
}

class _HighlightItem {
  final IconData icon;
  final String label;
  const _HighlightItem({required this.icon, required this.label});
}

// ═════════════════════════════════════════════════════════════════════════════
// QUICK SPECS GRID
// ═════════════════════════════════════════════════════════════════════════════

class _QuickSpecsGrid extends StatelessWidget {
  final Map<String, String> specs;

  const _QuickSpecsGrid({required this.specs});

  @override
  Widget build(BuildContext context) {
    final entries = specs.entries.take(4).toList();

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
        childAspectRatio: 2.0,
      ),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        final icon = _specIcon(entry.key);

        return Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.md,
            border: Border.all(color: AppColors.border),
          ),
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primarySurface,
                      AppColors.primarySurface.withValues(alpha: 0.5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: AppRadius.sm,
                ),
                child: Icon(icon, size: 18, color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      entry.key,
                      style: AppTypography.caption.copyWith(
                        fontSize: 11,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      entry.value,
                      style: AppTypography.bodySmall.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  IconData _specIcon(String key) {
    final lower = key.toLowerCase();
    if (lower.contains('camera') || lower.contains('front camera')) {
      return LucideIcons.camera;
    } else if (lower.contains('battery')) {
      return LucideIcons.batteryCharging;
    } else if (lower.contains('display') || lower.contains('screen')) {
      return LucideIcons.monitor;
    } else if (lower.contains('processor') || lower.contains('cpu') || lower.contains('chip')) {
      return LucideIcons.cpu;
    } else if (lower.contains('storage') || lower.contains('memory')) {
      return LucideIcons.hardDrive;
    } else if (lower.contains('weight')) {
      return LucideIcons.scale;
    } else if (lower.contains('audio') || lower.contains('sound') || lower.contains('driver')) {
      return LucideIcons.volume2;
    } else if (lower.contains('bluetooth') || lower.contains('connectivity')) {
      return LucideIcons.bluetooth;
    } else if (lower.contains('water') || lower.contains('resistance')) {
      return LucideIcons.droplets;
    } else if (lower.contains('charging')) {
      return LucideIcons.zap;
    }
    return LucideIcons.cpu;
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// COMPARE PRICES HEADER
// ═════════════════════════════════════════════════════════════════════════════

class _ComparePricesHeader extends StatelessWidget {
  final Product product;

  const _ComparePricesHeader({required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(LucideIcons.barChart3, size: 20, color: AppColors.primary),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'Compare Prices',
                    style: AppTypography.titleLarge.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                'Available across ${product.offers.length} verified stores',
                style: AppTypography.bodySmall,
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        OutlinedButton.icon(
          onPressed: () {
            context.push(AppRoutes.compare, extra: product);
          },
          icon: const Icon(LucideIcons.gitCompare, size: 16),
          label: const Text('Compare'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.border),
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.full,
            ),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 8,
            ),
          ),
        ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// SPECIFICATIONS ACCORDION
// ═════════════════════════════════════════════════════════════════════════════

class _SpecificationsAccordion extends StatelessWidget {
  final Map<String, String> specifications;

  const _SpecificationsAccordion({required this.specifications});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lg,
        border: Border.all(color: AppColors.border),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          initiallyExpanded: false,
          tilePadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.xs,
          ),
          title: Row(
            children: [
              const Icon(LucideIcons.listChecks, size: 20, color: AppColors.primary),
              const SizedBox(width: AppSpacing.xs),
              Text(
                'Full Specifications',
                style: AppTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          subtitle: Text(
            '${specifications.length} specs available',
            style: AppTypography.caption,
          ),
          children: [
            const Divider(height: 1, color: AppColors.divider),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              child: Column(
                children: specifications.entries.toList().asMap().entries.map((entry) {
                  final index = entry.key;
                  final spec = entry.value;
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      border: index < specifications.length - 1
                          ? const Border(
                              bottom: BorderSide(color: AppColors.divider),
                            )
                          : null,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            spec.key,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textTertiary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          flex: 3,
                          child: Text(
                            spec.value,
                            style: AppTypography.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// PRODUCT DESCRIPTION SECTION
// ═════════════════════════════════════════════════════════════════════════════

class _ProductDescriptionSection extends StatefulWidget {
  final String description;

  const _ProductDescriptionSection({required this.description});

  @override
  State<_ProductDescriptionSection> createState() =>
      _ProductDescriptionSectionState();
}

class _ProductDescriptionSectionState
    extends State<_ProductDescriptionSection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final isLong = widget.description.length > 120;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lg,
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.fileText, size: 20, color: AppColors.primary),
              const SizedBox(width: AppSpacing.xs),
              Text(
                'About this product',
                style: AppTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AnimatedCrossFade(
            firstChild: Text(
              widget.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.bodySmall.copyWith(
                height: 1.6,
                color: AppColors.textSecondary,
              ),
            ),
            secondChild: Text(
              widget.description,
              style: AppTypography.bodySmall.copyWith(
                height: 1.6,
                color: AppColors.textSecondary,
              ),
            ),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: AppMotion.standard,
          ),
          if (isLong) ...[
            const SizedBox(height: AppSpacing.xs),
            GestureDetector(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Text(
                _expanded ? 'Read Less' : 'Read More',
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// TRUST INFO SECTION ("Why buy from Dekho")
// ═════════════════════════════════════════════════════════════════════════════

class _TrustInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primarySurface,
            AppColors.primarySurface.withValues(alpha: 0.3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppRadius.lg,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.15),
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: AppRadius.sm,
                ),
                child: const Icon(
                  LucideIcons.sparkles,
                  size: 18,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Why shop with Dekho?',
                style: AppTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _TrustRow(
            icon: LucideIcons.shieldCheck,
            title: 'Verified Stores Only',
            subtitle: 'All prices from authorized retailers',
          ),
          const SizedBox(height: AppSpacing.sm),
          _TrustRow(
            icon: LucideIcons.trendingDown,
            title: 'Price History',
            subtitle: '90-day trends so you never overpay',
          ),
          const SizedBox(height: AppSpacing.sm),
          _TrustRow(
            icon: LucideIcons.bell,
            title: 'Price Drop Alerts',
            subtitle: 'Get notified when prices drop',
          ),
          const SizedBox(height: AppSpacing.sm),
          _TrustRow(
            icon: LucideIcons.zap,
            title: 'One-tap Redirect',
            subtitle: 'Buy directly from the retailer',
          ),
        ],
      ),
    );
  }
}

class _TrustRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _TrustRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.bodySmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
              Text(
                subtitle,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// SIMILAR PRODUCTS
// ═════════════════════════════════════════════════════════════════════════════

class _SimilarProductsSection extends ConsumerWidget {
  final String productId;

  const _SimilarProductsSection({required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final similarAsync = ref.watch(similarProductsProvider(productId));

    return similarAsync.when(
      loading: () => SizedBox(
        height: 275,
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 2,
          ),
        ),
      ),
      error: (_, __) => const SizedBox.shrink(),
      data: (products) {
        if (products.isEmpty) return const SizedBox.shrink();
        return SizedBox(
          height: 275,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: products.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: AppSpacing.md),
            itemBuilder: (context, index) {
              return SizedBox(
                width: 175,
                child: ProductCard(
                  product: products[index],
                  onTap: () {
                    context.push(
                      AppRoutes.productDetailPath(products[index].id),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// STICKY BOTTOM BAR
// ═════════════════════════════════════════════════════════════════════════════

class _StickyBottomBar extends StatelessWidget {
  final RetailerOffer bestOffer;
  final Product product;
  final VoidCallback onBuyNow;
  final VoidCallback onCompare;

  const _StickyBottomBar({
    required this.bestOffer,
    required this.product,
    required this.onBuyNow,
    required this.onCompare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, -6),
          ),
        ],
        border: const Border(
          top: BorderSide(color: AppColors.border),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        MediaQuery.of(context).padding.bottom + AppSpacing.md,
      ),
      child: Row(
        children: [
          // Total Best Price
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Best Price', style: AppTypography.caption),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Flexible(
                      child: Text(
                        CurrencyFormatter.format(bestOffer.price),
                        style: AppTypography.priceMedium.copyWith(
                          color: AppColors.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (bestOffer.discountPercentage != null) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.discountSurface,
                          borderRadius: AppRadius.xs,
                        ),
                        child: Text(
                          '${bestOffer.discountPercentage!.toStringAsFixed(0)}% off',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.discount,
                            fontWeight: FontWeight.w800,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),

          // Compare button
          OutlinedButton(
            onPressed: onCompare,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.border),
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.full,
              ),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 14,
              ),
            ),
            child: const Icon(
              LucideIcons.gitCompare,
              size: 18,
              color: AppColors.text,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),

          // Buy Now primary button
          Expanded(
            flex: 3,
            child: ElevatedButton(
              onPressed: onBuyNow,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.full,
                ),
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(LucideIcons.externalLink, size: 16),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      'Buy at ${bestOffer.retailer.displayName}',
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// ERROR & EMPTY STATES
// ═════════════════════════════════════════════════════════════════════════════

class _ProductErrorState extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _ProductErrorState({
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.errorSurface,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                LucideIcons.alertTriangle,
                size: 40,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Something went wrong',
              style: AppTypography.titleLarge.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'We couldn\'t load this product. Please try again.',
              style: AppTypography.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(LucideIcons.refreshCw, size: 16),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.full,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductNotFoundState extends StatelessWidget {
  final VoidCallback onGoBack;

  const _ProductNotFoundState({required this.onGoBack});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.warningSurface,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                LucideIcons.searchX,
                size: 40,
                color: AppColors.warning,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Product not found',
              style: AppTypography.titleLarge.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'This product may have been removed or is no longer available.',
              style: AppTypography.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton.icon(
              onPressed: onGoBack,
              icon: const Icon(LucideIcons.arrowLeft, size: 16),
              label: const Text('Go Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.full,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// CHART SHIMMER
// ═════════════════════════════════════════════════════════════════════════════

class _ChartShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lg,
        border: Border.all(color: AppColors.border),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
