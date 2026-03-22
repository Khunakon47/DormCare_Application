import 'package:flutter/material.dart';

class AppResponsive {
  AppResponsive._();

  // Breakpoints
  static const double _tabletBreakpoint = 600.0;
  static const double _desktopBreakpoint = 1024.0;

  // Device type checks
  static bool isPhone(BuildContext context) => MediaQuery.of(context).size.width < _tabletBreakpoint;

  static bool isTablet(BuildContext context) =>
    MediaQuery.of(context).size.width >= _tabletBreakpoint &&
    MediaQuery.of(context).size.width < _desktopBreakpoint;
    
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= _desktopBreakpoint;

  // Screen size helpers
  static double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

  // Safe area insets
  static double topPadding(BuildContext context) => MediaQuery.of(context).padding.top;
  static double bottomPadding(BuildContext context) => MediaQuery.of(context).padding.bottom;

  // Fraction helpers
  static double fractionalWidth(BuildContext context, double f) => screenWidth(context) * f;
  static double fractionalHeight(BuildContext context, double f) => screenHeight(context) * f;

  // Responsive value — คืนค่าตาม device type
  // ถ้าไม่ระบุ tablet หรือ desktop จะ fallback ไปที่ phone
  static T value<T>(
    BuildContext context, {
    required T phone,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context)) return desktop ?? tablet ?? phone;
    if (isTablet(context)) return tablet ?? phone;
    return phone;
  }
}
