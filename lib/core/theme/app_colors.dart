import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ─── Brand (Electric Indigo / Dekho Core) ─────────────────
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryDark = Color(0xFF4F46E5);
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primarySurface = Color(0xFFEEF2FF);
  static const Color primaryContainer = Color(0xFFE0E7FF);

  // ─── Secondary ───────────────────────────────────────────
  static const Color secondary = Color(0xFF0EA5E9);
  static const Color secondaryLight = Color(0xFF38BDF8);
  static const Color secondaryDark = Color(0xFF0284C7);
  static const Color secondaryContainer = Color(0xFFE0F2FE);

  // ─── Semantic: Status ────────────────────────────────────
  static const Color success = Color(0xFF198754);
  static const Color successLight = Color(0xFFBBF7D0);
  static const Color successSurface = Color(0xFFDCFCE7);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFDE68A);
  static const Color warningSurface = Color(0xFFFFFBEB);
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFECACA);
  static const Color errorSurface = Color(0xFFFEF2F2);
  static const Color info = Color(0xFF3B82F6);

  // ─── Semantic: Commerce ──────────────────────────────────
  static const Color discount = Color(0xFF198754);
  static const Color discountSurface = Color(0xFFDCFCE7);
  static const Color bestDeal = Color(0xFF7C3AED);
  static const Color bestDealLight = Color(0xFFA78BFA);
  static const Color bestDealSurface = Color(0xFFF5F3FF);
  static const Color priceDrop = Color(0xFF198754);
  static const Color priceDropSurface = Color(0xFFDCFCE7);

  // ─── Light Mode Surfaces (Dekho Stitch palette) ──────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF8F9FF);
  static const Color surfaceContainerLow = Color(0xFFEFF4FF);
  static const Color surfaceContainer = Color(0xFFE5EEFF);
  static const Color surfaceContainerHigh = Color(0xFFDCE9FF);
  static const Color card = Color(0xFFFFFFFF);
  static const Color text = Color(0xFF0B1C30);
  static const Color textSecondary = Color(0xFF434656);
  static const Color textTertiary = Color(0xFF747688);
  static const Color border = Color(0xFFE2E8F0);
  static const Color divider = Color(0xFFF1F5F9);
  static const Color disabled = Color(0xFFCBD5E1);

  // ─── Shimmer (Light) ─────────────────────────────────────
  static const Color shimmerBase = Color(0xFFE5EEFF);
  static const Color shimmerHighlight = Color(0xFFF8F9FF);

  // ─── Retailer Brand Colors ───────────────────────────────
  static const Color amazon = Color(0xFFFF9900);
  static const Color flipkart = Color(0xFF2874F0);
  static const Color croma = Color(0xFF00B060);
  static const Color myntra = Color(0xFFFF3F6C);
  static const Color reliance = Color(0xFF003B71);
  static const Color tataCliq = Color(0xFF9C1F61);

  // ─── Neutral Scale (Light) ───────────────────────────────
  static const Color neutral50 = Color(0xFFF8F9FF);
  static const Color neutral100 = Color(0xFFEFF4FF);
  static const Color neutral200 = Color(0xFFE2E8F0);
  static const Color neutral300 = Color(0xFFCBD5E1);
  static const Color neutral400 = Color(0xFF94A3B8);
  static const Color neutral500 = Color(0xFF64748B);
  static const Color neutral600 = Color(0xFF475569);
  static const Color neutral700 = Color(0xFF334155);
  static const Color neutral800 = Color(0xFF1E293B);
  static const Color neutral900 = Color(0xFF0B1C30);
}

/// Dark mode color palette.
/// Uses layered surfaces for OLED-friendly dark mode.
class AppColorsDark {
  AppColorsDark._();

  // ─── Surfaces (layered for depth) ────────────────────────
  static const Color background = Color(0xFF0A0A0F);
  static const Color surface = Color(0xFF121218);
  static const Color surfaceVariant = Color(0xFF1A1A24);
  static const Color card = Color(0xFF16161F);
  static const Color elevated = Color(0xFF1E1E2A);

  // ─── Text ────────────────────────────────────────────────
  static const Color text = Color(0xFFF1F5F9);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textTertiary = Color(0xFF64748B);

  // ─── Borders & Dividers ──────────────────────────────────
  static const Color border = Color(0xFF2A2A3A);
  static const Color divider = Color(0xFF1E1E2A);

  // ─── Shimmer (Dark) ──────────────────────────────────────
  static const Color shimmerBase = Color(0xFF1E1E2A);
  static const Color shimmerHighlight = Color(0xFF2A2A3A);

  // ─── Disabled ────────────────────────────────────────────
  static const Color disabled = Color(0xFF475569);

  // ─── Brand (slightly brighter for dark backgrounds) ──────
  static const Color primary = Color(0xFF5C7FFF);
  static const Color primaryContainer = Color(0xFF1E1B4B);
  static const Color primarySurface = Color(0xFF161B3A);
  static const Color secondary = Color(0xFF38BDF8);
  static const Color secondaryContainer = Color(0xFF0C4A6E);

  // ─── Semantic ────────────────────────────────────────────
  static const Color success = Color(0xFF4ADE80);
  static const Color successSurface = Color(0xFF052E16);
  static const Color warning = Color(0xFFFBBF24);
  static const Color warningSurface = Color(0xFF451A03);
  static const Color error = Color(0xFFF87171);
  static const Color errorSurface = Color(0xFF450A0A);
  static const Color discount = Color(0xFF4ADE80);
  static const Color discountSurface = Color(0xFF052E16);
  static const Color bestDeal = Color(0xFFA78BFA);
  static const Color bestDealSurface = Color(0xFF2E1065);

  // ─── Neutral ─────────────────────────────────────────────
  static const Color neutral50 = Color(0xFF0F0F18);
  static const Color neutral100 = Color(0xFF16161F);
  static const Color neutral200 = Color(0xFF1E1E2A);
  static const Color neutral300 = Color(0xFF2A2A3A);
  static const Color neutral400 = Color(0xFF475569);
  static const Color neutral500 = Color(0xFF64748B);
  static const Color neutral600 = Color(0xFF94A3B8);
  static const Color neutral700 = Color(0xFFCBD5E1);
  static const Color neutral800 = Color(0xFFE2E8F0);
  static const Color neutral900 = Color(0xFFF1F5F9);
}
