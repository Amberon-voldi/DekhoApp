import 'package:flutter/material.dart';
import 'package:dekho/core/theme/app_colors.dart';
import 'package:dekho/core/theme/app_spacing.dart';
import 'package:dekho/core/theme/app_radius.dart';

/// A custom shimmer effect that paints a sliding gradient over its child
/// using CustomPaint. This avoids the `!semantics.parentDataDirty` assertion
/// because it does NOT wrap children in new render objects (like ShaderMask
/// does). Instead it paints a gradient overlay in the foreground.
class _ShimmerPainter extends CustomPainter {
  final double progress;
  final Color baseColor;
  final Color highlightColor;

  _ShimmerPainter({
    required this.progress,
    required this.baseColor,
    required this.highlightColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..blendMode = BlendMode.srcATop
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.centerRight,
        colors: [baseColor, highlightColor, baseColor],
        stops: const [0.0, 0.5, 1.0],
        transform: _SlidingGradientTransform(slidePercent: progress),
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(_ShimmerPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlidingGradientTransform({required this.slidePercent});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(
        bounds.width * (slidePercent * 2 - 1), 0, 0);
  }
}

class _ShimmerEffect extends StatefulWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;

  const _ShimmerEffect({
    required this.child,
    required this.baseColor,
    required this.highlightColor,
  });

  @override
  State<_ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<_ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          foregroundPainter: _ShimmerPainter(
            progress: _controller.value,
            baseColor: widget.baseColor,
            highlightColor: widget.highlightColor,
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  final Widget child;

  const ShimmerLoading._({required this.child});

  factory ShimmerLoading.productCard() {
    return ShimmerLoading._(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: AppRadius.md,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 125,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: AppRadius.md,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 50, height: 10, color: AppColors.white),
                  const SizedBox(height: 4),
                  Container(
                      width: double.infinity,
                      height: 12,
                      color: AppColors.white),
                  const SizedBox(height: 4),
                  Container(width: 80, height: 12, color: AppColors.white),
                  const SizedBox(height: 6),
                  Container(width: 65, height: 16, color: AppColors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  factory ShimmerLoading.productList({int count = 6}) {
    return ShimmerLoading._(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.68,
          mainAxisSpacing: AppSpacing.md,
          crossAxisSpacing: AppSpacing.md,
        ),
        itemCount: count,
        itemBuilder: (context, index) => ShimmerLoading.productCard().child,
      ),
    );
  }

  factory ShimmerLoading.productDetail() {
    return ShimmerLoading._(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            width: double.infinity,
            color: AppColors.white,
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 80, height: 14, color: AppColors.white),
                const SizedBox(height: AppSpacing.sm),
                Container(
                    width: double.infinity,
                    height: 24,
                    color: AppColors.white),
                const SizedBox(height: AppSpacing.xs),
                Container(width: 150, height: 24, color: AppColors.white),
                const SizedBox(height: AppSpacing.md),
                Container(width: 120, height: 32, color: AppColors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _ShimmerEffect(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: child,
    );
  }
}
