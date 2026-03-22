import 'package:flutter/material.dart';

enum AlertOwnerCategory { repairRequest, billReminder, general }

class AlertOwnerModel {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final AlertOwnerCategory category;
  final String? roomNumber; // มีเมื่อ category == repairRequest
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

  // ─── Display helpers ──────────────────────────────────────────────────────

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

  String get fullDateTime {
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
    final h = createdAt.hour.toString().padLeft(2, '0');
    final m = createdAt.minute.toString().padLeft(2, '0');
    return '${createdAt.day} ${months[createdAt.month - 1]} ${createdAt.year}  ·  $h:$m';
  }

  // ─── Category helpers ─────────────────────────────────────────────────────

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
