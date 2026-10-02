import 'retailer.dart';

class RetailerOffer {
  final Retailer retailer;
  final double price;
  final double? originalPrice;
  final String deliveryInfo;
  final bool inStock;
  final double? sellerRating;
  final String url;

  const RetailerOffer({
    required this.retailer,
    required this.price,
    this.originalPrice,
    required this.deliveryInfo,
    this.inStock = true,
    this.sellerRating,
    this.url = '',
  });

  double? get discountPercentage {
    if (originalPrice == null || originalPrice! <= price) return null;
    return ((originalPrice! - price) / originalPrice! * 100);
  }

  double get savings => (originalPrice ?? price) - price;
}
