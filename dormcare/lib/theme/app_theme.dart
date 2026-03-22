import 'package:flutter/material.dart';

// App colors
// รวมสีทั้งหมดที่ hardcode กระจายอยู่ในทุกไฟล์ไว้ที่เดียว

class AppColors {
  AppColors._();

  // Owner theme (Purple)
  static const Color ownerPrimary = Color(0xFFA34CF3);
  static const Color ownerSecondary = Color(0xFF5B3FBF);
  static const Color ownerDark = Color(0xFF7B2FD4);
  static const Color ownerSoft = Color(0xFFF3E8FF);
  static const Color ownerBorder = Color(0xFFD8B4FE);

  // Tenant theme (Blue)
  static const Color tenantPrimary = Color(0xFF367BF3);
  static const Color tenantSecondary = Color(0xFF2457D9);
  static const Color tenantDark = Color(0xFF1A5FD4);
  static const Color tenantSoft = Color(0xFFEFF6FF);

  // Semantic colors
  static const Color success = Color(0xFF66BB6A);
  static const Color successDark = Color(0xFF43A047);
  static const Color successSoft = Color(0xFFE8F5E9);

  static const Color warning = Color(0xFFFFA726);
  static const Color warningSoft = Color(0xFFFFF8E1);

  static const Color error = Color(0xFFEF5350);
  static const Color errorSoft = Color(0xFFFFEBEE);
  static const Color errorBorder = Color(0xFFEF9A9A);

  static const Color info = Color(0xFF42A5F5);
  static const Color infoSoft = Color(0xFFE3F2FD);

  // Repair status colors
  static const Color statusPending = Color(0xFFFFA726);
  static const Color statusPendingSoft = Color(0xFFFFE0B2);

  static const Color statusInProgress = Color(0xFF42A5F5);
  static const Color statusInProgressSoft = Color(0xFFBBDEFB);

  static const Color statusCompleted = Color(0xFF66BB6A);
  static const Color statusCompletedSoft = Color(0xFFC8E6C9);

  static const Color statusCancelled = Color(0xFFEF5350);
  static const Color statusCancelledSoft = Color(0xFFFFCDD2);

  // Neutral / Text
  static const Color textPrimary = Color(0xFF0D1B2A);
  static const Color textSecondary = Color(0xFF4A5568);
  static const Color textHint = Color(0xFF9AA5B4);

  // Background
  static const Color background = Color(0xFFF7F8FA);
  static const Color surface = Colors.white;

  // Border / Divider
  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFF3F4F6);

  // Bill breakdown colors
  static const Color billWater = Color(0xFF00BCD4);
  static const Color billWaterSoft = Color(0xFFECFEFF);
  static const Color billElec = Color(0xFFFFA726);
  static const Color billElecSoft = Color(0xFFFFFBEB);
  static const Color billRent = Color(0xFF367BF3);
  static const Color billRentSoft = Color(0xFFEFF6FF);
}

// App text styles
// รวม TextStyle ที่ใช้ซ้ำบ่อยไว้ที่เดียว

class AppTextStyles {
  AppTextStyles._();

  // Headings
  static const TextStyle h1 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -0.4,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  // Body
  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 13,
    color: AppColors.textPrimary,
  );

  // Labels
  static const TextStyle label = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textHint,
  );

  // Caption
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.textHint,
  );

  // AppBar title
  static const TextStyle appBarTitle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: Colors.white,
  );

  // Section label (ใช้ใน home screen)
  static const TextStyle sectionLabel = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
  );

  // Amount / number (ใช้ใน bills, stats)
  static const TextStyle amount = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
    height: 1,
  );

  static const TextStyle amountLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w900,
    color: Colors.white,
    letterSpacing: -2,
    height: 1,
  );
}

// App theme
// ThemeData สำหรับ owner และ tenant

class AppTheme {
  AppTheme._();

  static ThemeData ownerTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.ownerPrimary,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.ownerPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: AppTextStyles.appBarTitle,
        centerTitle: false,
      ),
    );
  }

  static ThemeData tenantTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.tenantPrimary,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.tenantPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: AppTextStyles.appBarTitle,
        centerTitle: false,
      ),
    );
  }
}
