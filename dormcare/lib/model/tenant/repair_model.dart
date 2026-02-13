import 'package:flutter/material.dart';

enum RepairStatus { pending, inProgress, completed, cancelled }

class RepairModel {
  final String id;
  final String title;
  final String description;
  final String date;
  final String imageUrl;
  final RepairStatus status;

  RepairModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.imageUrl,
    required this.status,
  });

  // Helper สำหรับดึงสีตามสถานะ
  Color get statusColor {
    switch (status) {
      case RepairStatus.pending:
        return const Color(0xFFFFA726); // Orange
      case RepairStatus.inProgress:
        return const Color(0xFF42A5F5); // Blue
      case RepairStatus.completed:
        return const Color(0xFF66BB6A); // Green
      case RepairStatus.cancelled:
        return const Color(0xFFEF5350); // Red
    }
  }

  // Helper สำหรับดึงสีพื้นหลังตามสถานะ
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

  // Helper สำหรับดึงข้อความสถานะ
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
}
