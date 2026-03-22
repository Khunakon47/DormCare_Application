import 'package:dormcare/utils/format.dart';
import 'package:flutter/material.dart';

enum RepairOwnerStatus { pending, inProgress, completed, cancelled }

class RepairOwnerModel {
  final String id;
  final String title;
  final String description;
  final String roomNumber;
  final String tenantName;
  final String phoneNumber;
  final String? imageUrl;
  final DateTime reportedAt;
  RepairOwnerStatus status;

  RepairOwnerModel({
    required this.id,
    required this.title,
    required this.description,
    required this.roomNumber,
    required this.tenantName,
    required this.phoneNumber,
    this.imageUrl,
    required this.reportedAt,
    required this.status,
  });

  // Format helpers
  String get reportedDate => AppFormat.date(reportedAt);
  String get reportedTime => AppFormat.time(reportedAt);

  // Status helpers
  Color get statusColor {
    switch (status) {
      case RepairOwnerStatus.pending:
        return const Color(0xFFFFA726);
      case RepairOwnerStatus.inProgress:
        return const Color(0xFF42A5F5);
      case RepairOwnerStatus.completed:
        return const Color(0xFF66BB6A);
      case RepairOwnerStatus.cancelled:
        return const Color(0xFFEF5350);
    }
  }

  Color get statusBgColor {
    switch (status) {
      case RepairOwnerStatus.pending:
        return const Color(0xFFFFE0B2);
      case RepairOwnerStatus.inProgress:
        return const Color(0xFFBBDEFB);
      case RepairOwnerStatus.completed:
        return const Color(0xFFC8E6C9);
      case RepairOwnerStatus.cancelled:
        return const Color(0xFFFFCDD2);
    }
  }

  String get statusText {
    switch (status) {
      case RepairOwnerStatus.pending:
        return 'Pending';
      case RepairOwnerStatus.inProgress:
        return 'In Progress';
      case RepairOwnerStatus.completed:
        return 'Completed';
      case RepairOwnerStatus.cancelled:
        return 'Cancelled';
    }
  }

  IconData get statusIcon {
    switch (status) {
      case RepairOwnerStatus.pending:
        return Icons.schedule;
      case RepairOwnerStatus.inProgress:
        return Icons.autorenew;
      case RepairOwnerStatus.completed:
        return Icons.check_circle_outline;
      case RepairOwnerStatus.cancelled:
        return Icons.cancel_outlined;
    }
  }
}
