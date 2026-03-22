import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// App Colors
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

  // Semantic — Success
  static const Color success = Color(0xFF66BB6A);
  static const Color successDark = Color(0xFF43A047);
  static const Color successDeep = Color(0xFF2E7D32);
  static const Color successBorder = Color(0xFFA5D6A7);
  static const Color successSoft = Color(0xFFE8F5E9);

  // Semantic — Warning
  static const Color warning = Color(0xFFFFA726);
  static const Color warningDark = Color(0xFFFF9800);
  static const Color warningDeep = Color(0xFFFF6F00);
  static const Color warningBorder = Color(0xFFFFCC80);
  static const Color warningSoft = Color(0xFFFFF8E1);

  // Semantic — Error
  static const Color error = Color(0xFFEF5350);
  static const Color errorDark = Color(0xFFE53935);
  static const Color errorDeep = Color(0xFFB71C1C);
  static const Color errorBorder = Color(0xFFEF9A9A);
  static const Color errorSoft = Color(0xFFFFEBEE);

  // Semantic — Info
  static const Color info = Color(0xFF42A5F5);
  static const Color infoSoft = Color(0xFFE3F2FD);

  // Repair status
  static const Color statusPending = Color(0xFFFFA726);
  static const Color statusPendingSoft = Color(0xFFFFE0B2);
  static const Color statusInProgress = Color(0xFF42A5F5);
  static const Color statusInProgressSoft = Color(0xFFBBDEFB);
  static const Color statusCompleted = Color(0xFF66BB6A);
  static const Color statusCompletedSoft = Color(0xFFC8E6C9);
  static const Color statusCancelled = Color(0xFFEF5350);
  static const Color statusCancelledSoft = Color(0xFFFFCDD2);

  // Text
  static const Color textPrimary = Color(0xFF0D1B2A);
  static const Color textPrimarySoft = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF4A5568);
  static const Color textSecondarySoft = Color(0xFF718096);
  static const Color textHint = Color(0xFF9AA5B4);
  static const Color textHintSoft = Color(0xFFCBD5E1);

  // Background / Surface
  static const Color background = Color(0xFFF7F8FA);
  static const Color surface = Colors.white;

  // Border / Divider
  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFF3F4F6);

  // Bill breakdown
  static const Color billRent = Color(0xFF367BF3);
  static const Color billRentSoft = Color(0xFFEFF6FF);
  static const Color billWater = Color(0xFF00BCD4);
  static const Color billWaterSoft = Color(0xFFECFEFF);
  static const Color billElec = Color(0xFFFFA726);
  static const Color billElecSoft = Color(0xFFFFFBEB);
  static const Color billElecDark = Color(0xFFC47A00);
  static const Color billElecLabel = Color(0xFFD4970A);
  static const Color billWaterDark = Color(0xFF007B8A);
  static const Color billWaterLabel = Color(0xFF3AABB8);

  // Alert category
  static const Color alertEmergency = Color(0xFFEF5350);
  static const Color alertEmergencySoft = Color(0xFFFFEBEE);
  static const Color alertBill = Color(0xFFFFA726);
  static const Color alertBillSoft = Color(0xFFFFF8E1);
  static const Color alertParcel = Color(0xFF42A5F5);
  static const Color alertParcelSoft = Color(0xFFE3F2FD);
  static const Color alertParcelSoft2 = Color(0xFFFFF3E0);
  static const Color alertGeneral = Color(0xFF9AA5B4);
  static const Color alertGeneralSoft = Color(0xFFF3F4F6);
  static const Color alertBillPurple = Color(0xFF7E57C2);
  static const Color alertBillPurpleSoft = Color(0xFFEDE7F6);

  // On-gradient accent — ใช้บน hero card gradient
  static const Color onGradientRent = Color(0xFF90CAF9); // ฟ้าอ่อนบน gradient
  static const Color onGradientWater = Color(0xFF80DEEA,); // ฟ้าเขียวอ่อนบน gradient
  static const Color onGradientElec = Color(0xFFFFCC80); // ส้มอ่อนบน gradient
}

// App Text Styles
class AppTextStyles {
  AppTextStyles._();

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
  static const TextStyle h4 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
  );
  static const TextStyle bodySmall = TextStyle(
    fontSize: 13,
    color: AppColors.textPrimary,
  );

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

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.textHint,
  );
  static const TextStyle hint = TextStyle(
    fontSize: 13,
    color: AppColors.textHint,
  );

  static const TextStyle sectionLabel = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
  );
  static const TextStyle listHeader = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textHint,
  );

  static const TextStyle amount = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
    height: 1,
  );
  static const TextStyle amountHero = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w900,
    color: Colors.white,
    letterSpacing: -2,
    height: 1,
  );
  static const TextStyle amountUnit = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.textHint,
  );

  static const TextStyle appBarTitle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: Colors.white,
  );
  static const TextStyle appBarTitleDark = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 15,
    color: AppColors.textPrimary,
  );
  static const TextStyle appBarSubtitle = TextStyle(
    fontSize: 11,
    color: AppColors.textHint,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle badge = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle chip = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );
}

// App Theme
class AppTheme {
  AppTheme._();

  static ThemeData tenantTheme() => _base(AppColors.tenantPrimary);
  static ThemeData ownerTheme() => _base(AppColors.ownerPrimary);

  static ThemeData _base(Color seedColor) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: AppTextStyles.appBarTitleDark,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 0.5,
        space: 1,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}
