import 'package:flutter/material.dart';
import 'package:dekho/core/theme/app_motion.dart';

/// Animates a child widget in with a fade + slide-up entrance.
///
/// Uses [AnimatedOpacity] + [AnimatedSlide] instead of
/// [FadeTransition] + [SlideTransition] to avoid the
/// `!semantics.parentDataDirty` assertion in Flutter 3.35 when
/// used inside [CustomScrollView] slivers.
class AnimatedListItem extends StatefulWidget {
  final Widget child;
  final int index;
  final Duration? delay;

  const AnimatedListItem({
    super.key,
    required this.child,
    required this.index,
    this.delay,
  });

  @override
  State<AnimatedListItem> createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    final delay = widget.delay ?? Duration(milliseconds: widget.index * 50);
    Future.delayed(delay, () {
      if (mounted) {
        setState(() => _visible = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: AppMotion.standard,
      curve: Curves.easeOut,
      opacity: _visible ? 1.0 : 0.0,
      child: AnimatedSlide(
        duration: AppMotion.standard,
        curve: Curves.easeOutCubic,
        offset: _visible ? Offset.zero : const Offset(0, 0.05),
        child: widget.child,
      ),
    );
  }
}
