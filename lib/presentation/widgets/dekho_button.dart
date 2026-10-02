import 'package:flutter/material.dart';
import 'package:dekho/core/theme/app_colors.dart';
import 'package:dekho/core/theme/app_radius.dart';
import 'package:dekho/core/theme/app_typography.dart';
import 'package:dekho/core/theme/app_motion.dart';

enum DekhoButtonVariant { primary, secondary, outline, ghost }
enum DekhoButtonSize { small, medium, large }

/// A premium Dekho button with micro-interaction (scale-down on press).
class DekhoButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final DekhoButtonVariant variant;
  final DekhoButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool expanded;

  const DekhoButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = DekhoButtonVariant.primary,
    this.size = DekhoButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.expanded = false,
  });

  @override
  State<DekhoButton> createState() => _DekhoButtonState();
}

class _DekhoButtonState extends State<DekhoButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppMotion.fast,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: AppMotion.microInteraction),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get _height {
    switch (widget.size) {
      case DekhoButtonSize.small:
        return 36;
      case DekhoButtonSize.medium:
        return 48;
      case DekhoButtonSize.large:
        return 56;
    }
  }

  EdgeInsets get _padding {
    switch (widget.size) {
      case DekhoButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16);
      case DekhoButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24);
      case DekhoButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32);
    }
  }

  TextStyle get _textStyle {
    switch (widget.size) {
      case DekhoButtonSize.small:
        return AppTypography.labelMedium;
      case DekhoButtonSize.medium:
        return AppTypography.bodyMedium;
      case DekhoButtonSize.large:
        return AppTypography.bodyMedium;
    }
  }

  Color get _backgroundColor {
    if (widget.onPressed == null) return AppColors.disabled;
    switch (widget.variant) {
      case DekhoButtonVariant.primary:
        return AppColors.primary;
      case DekhoButtonVariant.secondary:
        return AppColors.primarySurface;
      case DekhoButtonVariant.outline:
      case DekhoButtonVariant.ghost:
        return Colors.transparent;
    }
  }

  Color get _foregroundColor {
    if (widget.onPressed == null) return AppColors.textTertiary;
    switch (widget.variant) {
      case DekhoButtonVariant.primary:
        return AppColors.white;
      case DekhoButtonVariant.secondary:
        return AppColors.primary;
      case DekhoButtonVariant.outline:
        return AppColors.primary;
      case DekhoButtonVariant.ghost:
        return AppColors.primary;
    }
  }

  Border? get _border {
    if (widget.variant == DekhoButtonVariant.outline) {
      return Border.all(
        color: widget.onPressed == null ? AppColors.disabled : AppColors.primary,
        width: 1.5,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null || widget.isLoading;

    return GestureDetector(
      onTapDown: isDisabled ? null : (_) => _controller.forward(),
      onTapUp: isDisabled
          ? null
          : (_) {
              _controller.reverse();
              widget.onPressed?.call();
            },
      onTapCancel: isDisabled ? null : () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        ),
        child: AnimatedContainer(
          duration: AppMotion.fast,
          curve: AppMotion.microInteraction,
          height: _height,
          padding: _padding,
          constraints: widget.expanded
              ? const BoxConstraints(minWidth: double.infinity)
              : null,
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: AppRadius.md,
            border: _border,
          ),
          child: Center(
            child: widget.isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: _foregroundColor,
                    ),
                  )
                : Row(
                    mainAxisSize:
                        widget.expanded ? MainAxisSize.max : MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(widget.icon, size: 18, color: _foregroundColor),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        widget.label,
                        style: _textStyle.copyWith(color: _foregroundColor),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
