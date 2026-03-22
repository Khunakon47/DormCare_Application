import 'package:dormcare/utils/format.dart';
import 'package:flutter/material.dart';

enum RepairStatus { pending, inProgress, completed, cancelled }

enum RepairCategory { electrical, plumbing, furniture, appliance, other }

class RepairModel {
  final String id;
  final String title;
  final String description;
  final DateTime reportedAt;
  final String? imageUrl;
  final RepairStatus status;
  final RepairCategory category;

  RepairModel({
    required this.id,
    required this.title,
    required this.description,
    required this.reportedAt,
    this.imageUrl,
    required this.status,
    required this.category,
  });

  // Format helpers
  String get reportedTime => AppFormat.time(reportedAt);
  String get reportedDate => AppFormat.date(reportedAt);

  // Status helpers
  Color get statusColor {
    switch (status) {
      case RepairStatus.pending:
        return const Color(0xFFFFA726);
      case RepairStatus.inProgress:
        return const Color(0xFF42A5F5);
      case RepairStatus.completed:
        return const Color(0xFF66BB6A);
      case RepairStatus.cancelled:
        return const Color(0xFFEF5350);
    }
  }

  Color get statusBgColor {
    switch (status) {
      case RepairStatus.pending:
        return const Color(0xFFFFE0B2);
      case RepairStatus.inProgress:
        return const Color(0xFFBBDEFB);
      case RepairStatus.completed:
        return const Color(0xFFC8E6C9);
      case RepairStatus.cancelled:
        return const Color(0xFFFFCDD2);
    }
  }

  String get statusText {
    switch (status) {
      case RepairStatus.pending:
        return 'Pending';
      case RepairStatus.inProgress:
        return 'In Progress';
      case RepairStatus.completed:
        return 'Completed';
      case RepairStatus.cancelled:
        return 'Cancelled';
    }
  }

  IconData get statusIcon {
    switch (status) {
      case RepairStatus.pending:
        return Icons.schedule;
      case RepairStatus.inProgress:
        return Icons.autorenew;
      case RepairStatus.completed:
        return Icons.check_circle_outline;
      case RepairStatus.cancelled:
        return Icons.cancel_outlined;
    }
  }

  // Category helpers
  String get categoryText {
    switch (category) {
      case RepairCategory.electrical:
        return 'Electrical';
      case RepairCategory.plumbing:
        return 'Plumbing';
      case RepairCategory.furniture:
        return 'Furniture';
      case RepairCategory.appliance:
        return 'Appliance';
      case RepairCategory.other:
        return 'Other';
    }
  }

  IconData get categoryIcon {
    switch (category) {
      case RepairCategory.electrical:
        return Icons.bolt_outlined;
      case RepairCategory.plumbing:
        return Icons.water_drop_outlined;
      case RepairCategory.furniture:
        return Icons.chair_outlined;
      case RepairCategory.appliance:
        return Icons.kitchen_outlined;
      case RepairCategory.other:
        return Icons.build_outlined;
    }
  }
}
