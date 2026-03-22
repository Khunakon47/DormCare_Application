import 'package:flutter/material.dart';
import 'package:dormcare/utils/format.dart';
import 'package:dormcare/theme/app_theme.dart';

enum AlertCategory { general, parcel, bill, emergency }

class AlertTenantModel {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final AlertCategory category;
  bool isRead;

  AlertTenantModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.category,
    this.isRead = false,
  });

  // Format helpers
  String get displayDate => AppFormat.smart(createdAt);
  String get fullDateTime => AppFormat.dateTime(createdAt);

  // Category helpers
  IconData get categoryIcon {
    switch (category) {
      case AlertCategory.parcel:
        return Icons.local_shipping_outlined;
      case AlertCategory.bill:
        return Icons.receipt_long_outlined;
      case AlertCategory.emergency:
        return Icons.warning_amber_rounded;
      case AlertCategory.general:
        return Icons.notifications_none_outlined;
    }
  }

  Color get categoryColor {
    switch (category) {
      case AlertCategory.parcel:
        return AppColors.alertBill;
      case AlertCategory.bill:
        return AppColors.alertBillPurple;
      case AlertCategory.emergency:
        return AppColors.error;
      case AlertCategory.general:
        return AppColors.info;
    }
  }

  Color get categoryBgColor {
    switch (category) {
      case AlertCategory.parcel:
        return AppColors.alertParcelSoft2;
      case AlertCategory.bill:
        return AppColors.alertBillPurpleSoft;
      case AlertCategory.emergency:
        return AppColors.errorSoft;
      case AlertCategory.general:
        return AppColors.infoSoft;
    }
  }

  String get categoryText {
    switch (category) {
      case AlertCategory.parcel:
        return 'Parcel';
      case AlertCategory.bill:
        return 'Bill';
      case AlertCategory.emergency:
        return 'Emergency';
      case AlertCategory.general:
        return 'General';
    }
  }
}
