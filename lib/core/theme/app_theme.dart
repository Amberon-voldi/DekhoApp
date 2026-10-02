import 'package:flutter/material.dart';
import 'theme.dart';

/// Custom theme extension for Dekho-specific semantic colors
/// that don't map to Material's built-in ColorScheme.
///
/// Usage: `Theme.of(context).extension<DekhoThemeExtension>()!`
@immutable
class DekhoThemeExtension extends ThemeExtension<DekhoThemeExtension> {
  final Color discount;
  final Color discountSurface;
  final Color bestDeal;
  final Color bestDealSurface;
  final Color priceDrop;
  final Color priceDropSurface;
  final Color card;
  final Color shimmerBase;
  final Color shimmerHighlight;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color border;
  final Color divider;
  final Color surfaceVariant;

  const DekhoThemeExtension({
    required this.discount,
    required this.discountSurface,
    required this.bestDeal,
    required this.bestDealSurface,
    required this.priceDrop,
    required this.priceDropSurface,
    required this.card,
    required this.shimmerBase,
    required this.shimmerHighlight,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.border,
    required this.divider,
    required this.surfaceVariant,
  });

  static const light = DekhoThemeExtension(
    discount: AppColors.discount,
    discountSurface: AppColors.discountSurface,
    bestDeal: AppColors.bestDeal,
    bestDealSurface: AppColors.bestDealSurface,
    priceDrop: AppColors.priceDrop,
    priceDropSurface: AppColors.priceDropSurface,
    card: AppColors.card,
    shimmerBase: AppColors.shimmerBase,
    shimmerHighlight: AppColors.shimmerHighlight,
    textPrimary: AppColors.text,
    textSecondary: AppColors.textSecondary,
    textTertiary: AppColors.textTertiary,
    border: AppColors.border,
    divider: AppColors.divider,
    surfaceVariant: AppColors.neutral50,
  );

  static const dark = DekhoThemeExtension(
    discount: AppColorsDark.discount,
    discountSurface: AppColorsDark.discountSurface,
    bestDeal: AppColorsDark.bestDeal,
    bestDealSurface: AppColorsDark.bestDealSurface,
    priceDrop: AppColors.priceDrop,
    priceDropSurface: AppColors.priceDropSurface,
    card: AppColorsDark.card,
    shimmerBase: AppColorsDark.shimmerBase,
    shimmerHighlight: AppColorsDark.shimmerHighlight,
    textPrimary: AppColorsDark.text,
    textSecondary: AppColorsDark.textSecondary,
    textTertiary: AppColorsDark.textTertiary,
    border: AppColorsDark.border,
    divider: AppColorsDark.divider,
    surfaceVariant: AppColorsDark.surfaceVariant,
  );

  @override
  DekhoThemeExtension copyWith({
    Color? discount,
    Color? discountSurface,
    Color? bestDeal,
    Color? bestDealSurface,
    Color? priceDrop,
    Color? priceDropSurface,
    Color? card,
    Color? shimmerBase,
    Color? shimmerHighlight,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? border,
    Color? divider,
    Color? surfaceVariant,
  }) {
    return DekhoThemeExtension(
      discount: discount ?? this.discount,
      discountSurface: discountSurface ?? this.discountSurface,
      bestDeal: bestDeal ?? this.bestDeal,
      bestDealSurface: bestDealSurface ?? this.bestDealSurface,
      priceDrop: priceDrop ?? this.priceDrop,
      priceDropSurface: priceDropSurface ?? this.priceDropSurface,
      card: card ?? this.card,
      shimmerBase: shimmerBase ?? this.shimmerBase,
      shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
    );
  }

