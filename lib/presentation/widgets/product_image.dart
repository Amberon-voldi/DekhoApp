import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:dekho/core/theme/app_colors.dart';
import 'package:dekho/core/theme/app_radius.dart';
import 'package:dekho/core/theme/app_motion.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final String? fallbackBrand;

  const ProductImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.borderRadius,
    this.fallbackBrand,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? AppRadius.md;

    return ClipRRect(
      borderRadius: radius,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        fadeInDuration: AppMotion.standard,
        placeholder: (context, url) => RepaintBoundary(
          child: _PulsingPlaceholder(width: width, height: height),
        ),
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          color: AppColors.neutral100,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                LucideIcons.image,
                size: 28,
                color: AppColors.neutral400,
              ),
              if (fallbackBrand != null && fallbackBrand!.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  fallbackBrand!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.neutral500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Lightweight pulsing placeholder that replaces `Shimmer.fromColors`
/// to avoid the Flutter Web mouse_tracker assertion bug.
class _PulsingPlaceholder extends StatefulWidget {
  final double? width;
  final double? height;

  const _PulsingPlaceholder({this.width, this.height});

  @override
  State<_PulsingPlaceholder> createState() => _PulsingPlaceholderState();
}

class _PulsingPlaceholderState extends State<_PulsingPlaceholder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _opacity = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Container(
        width: widget.width,
        height: widget.height,
        color: AppColors.shimmerBase,
      ),
    );
  }
}
