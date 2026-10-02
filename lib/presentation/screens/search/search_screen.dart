import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:dekho/core/theme/theme.dart';
import 'package:dekho/core/routing/routes.dart';
import 'package:dekho/core/providers/providers.dart';
import 'package:dekho/core/utils/formatters.dart';
import 'package:dekho/domain/models/models.dart';
import 'package:dekho/presentation/widgets/search_bar_widget.dart';
import 'package:dekho/presentation/widgets/section_header.dart';
import 'package:dekho/presentation/widgets/animated_list_item.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _controller;
  String _query = '';
  Timer? _debounceTimer;
  List<Product> _liveResults = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onQueryChanged(String query) {
    setState(() {
      _query = query;
    });

    _debounceTimer?.cancel();
    if (query.trim().isEmpty) {
      setState(() {
        _liveResults = [];
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _debounceTimer = Timer(const Duration(milliseconds: 250), () async {
      if (!mounted) return;
      try {
        final repository = ref.read(productRepositoryProvider);
        final results = await repository.searchProducts(query.trim());
        if (mounted && _query == query) {
          setState(() {
            _liveResults = results;
            _isLoading = false;
          });
        }
      } catch (_) {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    });

    ref.read(searchQueryProvider.notifier).set(query);
  }

  void _onSearch(String query) async {
    if (query.trim().isEmpty) return;

    await ref.read(searchRepositoryProvider).addRecentSearch(query.trim());
    ref.invalidate(recentSearchesProvider);

    if (mounted) {
      context.push(
        '${AppRoutes.searchResults}?q=${Uri.encodeComponent(query.trim())}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppColors.text),
          onPressed: () => context.pop(),
        ),
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: AppSpacing.md),
          child: DekhoSearchBar(
            autofocus: true,
            initialQuery: _query,
            onChanged: _onQueryChanged,
            onSubmitted: _onSearch,
            onClear: () {
              _controller.clear();
              _onQueryChanged('');
            },
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: AppMotion.fast,
        child: _query.trim().isEmpty
            ? _buildEmptyState()
            : _buildLiveSearchResults(),
      ),
    );
  }

  Widget _buildEmptyState() {
    final recentSearches = ref.watch(recentSearchesProvider);
    final trendingSearches = ref.watch(trendingSearchesProvider);

    return SingleChildScrollView(
      key: const ValueKey('empty_state'),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          recentSearches.when(
            data: (searches) {
              if (searches.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(
                    title: 'Recent Searches',
                    actionLabel: 'Clear All',
                    onAction: () async {
                      await ref
                          .read(searchRepositoryProvider)
                          .clearRecentSearches();
                      ref.invalidate(recentSearchesProvider);
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: searches.map((search) {
                      return ActionChip(
                        label: Text(search, style: AppTypography.bodySmall),
                        backgroundColor: AppColors.surface,
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: AppRadius.full,
                        ),
                        onPressed: () {
                          _controller.text = search;
                          _onSearch(search);
                        },
                        avatar: const Icon(
                          LucideIcons.history,
                          size: AppIconSizes.sm,
                          color: AppColors.textTertiary,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                ],
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          trendingSearches.when(
            data: (trends) {
              if (trends.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(title: 'Trending Searches 🔥'),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: trends.map((trend) {
                      return ActionChip(
                        label: Text(
                          trend,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.primaryDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        backgroundColor: AppColors.primarySurface,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppRadius.full,
                        ),
                        avatar: const Icon(
                          LucideIcons.trendingUp,
                          size: AppIconSizes.sm,
                          color: AppColors.primary,
                        ),
                        onPressed: () {
                          _controller.text = trend;
                          _onSearch(trend);
                        },
                      );
                    }).toList(),
                  ),
                ],
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveSearchResults() {
    if (_isLoading && _liveResults.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: AppColors.primary,
              strokeWidth: 2.5,
            ),
            SizedBox(height: AppSpacing.md),
            Text(
              'Searching across Amazon & Flipkart...',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
      );
    }

    if (_liveResults.isEmpty && !_isLoading) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                LucideIcons.searchX,
                size: 56,
                color: AppColors.textTertiary,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'No products found for "$_query"',
                style: AppTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Try searching for brand names, gadgets, or general categories.',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      key: const ValueKey('live_results'),
      itemCount: _liveResults.length + 1,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.xs,
              AppSpacing.md,
              AppSpacing.sm,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_liveResults.length} Live Matches',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                GestureDetector(
                  onTap: () => _onSearch(_query),
                  child: Row(
                    children: [
                      Text(
                        'View Grid',
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        LucideIcons.arrowRight,
                        size: 14,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        final product = _liveResults[index - 1];
        final bestOffer = product.bestOffer;

        return AnimatedListItem(
          index: index,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                _onSearch(_query);
                context.push(AppRoutes.productDetailPath(product.id));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.border, width: 0.5),
                  ),
                ),
                child: Row(
                  children: [
                    // Product Thumbnail
                    ClipRRect(
                      borderRadius: AppRadius.sm,
                      child: Container(
                        width: 58,
                        height: 58,
                        color: AppColors.surfaceContainerLow,
                        child: product.images.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: product.images.first,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  color: AppColors.surfaceContainerLow,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  LucideIcons.image,
                                  color: AppColors.textTertiary,
                                ),
                              )
                            : const Icon(
                                LucideIcons.image,
                                color: AppColors.textTertiary,
                              ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),

                    // Product Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: AppTypography.titleMedium.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: bestOffer.retailer.brandColor
                                      .withValues(alpha: 0.12),
                                  borderRadius: AppRadius.xs,
                                ),
                                child: Text(
                                  bestOffer.retailer.displayName,
                                  style: AppTypography.caption.copyWith(
                                    color: bestOffer.retailer.brandColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              if (product.offers.length > 1)
                                Text(
                                  '${product.offers.length} stores',
                                  style: AppTypography.caption.copyWith(
                                    color: AppColors.textTertiary,
                                    fontSize: 11,
                                  ),
                                ),
                              const Spacer(),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    size: 14,
                                    color: AppColors.warning,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    product.rating.toStringAsFixed(1),
                                    style: AppTypography.caption.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),

                    // Price info
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          CurrencyFormatter.format(bestOffer.price),
                          style: AppTypography.priceMedium.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                        if (bestOffer.originalPrice != null)
                          Text(
                            CurrencyFormatter.format(bestOffer.originalPrice!),
                            style: AppTypography.caption.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: AppColors.textTertiary,
                              fontSize: 11,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