  @override
  DekhoThemeExtension lerp(covariant DekhoThemeExtension? other, double t) {
    if (other is! DekhoThemeExtension) return this;
    return DekhoThemeExtension(
      discount: Color.lerp(discount, other.discount, t)!,
      discountSurface: Color.lerp(discountSurface, other.discountSurface, t)!,
      bestDeal: Color.lerp(bestDeal, other.bestDeal, t)!,
      bestDealSurface: Color.lerp(bestDealSurface, other.bestDealSurface, t)!,
      priceDrop: Color.lerp(priceDrop, other.priceDrop, t)!,
      priceDropSurface: Color.lerp(priceDropSurface, other.priceDropSurface, t)!,
      card: Color.lerp(card, other.card, t)!,
      shimmerBase: Color.lerp(shimmerBase, other.shimmerBase, t)!,
      shimmerHighlight: Color.lerp(shimmerHighlight, other.shimmerHighlight, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      border: Color.lerp(border, other.border, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
    );
  }
}

class AppTheme {
  AppTheme._();

  // ─── Light Theme ─────────────────────────────────────────
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryContainer,
        secondary: AppColors.secondary,
        secondaryContainer: AppColors.secondaryContainer,
        error: AppColors.error,
        surface: AppColors.surface,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: AppColors.text,
        onError: AppColors.white,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        foregroundColor: AppColors.text,
        titleTextStyle: AppTypography.titleLarge,
      ),
      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.md),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.md),
          minimumSize: const Size(0, 52),
          elevation: 0,
          textStyle: AppTypography.bodyMedium,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.md),
          minimumSize: const Size(0, 52),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.sm),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.neutral50,
        border: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        hintStyle: AppTypography.bodyLarge.copyWith(color: AppColors.textTertiary),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        showDragHandle: true,
        dragHandleColor: AppColors.neutral300,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.neutral50,
        selectedColor: AppColors.primarySurface,
        labelStyle: AppTypography.bodySmall,
        shape: const StadiumBorder(side: BorderSide(color: AppColors.border)),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.neutral800,
        contentTextStyle: AppTypography.bodySmall.copyWith(color: AppColors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.md),
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMedium,
        displaySmall: AppTypography.displayMedium,
        headlineLarge: AppTypography.headlineLarge,
        headlineMedium: AppTypography.headlineMedium,
        headlineSmall: AppTypography.titleLarge,
        titleLarge: AppTypography.titleLarge,
        titleMedium: AppTypography.titleMedium,
        titleSmall: AppTypography.bodyMedium,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
        labelLarge: AppTypography.labelLarge,
        labelMedium: AppTypography.labelMedium,
        labelSmall: AppTypography.caption,
      ),
      extensions: const [DekhoThemeExtension.light],
    );
  }

  // ─── Dark Theme ──────────────────────────────────────────
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColorsDark.primary,
        primaryContainer: AppColorsDark.primaryContainer,
        secondary: AppColorsDark.secondary,
        secondaryContainer: AppColorsDark.secondaryContainer,
        error: AppColorsDark.error,
        surface: AppColorsDark.surface,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: AppColorsDark.text,
        onError: AppColors.white,
      ),
      scaffoldBackgroundColor: AppColorsDark.background,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        foregroundColor: AppColorsDark.text,
        titleTextStyle: AppTypography.titleLarge.copyWith(color: AppColorsDark.text),
      ),
      cardTheme: CardThemeData(
        color: AppColorsDark.card,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.md),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorsDark.primary,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.md),
          minimumSize: const Size(0, 52),
          elevation: 0,
          textStyle: AppTypography.bodyMedium.copyWith(color: AppColors.white),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: const BorderSide(color: AppColorsDark.primary),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.md),
          minimumSize: const Size(0, 52),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColorsDark.primary,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.sm),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorsDark.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: const BorderSide(color: AppColorsDark.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: const BorderSide(color: AppColorsDark.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        hintStyle: AppTypography.bodyLarge.copyWith(color: AppColorsDark.textTertiary),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColorsDark.elevated,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        showDragHandle: true,
        dragHandleColor: AppColorsDark.neutral400,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColorsDark.divider,
        thickness: 1,
        space: 1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColorsDark.surfaceVariant,
        selectedColor: AppColorsDark.primaryContainer,
        labelStyle: AppTypography.bodySmall.copyWith(color: AppColorsDark.text),
        shape: const StadiumBorder(side: BorderSide(color: AppColorsDark.border)),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColorsDark.surface,
        selectedItemColor: AppColorsDark.primary,
        unselectedItemColor: AppColorsDark.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColorsDark.elevated,
        contentTextStyle: AppTypography.bodySmall.copyWith(color: AppColorsDark.text),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.md),
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge.copyWith(color: AppColorsDark.text),
        displayMedium: AppTypography.displayMedium.copyWith(color: AppColorsDark.text),
        displaySmall: AppTypography.displayMedium.copyWith(color: AppColorsDark.text),
        headlineLarge: AppTypography.headlineLarge.copyWith(color: AppColorsDark.text),
        headlineMedium: AppTypography.headlineMedium.copyWith(color: AppColorsDark.text),
        headlineSmall: AppTypography.titleLarge.copyWith(color: AppColorsDark.text),
        titleLarge: AppTypography.titleLarge.copyWith(color: AppColorsDark.text),
        titleMedium: AppTypography.titleMedium.copyWith(color: AppColorsDark.text),
        titleSmall: AppTypography.bodyMedium.copyWith(color: AppColorsDark.text),
        bodyLarge: AppTypography.bodyLarge.copyWith(color: AppColorsDark.text),
        bodyMedium: AppTypography.bodyMedium.copyWith(color: AppColorsDark.text),
        bodySmall: AppTypography.bodySmall.copyWith(color: AppColorsDark.textSecondary),
        labelLarge: AppTypography.labelLarge.copyWith(color: AppColorsDark.textSecondary),
        labelMedium: AppTypography.labelMedium.copyWith(color: AppColorsDark.textSecondary),
        labelSmall: AppTypography.caption.copyWith(color: AppColorsDark.textTertiary),
      ),
      extensions: const [DekhoThemeExtension.dark],
    );
  }
}
