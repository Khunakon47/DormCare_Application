import 'package:flutter/material.dart';

enum AlertCategory { general, parcel, bill, emergency }

class AlertModel {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt; // เปลี่ยนจาก String date
  final AlertCategory category;
  bool isRead;

  AlertModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.category,
    this.isRead = false,
  });

  // Helper: แสดงเวลา/วันที่ตาม context
  // ถ้าภายใน 24 ชั่วโมง → "09:45"
  // ถ้าเมื่อวาน → "Yesterday"
  // อื่นๆ → "10 Jan"
  String get displayDate {
    final now = DateTime.now();
    final diff = now.difference(createdAt);

    if (diff.inHours < 24) {
      final h = createdAt.hour.toString().padLeft(2, '0');
      final m = createdAt.minute.toString().padLeft(2, '0');
      return '$h:$m';
    }

    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final createdDay = DateTime(createdAt.year, createdAt.month, createdAt.day);
    if (createdDay == yesterday) return 'Yesterday';

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${createdAt.day} ${months[createdAt.month - 1]}';
  }

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
        return const Color(0xFFFFA726);
      case AlertCategory.bill:
        return const Color(0xFF7E57C2);
      case AlertCategory.emergency:
        return const Color(0xFFEF5350);
      case AlertCategory.general:
        return const Color(0xFF42A5F5);
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
