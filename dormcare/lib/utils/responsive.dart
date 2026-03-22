import 'package:flutter/material.dart';

// Responsive helpers
// ใช้จัดการ layout ตามขนาดหน้าจอ
// MVP ยังไม่ได้ใช้เต็มที่ แต่เตรียมไว้รองรับหน้าจอหลายขนาด

class AppResponsive {
  AppResponsive._();

  // Breakpoints
  static const double _sm = 360.0; // small phone  (e.g. iPhone SE)
  // static const double _md = 390.0; // normal phone (e.g. iPhone 14)
  static const double _lg = 430.0; // large phone  (e.g. iPhone 14 Pro Max)
  static const double _xl = 600.0; // tablet

  static bool isSmall(BuildContext context) =>
      MediaQuery.of(context).size.width < _sm;

  static bool isMedium(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= _sm && w < _lg;
  }

  static bool isLarge(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= _lg && w < _xl;
  }

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= _xl;

  // Shorthand getters
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  // Responsive value helper
  // คืนค่าตามขนาดหน้าจอ: [small] สำหรับหน้าจอเล็ก, [large] สำหรับ tablet
  // ถ้าไม่ระบุ [large] จะใช้ [normal]
  static T value<T>(
    BuildContext context, {
    required T small,
    required T normal,
    T? large,
  }) {
    if (isSmall(context)) return small;
    if (isTablet(context)) return large ?? normal;
    return normal;
  }

  // Fraction helpers
  // เช่น fractionalHeight(context, 0.07) แทน screenHeight * 0.07
  static double fractionalHeight(BuildContext context, double fraction) =>
      screenHeight(context) * fraction;

  static double fractionalWidth(BuildContext context, double fraction) =>
      screenWidth(context) * fraction;
}
