import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dekho/core/theme/app_colors.dart';
import 'package:dekho/core/theme/app_motion.dart';
import 'package:dekho/core/providers/wishlist_providers.dart';
import 'package:lucide_icons/lucide_icons.dart';

class WishlistButton extends ConsumerWidget {
  final String productId;
  final double size;

  const WishlistButton({
    super.key,
    required this.productId,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWishlisted = ref.watch(isWishlistedProvider(productId));

    return GestureDetector(
      onTap: () {
        // Need to get the product to toggle - for now just toggle by finding it
        // This is a simplified version; in production we'd pass the Product
      },
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 1.0, end: isWishlisted ? 1.0 : 1.0),
        duration: AppMotion.fast,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: AnimatedSwitcher(
              duration: AppMotion.fast,
              child: Icon(
                isWishlisted ? Icons.favorite : LucideIcons.heart,
                key: ValueKey(isWishlisted),
                color: isWishlisted ? AppColors.error : AppColors.textTertiary,
                size: size,
              ),
            ),
          );
        },
      ),
    );
  }
}
