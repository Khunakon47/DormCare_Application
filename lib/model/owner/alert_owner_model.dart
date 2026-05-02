import 'package:flutter/material.dart';
import 'package:dormcare/utils/format.dart';
import 'package:dormcare/theme/app_theme.dart';

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

  String get displayDate => AppFormat.smart(createdAt);
  String get fullDateTime => AppFormat.dateTime(createdAt);

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
        return AppColors.ownerPrimary;
      case AlertOwnerCategory.billReminder:
        return AppColors.info;
      case AlertOwnerCategory.general:
        return AppColors.success;
    }
  }

  Color get categoryBgColor {
    switch (category) {
      case AlertOwnerCategory.repairRequest:
        return AppColors.ownerSoft;
      case AlertOwnerCategory.billReminder:
        return AppColors.infoSoft;
      case AlertOwnerCategory.general:
        return AppColors.successSoft;
    }
  }

  factory AlertOwnerModel.fromJson(Map<String, dynamic> json) {
    return AlertOwnerModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      category: AlertOwnerCategory.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => AlertOwnerCategory.general,
      ),
      roomNumber: json['roomNumber'] as String?,
      tenantName: json['tenantName'] as String?,
      isRead: json['isRead'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'category': category.name,
      'roomNumber': roomNumber,
      'tenantName': tenantName,
      'isRead': isRead,
    };
  }
}
