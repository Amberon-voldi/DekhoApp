import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dekho/core/theme/app_colors.dart';
import 'package:dekho/core/theme/app_spacing.dart';
import 'package:dekho/core/theme/app_radius.dart';
import 'package:dekho/core/theme/app_typography.dart';
import 'package:dekho/core/theme/app_shadows.dart';
import 'package:dekho/core/theme/app_motion.dart';
import 'package:dekho/core/routing/routes.dart';
import 'package:dekho/domain/models/category.dart';

class CategoryBannerCarousel extends StatefulWidget {
  final List<Category> categories;

  const CategoryBannerCarousel({
    super.key,
    required this.categories,
  });

  @override
  State<CategoryBannerCarousel> createState() => _CategoryBannerCarouselState();
}

class _CategoryBannerCarouselState extends State<CategoryBannerCarousel> {
  late final PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92);
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients && widget.categories.isNotEmpty) {
        final nextPage = (_currentPage + 1) % widget.categories.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.categories.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemCount: widget.categories.length,
            itemBuilder: (context, index) {
              final category = widget.categories[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: _CategoryBannerCard(category: category),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.categories.length,
            (index) => AnimatedContainer(
              duration: AppMotion.fast,
              width: _currentPage == index ? 22 : 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                borderRadius: AppRadius.full,
                color: _currentPage == index
                    ? AppColors.primary
                    : AppColors.neutral300,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CategoryBannerCard extends StatelessWidget {
  final Category category;

  const _CategoryBannerCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          '${AppRoutes.searchResults}?q=${Uri.encodeComponent(category.name)}',
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppRadius.lg,
          boxShadow: AppShadows.card,
        ),
        child: ClipRRect(
          borderRadius: AppRadius.lg,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Banner Photo
              if (category.bannerImageUrl != null &&
                  category.bannerImageUrl!.isNotEmpty)
                CachedNetworkImage(
                  imageUrl: category.bannerImageUrl!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: AppColors.surfaceContainerLow,
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.primaryDark,
                  ),
                )
              else
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primaryDark, AppColors.primary],
                    ),
                  ),
                ),

              // Gradient Overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColors.black.withValues(alpha: 0.85),
                      AppColors.black.withValues(alpha: 0.35),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              // Text and CTA info
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: AppRadius.xs,
                      ),
                      child: Text(
                        category.name.toUpperCase(),
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.0,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      category.tagline ?? 'Discover Top Deals',
                      style: AppTypography.titleLarge.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                        fontSize: 17,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Text(
                          'Explore Category',
                          style: AppTypography.labelMedium.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.white,
                          size: 14,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
