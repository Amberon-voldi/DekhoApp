import 'dart:math';
import 'package:dekho/domain/models/price_history.dart';
import 'package:dekho/domain/models/retailer.dart';

/// Generates realistic price history entries for a product.
/// Uses a random walk around a base price to simulate real pricing patterns.
List<PriceHistoryEntry> generatePriceHistory({
  required double basePrice,
  required Retailer retailer,
  int months = 6,
  double volatility = 0.08,
}) {
  final random = Random(basePrice.toInt());
  final entries = <PriceHistoryEntry>[];
  final now = DateTime.now();

  double currentPrice = basePrice * (1 + (random.nextDouble() * 0.1));

  for (int i = months * 30; i >= 0; i -= 3) {
    final date = now.subtract(Duration(days: i));
    // Random walk with mean-reversion toward base price
    final drift = (basePrice - currentPrice) * 0.05;
    final shock = (random.nextDouble() - 0.5) * 2 * volatility * basePrice;
    currentPrice = max(basePrice * 0.85, min(basePrice * 1.2, currentPrice + drift + shock));

    entries.add(PriceHistoryEntry(
      date: date,
      price: (currentPrice / 100).roundToDouble() * 100,
      retailer: retailer,
    ));
  }

  return entries;
}

PriceHistorySummary createPriceHistorySummary({
  required double currentPrice,
  required List<PriceHistoryEntry> entries,
}) {
  if (entries.isEmpty) {
    return PriceHistorySummary(
      currentPrice: currentPrice,
      lowestPrice: currentPrice,
      averagePrice: currentPrice,
      highestPrice: currentPrice,
      entries: entries,
    );
  }

  final prices = entries.map((e) => e.price).toList();
  final lowest = prices.reduce(min);
  final highest = prices.reduce(max);
  final average = prices.reduce((a, b) => a + b) / prices.length;

  return PriceHistorySummary(
    currentPrice: currentPrice,
    lowestPrice: lowest,
    averagePrice: (average / 100).roundToDouble() * 100,
    highestPrice: highest,
    entries: entries,
  );
}
