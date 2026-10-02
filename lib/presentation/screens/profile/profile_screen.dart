import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:dekho/core/theme/theme.dart';
import 'package:dekho/core/routing/routes.dart';
import 'package:dekho/core/providers/theme_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.w800),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          // User Card
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: AppRadius.lg,
                border: Border.all(color: AppColors.border),
                boxShadow: AppShadows.subtle,
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        LucideIcons.user,
                        size: 30,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rahul Sharma',
                          style: AppTypography.titleMedium.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Smart Shopper • Pro Tier',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Savings Summary Bento
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: AppRadius.md,
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatItem(
                    label: 'Total Saved',
                    value: '₹14,500',
                    valueColor: AppColors.success,
                  ),
                  Container(width: 1, height: 32, color: AppColors.border),
                  _StatItem(
                    label: 'Price Alerts',
                    value: '6 Active',
                    valueColor: AppColors.primary,
                  ),
                  Container(width: 1, height: 32, color: AppColors.border),
                  _StatItem(
                    label: 'Tracked Items',
                    value: '18',
                    valueColor: AppColors.text,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Settings Section
          _SectionTitle(title: 'Preferences'),
          _SwitchTile(
            icon: LucideIcons.moon,
            title: 'Dark Mode',
            subtitle: 'OLED-friendly dark theme',
            value: themeMode == ThemeMode.dark,
            onChanged: (val) {
              ref.read(themeModeProvider.notifier).toggle();
            },
          ),
          _ProfileTile(
            icon: LucideIcons.bell,
            title: 'Price Drop Alerts',
            subtitle: 'Get notified when price drops',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Alerts enabled')),
              );
            },
          ),
          _ProfileTile(
            icon: LucideIcons.clock,
            title: 'Recently Viewed',
            subtitle: 'Products you looked at',
            onTap: () => context.push(AppRoutes.recentlyViewed),
          ),

          const SizedBox(height: AppSpacing.md),
          _SectionTitle(title: 'Support & Legal'),
          _ProfileTile(
            icon: LucideIcons.helpCircle,
            title: 'Help & Support',
            onTap: () {},
          ),
          _ProfileTile(
            icon: LucideIcons.shield,
            title: 'Privacy & Security',
            onTap: () {},
          ),
          _ProfileTile(
            icon: LucideIcons.info,
            title: 'About Dekho',
            subtitle: 'v1.0.0 (Stitch Edition)',
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Dekho',
                applicationVersion: '1.0.0',
                applicationLegalese:
                    'Dekho: Premium Shopping Discovery & Price Comparison for India.',
              );
            },
          ),

          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _StatItem({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w800,
            color: valueColor,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTypography.caption,
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.xs,
      ),
      child: Text(
        title.toUpperCase(),
        style: AppTypography.labelMedium.copyWith(
          color: AppColors.textTertiary,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _ProfileTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: AppRadius.sm,
        ),
        child: Icon(icon, color: AppColors.primary, size: 18),
      ),
      title: Text(title, style: AppTypography.bodyMedium),
      subtitle: subtitle != null
          ? Text(subtitle!, style: AppTypography.caption)
          : null,
      trailing: const Icon(
        LucideIcons.chevronRight,
        size: 18,
        color: AppColors.textTertiary,
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: AppRadius.sm,
        ),
        child: Icon(icon, color: AppColors.primary, size: 18),
      ),
      title: Text(title, style: AppTypography.bodyMedium),
      subtitle: subtitle != null
          ? Text(subtitle!, style: AppTypography.caption)
          : null,
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.primary,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
    );
  }
}
