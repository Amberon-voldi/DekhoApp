import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dekho/core/theme/app_colors.dart';
import 'package:dekho/core/theme/app_radius.dart';
import 'package:dekho/core/theme/app_typography.dart';
import 'package:dekho/core/theme/app_motion.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BottomNavShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BottomNavShell({
    super.key,
    required this.navigationShell,
  });

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = navigationShell.currentIndex;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
          border: const Border(
            top: BorderSide(color: AppColors.border, width: 1),
          ),
        ),
        padding: EdgeInsets.fromLTRB(
          12,
          8,
          12,
          MediaQuery.of(context).padding.bottom > 0
              ? MediaQuery.of(context).padding.bottom
              : 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: LucideIcons.home,
              label: 'Home',
              isSelected: currentIndex == 0,
              onTap: () => _onTap(0),
            ),
            _NavItem(
              icon: LucideIcons.compass,
              label: 'Explore',
              isSelected: currentIndex == 1,
              onTap: () => _onTap(1),
            ),
            _NavItem(
              icon: LucideIcons.heart,
              label: 'Wishlist',
              isSelected: currentIndex == 2,
              onTap: () => _onTap(2),
            ),
            _NavItem(
              icon: LucideIcons.user,
              label: 'Profile',
              isSelected: currentIndex == 3,
              onTap: () => _onTap(3),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: AppMotion.fast,
        curve: AppMotion.microInteraction,
        padding: isSelected
            ? const EdgeInsets.symmetric(horizontal: 16, vertical: 6)
            : const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryContainer : Colors.transparent,
          borderRadius: AppRadius.full,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.primaryDark : AppColors.textTertiary,
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
