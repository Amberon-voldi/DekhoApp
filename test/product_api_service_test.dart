import 'package:flutter_test/flutter_test.dart';
import 'package:dekho/data/network/product_api_service.dart';
import 'package:dekho/data/network/retailer_pricing_engine.dart';
import 'package:dekho/domain/models/models.dart';

void main() {
  group('RetailerPricingEngine', () {
    final engine = RetailerPricingEngine();

    test('generates valid Amazon and Flipkart offers with valid deep URLs', () {
      final offers = engine.generateRetailerOffers(
        basePrice: 50000.0,
        productName: 'iPhone 15',
        brand: 'Apple',
      );

      expect(offers.length, equals(4));

      final amazonOffer =
          offers.firstWhere((o) => o.retailer == Retailer.amazon);
      final flipkartOffer =
          offers.firstWhere((o) => o.retailer == Retailer.flipkart);

      expect(amazonOffer.url, contains('amazon.in'));
      expect(amazonOffer.url, contains('Apple'));
      expect(flipkartOffer.url, contains('flipkart.com'));
      expect(flipkartOffer.url, contains('Apple'));

      // Best deal should be first
      expect(offers.first.price, lessThanOrEqualTo(offers.last.price));
    });
  });

  group('ProductApiService', () {
    final service = ProductApiService();

    test('fetches live products and blends with seed products', () async {
      final products = await service.fetchProducts(limit: 10);
      expect(products, isNotEmpty);

      final first = products.first;
      expect(first.name, isNotEmpty);
      expect(first.offers, isNotEmpty);
      expect(first.bestOffer.url, isNotEmpty);
    });

    test('searches products with real query and multi-word phrases', () async {
      final resultsPhone = await service.searchProducts('phone');
      expect(resultsPhone, isNotEmpty);

      final resultsNike = await service.searchProducts('Nike Air');
      expect(resultsNike, isNotEmpty);
      expect(
        resultsNike.any((p) =>
            p.brand.toLowerCase().contains('nike') ||
            p.name.toLowerCase().contains('nike') ||
            p.name.toLowerCase().contains('air')),
        isTrue,
      );

      final resultsIPhone16 = await service.searchProducts('iPhone 16');
      expect(resultsIPhone16, isNotEmpty);

      final resultsSony = await service.searchProducts('Sony WH-1000XM5');
      expect(resultsSony, isNotEmpty);
      expect(resultsSony.any((p) => p.brand.toLowerCase() == 'sony'), isTrue);
    });
  });
}
