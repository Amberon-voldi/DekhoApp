import 'retailer.dart';

class PriceHistoryEntry {
  final DateTime date;
  final double price;
  final Retailer retailer;

  const PriceHistoryEntry({
    required this.date,
    required this.price,
    required this.retailer,
  });
}

enum PriceAdvice {
  nearLowest,
  belowAverage,
  aboveAverage,
  considerWaiting,
  atHighest;

  String get label {
    switch (this) {
      case PriceAdvice.nearLowest:
        return 'Near lowest price';
      case PriceAdvice.belowAverage:
        return 'Below average price';
      case PriceAdvice.aboveAverage:
        return 'Above average price';
      case PriceAdvice.considerWaiting:
        return 'Consider waiting';
      case PriceAdvice.atHighest:
        return 'At highest price';
    }
  }

  String get emoji {
    switch (this) {
      case PriceAdvice.nearLowest:
        return '🟢';
      case PriceAdvice.belowAverage:
        return '🟢';
      case PriceAdvice.aboveAverage:
        return '🟡';
      case PriceAdvice.considerWaiting:
        return '🟡';
      case PriceAdvice.atHighest:
        return '🔴';
    }
  }
}

class PriceHistorySummary {
  final double currentPrice;
  final double lowestPrice;
  final double averagePrice;
  final double highestPrice;
  final List<PriceHistoryEntry> entries;

  const PriceHistorySummary({
    required this.currentPrice,
    required this.lowestPrice,
    required this.averagePrice,
    required this.highestPrice,
    required this.entries,
  });

  PriceAdvice get advice {
    final range = highestPrice - lowestPrice;
    if (range == 0) return PriceAdvice.nearLowest;

    final position = (currentPrice - lowestPrice) / range;
    if (position <= 0.15) return PriceAdvice.nearLowest;
    if (position <= 0.40) return PriceAdvice.belowAverage;
    if (position <= 0.65) return PriceAdvice.aboveAverage;
    if (position <= 0.85) return PriceAdvice.considerWaiting;
    return PriceAdvice.atHighest;
  }
}
