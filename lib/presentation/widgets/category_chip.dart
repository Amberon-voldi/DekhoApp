import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dekho/core/theme/app_colors.dart';
import 'package:dekho/core/theme/app_spacing.dart';
import 'package:dekho/core/theme/app_typography.dart';
import 'package:dekho/core/theme/app_motion.dart';
import 'package:dekho/domain/models/category.dart';

class CategoryChip extends StatefulWidget {
  final Category category;
  final VoidCallback? onTap;
  final bool isSelected;

  const CategoryChip({
    super.key,
    required this.category,
    this.onTap,
    this.isSelected = false,
  });

  @override
  State<CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<CategoryChip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppMotion.fast,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.94).animate(
      CurvedAnimation(parent: _controller, curve: AppMotion.microInteraction),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.isSelected;
    final category = widget.category;

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 66,
              height: 66,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.surfaceContainerLow,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.border,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipOval(
                child: category.imageUrl != null && category.imageUrl!.isNotEmpty
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          CachedNetworkImage(
                            imageUrl: category.imageUrl!,
                            fit: BoxFit.cover,
                            fadeInDuration: AppMotion.fast,
                            placeholder: (context, url) => Container(
                              color: AppColors.surfaceContainerLow,
                              child: Icon(
                                category.icon,
                                color: AppColors.primary,
                                size: 24,
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: AppColors.surfaceContainerLow,
                              child: Icon(
                                category.icon,
                                color: AppColors.primary,
                                size: 24,
                              ),
                            ),
                          ),
                          // Subtle dark tint to ensure high contrast and sleek finish
                          Container(
                            color: isSelected
                                ? AppColors.primary.withValues(alpha: 0.5)
                                : AppColors.black.withValues(alpha: 0.15),
                          ),
                        ],
                      )
                    : Icon(
                        category.icon,
                        color: isSelected ? AppColors.white : AppColors.primary,
                        size: 26,
                      ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              category.name,
              style: AppTypography.labelMedium.copyWith(
                color: isSelected ? AppColors.primary : AppColors.text,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
