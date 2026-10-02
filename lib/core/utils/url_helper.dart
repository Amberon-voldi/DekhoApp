import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dekho/domain/models/models.dart';
import 'package:dekho/core/theme/theme.dart';

class UrlHelper {
  /// Opens a retailer offer directly in the native app or default web browser.
  static Future<void> launchRetailerOffer(
    BuildContext context,
    RetailerOffer offer, {
    String? productName,
  }) async {
    HapticFeedback.mediumImpact();

    final uri = Uri.tryParse(offer.url);
    if (uri == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid link for ${offer.retailer.displayName}'),
            backgroundColor: AppColors.error,
          ),
        );
      }
      return;
    }

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && context.mounted) {
        // Fallback to in-app web view / platform default
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Could not open ${offer.retailer.displayName}. Please check your browser.',
            ),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  /// Opens a general web URL safely
  static Future<void> openUrl(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open link'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
}
