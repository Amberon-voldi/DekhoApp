import 'package:flutter/material.dart';

class AppMotion {
  AppMotion._();

  // ─── Durations ───────────────────────────────────────────
  static const Duration instant = Duration(milliseconds: 100);
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration standard = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration page = Duration(milliseconds: 400);
  static const Duration stagger = Duration(milliseconds: 50);

  // ─── Curves ──────────────────────────────────────────────
  static const Curve standardCurve = Curves.easeInOut;
  static const Curve decelerate = Curves.decelerate;
  static const Curve accelerate = Curves.easeIn;
  static const Curve emphasized = Curves.easeInOutCubicEmphasized;
  static const Curve spring = Curves.easeOutBack;
  static const Curve microInteraction = Curves.easeOutCubic;
}
