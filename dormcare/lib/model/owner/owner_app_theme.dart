import 'package:flutter/material.dart';

class OwnerAppTheme {
  final Color primary;
  final Color secondary;
  final Color accent;

  final Color textPrimary;
  final Color textSecondary;
  final Color textAccent;

  final Color mutedColor;

  final List<Color> bgGradientColors;

  const OwnerAppTheme({
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.textPrimary,
    required this.textSecondary,
    required this.textAccent,
    required this.mutedColor,
    required this.bgGradientColors,
  });
}
