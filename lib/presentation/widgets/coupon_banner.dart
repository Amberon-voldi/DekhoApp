import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:dekho/core/theme/app_colors.dart';
import 'package:dekho/core/theme/app_spacing.dart';
import 'package:dekho/core/theme/app_radius.dart';
import 'package:dekho/core/theme/app_typography.dart';
import 'package:dekho/core/theme/app_motion.dart';
import 'package:dekho/core/theme/app_shadows.dart';

class CouponBanner extends StatefulWidget {
  final String code;
  final String title;
  final String description;

  const CouponBanner({
    super.key,
    this.code = 'DEKHO10',
    this.title = 'Extra 10% Off on Electronics',
    this.description = 'Use code: DEKHO10 at checkout',
  });

  @override
  State<CouponBanner> createState() => _CouponBannerState();
}

class _CouponBannerState extends State<CouponBanner>
    with SingleTickerProviderStateMixin {
  bool _copied = false;
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppMotion.fast,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: AppMotion.microInteraction),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.code));
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppRadius.lg,
        gradient: const LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primaryDark,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: AppShadows.elevated,
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Stack(
        children: [
          // Background decorative glow
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white.withValues(alpha: 0.1),
              ),
            ),
          ),

          Row(
            children: [
              // Ticket Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  LucideIcons.ticket,
                  color: AppColors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              // Title & Description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: AppTypography.titleMedium.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.description,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),

              // Copy Code Pill Button
              GestureDetector(
                onTapDown: (_) => _controller.forward(),
                onTapUp: (_) {
                  _controller.reverse();
                  _copy();
                },
                onTapCancel: () => _controller.reverse(),
                child: AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) => Transform.scale(
                    scale: _scaleAnimation.value,
                    child: child,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: AppRadius.full,
                    ),
                    child: AnimatedSwitcher(
                      duration: AppMotion.fast,
                      child: _copied
                          ? Row(
                              key: const ValueKey('copied'),
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  LucideIcons.check,
                                  size: 14,
                                  color: AppColors.success,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Copied',
                                  style: AppTypography.labelMedium.copyWith(
                                    color: AppColors.success,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              'Copy Code',
                              key: const ValueKey('copy'),
                              style: AppTypography.labelMedium.copyWith(
                                color: AppColors.primaryDark,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
