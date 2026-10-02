import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:dekho/core/theme/app_colors.dart';
import 'package:dekho/core/theme/app_spacing.dart';
import 'package:dekho/core/theme/app_radius.dart';
import 'package:dekho/core/theme/app_typography.dart';
import 'package:dekho/core/theme/app_motion.dart';
import 'package:dekho/domain/models/coupon.dart';

/// A ticket-style coupon card with dashed border, retailer branding,
/// and an animated copy-code interaction.
class CouponCard extends StatefulWidget {
  final Coupon coupon;
  final VoidCallback? onCopy;

  const CouponCard({
    super.key,
    required this.coupon,
    this.onCopy,
  });

  @override
  State<CouponCard> createState() => _CouponCardState();
}

class _CouponCardState extends State<CouponCard>
    with SingleTickerProviderStateMixin {
  bool _copied = false;
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppMotion.fast,
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: AppMotion.microInteraction),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _copyCode() async {
    await Clipboard.setData(ClipboardData(text: widget.coupon.code));
    setState(() => _copied = true);
    widget.onCopy?.call();
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    final coupon = widget.coupon;

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        _copyCode();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnim,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnim.value,
          child: child,
        ),
        child: Container(
          width: 260,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.md,
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top colored accent bar
              Container(
                height: 4,
                decoration: BoxDecoration(
                  color: coupon.retailer.brandColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.sm,
                  AppSpacing.md,
                  AppSpacing.md,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            coupon.title,
                            style: AppTypography.titleLarge.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: coupon.retailer.brandColor
                                .withValues(alpha: 0.1),
                            borderRadius: AppRadius.xs,
                          ),
                          child: Text(
                            coupon.retailer.displayName,
                            style: AppTypography.labelMedium.copyWith(
                              color: coupon.retailer.brandColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      coupon.description,
                      style: AppTypography.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // Dashed divider
                    Row(
                      children: List.generate(
                        30,
                        (i) => Expanded(
                          child: Container(
                            height: 1,
                            color: i.isEven ? AppColors.border : Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // Code + Copy button
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.neutral50,
                            borderRadius: AppRadius.sm,
                            border: Border.all(
                              color: AppColors.border,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Text(
                            coupon.code,
                            style: AppTypography.labelLarge.copyWith(
                              color: AppColors.text,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const Spacer(),
                        AnimatedSwitcher(
                          duration: AppMotion.fast,
                          child: _copied
                              ? Row(
                                  key: const ValueKey('copied'),
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      LucideIcons.check,
                                      size: 16,
                                      color: AppColors.success,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Copied',
                                      style: AppTypography.labelMedium.copyWith(
                                        color: AppColors.success,
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  key: const ValueKey('copy'),
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      LucideIcons.copy,
                                      size: 16,
                                      color: AppColors.primary,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Copy',
                                      style: AppTypography.labelMedium.copyWith(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
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
