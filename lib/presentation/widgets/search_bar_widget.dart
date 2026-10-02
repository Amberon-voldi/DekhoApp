import 'package:flutter/material.dart';
import 'package:dekho/core/theme/app_colors.dart';
import 'package:dekho/core/theme/app_spacing.dart';
import 'package:dekho/core/theme/app_radius.dart';
import 'package:dekho/core/theme/app_typography.dart';
import 'package:dekho/core/theme/app_shadows.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DekhoSearchBar extends StatefulWidget {
  final VoidCallback? onTap;
  final bool autofocus;
  final String? initialQuery;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;
  final String? hintText;

  const DekhoSearchBar({
    super.key,
    this.onTap,
    this.autofocus = false,
    this.initialQuery,
    this.onChanged,
    this.onClear,
    this.onSubmitted,
    this.enabled = true,
    this.hintText,
  });

  @override
  State<DekhoSearchBar> createState() => _DekhoSearchBarState();
}

class _DekhoSearchBarState extends State<DekhoSearchBar> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
    _controller.addListener(() {
      setState(() {});
    });
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Widget _buildField() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.full,
        border: Border.all(
          color: _isFocused ? AppColors.primary : AppColors.border,
          width: _isFocused ? 2 : 1,
        ),
        boxShadow: _isFocused
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ]
            : AppShadows.subtle,
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        children: [
          Icon(
            LucideIcons.search,
            color: _isFocused ? AppColors.primary : AppColors.textTertiary,
            size: 22,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: widget.enabled
                ? TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    autofocus: widget.autofocus,
                    onChanged: widget.onChanged,
                    onSubmitted: widget.onSubmitted,
                    style: AppTypography.bodyLarge.copyWith(color: AppColors.text),
                    decoration: InputDecoration(
                      hintText: widget.hintText ?? 'Search products...',
                      hintStyle: AppTypography.bodyLarge.copyWith(color: AppColors.textTertiary),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                  )
                : Text(
                    widget.initialQuery ?? widget.hintText ?? 'Search products...',
                    style: AppTypography.bodyLarge.copyWith(
                      color: widget.initialQuery == null
                          ? AppColors.textTertiary
                          : AppColors.text,
                    ),
                  ),
          ),
          if (widget.enabled && _controller.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _controller.clear();
                widget.onClear?.call();
                widget.onChanged?.call('');
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColors.neutral200,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  LucideIcons.x,
                  color: AppColors.textSecondary,
                  size: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return GestureDetector(
        onTap: widget.onTap,
        child: _buildField(),
      );
    }
    return _buildField();
  }
}
