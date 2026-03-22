import 'package:dormcare/utils/format.dart';
import 'package:flutter/material.dart';

enum AlertOwnerCategory { repairRequest, billReminder, general }

class AlertOwnerModel {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final AlertOwnerCategory category;
  final String? roomNumber;
  final String? tenantName;
  bool isRead;

  AlertOwnerModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.category,
    this.roomNumber,
    this.tenantName,
    this.isRead = false,
  });

  // Format helpers
  String get displayDate => AppFormat.smart(createdAt);
  String get fullDateTime => AppFormat.dateTime(createdAt);

  // Category helpers
  String get categoryText {
    switch (category) {
      case AlertOwnerCategory.repairRequest:
        return 'Repair Request';
      case AlertOwnerCategory.billReminder:
        return 'Bill Reminder';
      case AlertOwnerCategory.general:
        return 'General';
    }
  }

  IconData get categoryIcon {
    switch (category) {
      case AlertOwnerCategory.repairRequest:
        return Icons.build_outlined;
      case AlertOwnerCategory.billReminder:
        return Icons.receipt_long_outlined;
      case AlertOwnerCategory.general:
        return Icons.notifications_none_outlined;
    }
  }

  Color get categoryColor {
    switch (category) {
      case AlertOwnerCategory.repairRequest:
        return const Color(0xFFA34CF3);
      case AlertOwnerCategory.billReminder:
        return const Color(0xFF42A5F5);
      case AlertOwnerCategory.general:
        return const Color(0xFF66BB6A);
    }
  }

  Color get categoryBgColor {
    switch (category) {
      case AlertOwnerCategory.repairRequest:
        return const Color(0xFFF3E8FF);
      case AlertOwnerCategory.billReminder:
        return const Color(0xFFE3F2FD);
      case AlertOwnerCategory.general:
        return const Color(0xFFE8F5E9);
    }
  }
}
