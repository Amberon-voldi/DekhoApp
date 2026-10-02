import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static String get _fontFamily => GoogleFonts.plusJakartaSans().fontFamily!;

  // ─── Display ─────────────────────────────────────────────
  static TextStyle get displayLarge => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: AppColors.text,
    height: 1.15,
    letterSpacing: -0.5,
  );

  static TextStyle get displayMedium => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.text,
    height: 1.2,
    letterSpacing: -0.3,
  );

  // ─── Headline ────────────────────────────────────────────
  static TextStyle get headlineLarge => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
    height: 1.25,
    letterSpacing: -0.2,
  );

  static TextStyle get headlineMedium => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
    height: 1.3,
  );

  // ─── Title ───────────────────────────────────────────────
  static TextStyle get titleLarge => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
    height: 1.35,
  );

  static TextStyle get titleMedium => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
    height: 1.4,
  );

  // ─── Body ────────────────────────────────────────────────
  static TextStyle get bodyLarge => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
    height: 1.5,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
    height: 1.5,
  );

  static TextStyle get bodySmall => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  // ─── Label ───────────────────────────────────────────────
  static TextStyle get labelLarge => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    height: 1.2,
    letterSpacing: 0.5,
  );

  static TextStyle get labelMedium => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    height: 1.2,
    letterSpacing: 0.8,
  );

  // ─── Price (strong visual hierarchy) ─────────────────────
  static TextStyle get priceLarge => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.text,
    height: 1.2,
    letterSpacing: -0.3,
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  static TextStyle get priceMedium => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
    height: 1.3,
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  static TextStyle get priceSmall => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
    height: 1.3,
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  // ─── Caption ─────────────────────────────────────────────
  static TextStyle get caption => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    height: 1.4,
  );

  // ═══ Backward-compat aliases (remove once migration is complete) ═══
  static TextStyle get display => displayMedium;
  static TextStyle get h1 => headlineLarge;
  static TextStyle get h2 => headlineMedium;
  static TextStyle get h3 => titleLarge;
  static TextStyle get body => bodyLarge;
  static TextStyle get price => priceMedium;
  static TextStyle get label => labelMedium;
}
