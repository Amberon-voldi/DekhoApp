import 'package:flutter/material.dart';
import 'package:dekho/core/theme/app_colors.dart';
import 'package:dekho/core/theme/app_spacing.dart';
import 'package:dekho/core/theme/app_radius.dart';
import 'package:dekho/core/theme/app_typography.dart';
import 'package:dekho/core/utils/formatters.dart';
import 'package:dekho/domain/models/price_history.dart';

class PriceHistoryChart extends StatelessWidget {
  final PriceHistorySummary summary;

  const PriceHistoryChart({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    final entries = summary.entries;
    final prices = entries.isNotEmpty
        ? entries.map((e) => e.price).toList()
        : [summary.currentPrice];

    final minPrice = summary.lowestPrice * 0.98;
    final maxPrice = summary.highestPrice * 1.02;

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price History',
                    style: AppTypography.titleLarge,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '90-day trend analysis',
                    style: AppTypography.bodySmall,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.successSurface,
                  borderRadius: AppRadius.full,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      summary.advice.label,
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
          const SizedBox(height: AppSpacing.lg),

          // Chart Canvas
          SizedBox(
            height: 160,
            child: Row(
              children: [
                // Y-Axis Labels
                SizedBox(
                  width: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        CurrencyFormatter.formatCompact(summary.highestPrice),
                        style: AppTypography.caption,
                      ),
                      Text(
                        CurrencyFormatter.formatCompact(summary.averagePrice),
                        style: AppTypography.caption,
                      ),
                      Text(
                        CurrencyFormatter.formatCompact(summary.lowestPrice),
                        style: AppTypography.caption,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),

                // Chart Area
                Expanded(
                  child: SizedBox(
                    height: 160,
                    child: CustomPaint(
                      painter: _PriceChartPainter(
                        prices: prices,
                        minPrice: minPrice,
                        maxPrice: maxPrice,
                        lineColor: AppColors.primary,
                        gradientStart: AppColors.primary.withValues(alpha: 0.25),
                        gradientEnd: AppColors.primary.withValues(alpha: 0.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xs),

          // X-Axis Labels
          Padding(
            padding: const EdgeInsets.only(left: 54),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('90d', style: AppTypography.caption),
                Text('60d', style: AppTypography.caption),
                Text('30d', style: AppTypography.caption),
                Text('Now', style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary)),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: AppSpacing.md),

          // Stats summary
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  label: 'Lowest Price',
                  value: CurrencyFormatter.format(summary.lowestPrice),
                  valueColor: AppColors.success,
                ),
              ),
              Container(width: 1, height: 32, color: AppColors.divider),
              Expanded(
                child: _StatTile(
                  label: 'Average Price',
                  value: CurrencyFormatter.format(summary.averagePrice),
                ),
              ),
              Container(width: 1, height: 32, color: AppColors.divider),
              Expanded(
                child: _StatTile(
                  label: 'Highest Price',
                  value: CurrencyFormatter.format(summary.highestPrice),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _StatTile({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label, style: AppTypography.caption),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppTypography.bodySmall.copyWith(
              fontWeight: FontWeight.w700,
              color: valueColor ?? AppColors.text,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _PriceChartPainter extends CustomPainter {
  final List<double> prices;
  final double minPrice;
  final double maxPrice;
  final Color lineColor;
  final Color gradientStart;
  final Color gradientEnd;

  _PriceChartPainter({
    required this.prices,
    required this.minPrice,
    required this.maxPrice,
    required this.lineColor,
    required this.gradientStart,
    required this.gradientEnd,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (prices.isEmpty) return;

    final priceRange = maxPrice - minPrice;
    if (priceRange <= 0) return;

    final points = <Offset>[];
    final stepX = prices.length > 1 ? size.width / (prices.length - 1) : 0.0;

    for (int i = 0; i < prices.length; i++) {
      final x = i * stepX;
      final normalizedY = (prices[i] - minPrice) / priceRange;
      final y = size.height - (normalizedY * (size.height - 16)) - 8;
      points.add(Offset(x, y));
    }

    // Draw grid lines
    final gridPaint = Paint()
      ..color = AppColors.neutral200.withValues(alpha: 0.6)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (double yRatio in [0.2, 0.5, 0.8]) {
      final y = size.height * yRatio;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Build smooth cubic path
    final linePath = Path();
    linePath.moveTo(points.first.dx, points.first.dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final controlPointX = (p0.dx + p1.dx) / 2;
      linePath.cubicTo(
        controlPointX, p0.dy,
        controlPointX, p1.dy,
        p1.dx, p1.dy,
      );
    }

    // Fill area under line with gradient
    final fillPath = Path.from(linePath)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [gradientStart, gradientEnd],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, fillPaint);

    // Draw main trend stroke
    final strokePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(linePath, strokePaint);

    // Draw active dot at the last point
    final lastPoint = points.last;
    final dotOuterPaint = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.fill;
    final dotInnerPaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(lastPoint, 6, dotOuterPaint);
    canvas.drawCircle(lastPoint, 4, dotInnerPaint);
  }

  @override
  bool shouldRepaint(covariant _PriceChartPainter oldDelegate) {
    return oldDelegate.prices != prices ||
        oldDelegate.minPrice != minPrice ||
        oldDelegate.maxPrice != maxPrice;
  }
}
