import 'package:flutter/material.dart';

enum AlertCategory { general, parcel, bill, emergency }

class AlertModel {
  final String id;
  final String title;
  final String description;
  final String date; // e.g. 'Today', 'Yesterday', '10 Jan'
  final AlertCategory category;
  bool isRead; // เพิ่มสถานะการอ่าน

  AlertModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.category,
    this.isRead = false,
  });

  // Helper: Icon ตามประเภท
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

  // Helper: สีหลัก (Icon & Text)
  Color get categoryColor {
    switch (category) {
      case AlertCategory.parcel:
        return const Color(0xFFFFA726); // Orange
      case AlertCategory.bill:
        return const Color(0xFF7E57C2); // Purple
      case AlertCategory.emergency:
        return const Color(0xFFEF5350); // Red
      case AlertCategory.general:
        return const Color(0xFF42A5F5); // Blue
    }
  }

  // Helper: สีพื้นหลัง Icon
  Color get categoryBgColor {
    switch (category) {
      case AlertCategory.parcel:
        return const Color(0xFFFFF3E0);
      case AlertCategory.bill:
        return const Color(0xFFEDE7F6);
      case AlertCategory.emergency:
        return const Color(0xFFFFEBEE);
      case AlertCategory.general:
        return const Color(0xFFE3F2FD);
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
