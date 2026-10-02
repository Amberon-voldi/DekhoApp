import 'retailer.dart';

class Coupon {
  final String id;
  final String code;
  final String title;
  final String description;
  final double discountAmount;
  final bool isPercentage;
  final double? minOrderAmount;
  final Retailer retailer;
  final DateTime? expiresAt;
  final List<String> applicableProductIds;

  const Coupon({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.discountAmount,
    this.isPercentage = false,
    this.minOrderAmount,
    required this.retailer,
    this.expiresAt,
    this.applicableProductIds = const [],
  });

  String get formattedDiscount {
    if (isPercentage) return '${discountAmount.toStringAsFixed(0)}% OFF';
    return '₹${discountAmount.toStringAsFixed(0)} OFF';
  }

  bool get isExpired => expiresAt != null && expiresAt!.isBefore(DateTime.now());
  bool get isUniversal => applicableProductIds.isEmpty;
}
