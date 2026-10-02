import 'package:flutter/material.dart';
import 'package:dekho/core/theme/app_colors.dart';

enum Retailer {
  amazon,
  flipkart,
  croma,
  myntra,
  reliance,
  tataCliq;

  String get displayName {
    switch (this) {
      case Retailer.amazon: return 'Amazon';
      case Retailer.flipkart: return 'Flipkart';
      case Retailer.croma: return 'Croma';
      case Retailer.myntra: return 'Myntra';
      case Retailer.reliance: return 'Reliance Digital';
      case Retailer.tataCliq: return 'Tata CLiQ';
    }
  }

  Color get brandColor {
    switch (this) {
      case Retailer.amazon: return AppColors.amazon;
      case Retailer.flipkart: return AppColors.flipkart;
      case Retailer.croma: return AppColors.croma;
      case Retailer.myntra: return AppColors.myntra;
      case Retailer.reliance: return AppColors.reliance;
      case Retailer.tataCliq: return AppColors.tataCliq;
    }
  }
}
