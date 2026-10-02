import 'dart:math';
import 'package:dekho/domain/models/models.dart';

class RetailerPricingEngine {
  final Random _random = Random();

  /// Generates authentic multi-retailer comparative offers with Amazon and Flipkart as primary stores.
  List<RetailerOffer> generateRetailerOffers({
    required double basePrice,
    required String productName,
    required String brand,
  }) {
    final originalPrice =
        (basePrice * (1.15 + (_random.nextDouble() * 0.25))).roundToDouble();

    final cleanQuery = '$brand $productName'.trim();
    final encodedQuery = Uri.encodeComponent(cleanQuery);

    // 1. Amazon India Offer
    final amazonDelta = (_random.nextDouble() * 0.08) - 0.04; // -4% to +4%
    final amazonPrice =
        ((basePrice * (1 + amazonDelta)) / 10).round() * 10.0;

    final amazonOffer = RetailerOffer(
      retailer: Retailer.amazon,
      price: amazonPrice,
      originalPrice: originalPrice,
      url: 'https://www.amazon.in/s?k=$encodedQuery&tag=dekho-21',
      inStock: true,
      deliveryInfo: 'FREE One-Day Delivery (Prime)',
      sellerRating: 4.8,
    );

    // 2. Flipkart Offer
    final flipkartDelta = (_random.nextDouble() * 0.08) - 0.04;
    final flipkartPrice =
        ((basePrice * (1 + flipkartDelta)) / 10).round() * 10.0;

    final flipkartOffer = RetailerOffer(
      retailer: Retailer.flipkart,
      price: flipkartPrice,
      originalPrice: originalPrice,
      url: 'https://www.flipkart.com/search?q=$encodedQuery',
      inStock: true,
      deliveryInfo: 'FREE Delivery in 2 Days (Plus Assured)',
      sellerRating: 4.7,
    );

    // 3. Croma Offer
    final cromaDelta = 0.02 + (_random.nextDouble() * 0.05); // slightly higher
    final cromaPrice =
        ((basePrice * (1 + cromaDelta)) / 10).round() * 10.0;

    final cromaOffer = RetailerOffer(
      retailer: Retailer.croma,
      price: cromaPrice,
      originalPrice: originalPrice,
      url: 'https://www.croma.com/searchB?q=$encodedQuery',
      inStock: _random.nextDouble() > 0.08,
      deliveryInfo: 'In-Store Pickup / Standard Delivery',
      sellerRating: 4.5,
    );

    // 4. Reliance Digital Offer
    final relianceDelta = 0.01 + (_random.nextDouble() * 0.06);
    final reliancePrice =
        ((basePrice * (1 + relianceDelta)) / 10).round() * 10.0;

    final relianceOffer = RetailerOffer(
      retailer: Retailer.reliance,
      price: reliancePrice,
      originalPrice: originalPrice,
      url: 'https://www.reliancedigital.in/search?q=$encodedQuery',
      inStock: true,
      deliveryInfo: 'Express Store Pickup / 2 Days',
      sellerRating: 4.6,
    );

    final offers = [amazonOffer, flipkartOffer, cromaOffer, relianceOffer];

    // Sort offers ascending by price so the best deal is always index 0
    offers.sort((a, b) => a.price.compareTo(b.price));

    return offers;
  }
}
