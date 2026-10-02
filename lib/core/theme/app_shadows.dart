import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppShadows {
  AppShadows._();
  static List<BoxShadow> get subtle => [
    BoxShadow(
      color: AppColors.black.withValues(alpha: 0.04),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];
  static List<BoxShadow> get card => [
    BoxShadow(
      color: AppColors.black.withValues(alpha: 0.06),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];
  static List<BoxShadow> get elevated => [
    BoxShadow(
      color: AppColors.black.withValues(alpha: 0.08),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];
  static List<BoxShadow> get modal => [
    BoxShadow(
      color: AppColors.black.withValues(alpha: 0.16),
      blurRadius: 48,
      offset: const Offset(0, 16),
    ),
  ];
}
