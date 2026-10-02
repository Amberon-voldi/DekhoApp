import 'dart:math';
import 'retailer_offer.dart';

class Product {
  final String id;
  final String name;
  final String brand;
  final String variant;
  final String description;
  final List<String> images;
  final String categoryId;
  final double rating;
  final int reviewCount;
  final Map<String, String> specifications;
  final List<RetailerOffer> offers;

  const Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.variant,
    required this.description,
    required this.images,
    required this.categoryId,
    required this.rating,
    required this.reviewCount,
    this.specifications = const {},
    required this.offers,
  });

  double get bestPrice => offers.map((o) => o.price).reduce(min);
  double get highestPrice => offers.map((o) => o.price).reduce(max);
  RetailerOffer get bestOffer => offers.reduce((a, b) => a.price <= b.price ? a : b);
  double? get bestOriginalPrice => bestOffer.originalPrice;
  double? get discountPercentage => bestOffer.discountPercentage;
  int get storeCount => offers.length;
  double get priceDifference => highestPrice - bestPrice;
}
