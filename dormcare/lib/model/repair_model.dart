import 'package:flutter/material.dart';
import 'package:dormcare/utils/format.dart';
import 'package:dormcare/theme/app_theme.dart';

enum RepairStatus { pending, inProgress, completed, cancelled }

enum RepairCategory {
  electrical,
  plumbing,
  furniture,
  appliance,
  security,
  other,
}

class RepairModel {
  final String id;
  final String title;
  final String description;
  final String roomNumber;
  final String tenantName;
  final String phoneNumber;
  final DateTime reportedAt;
  final String? imageUrl;
  RepairStatus status; // ไม่ final เพราะ owner ต้อง update ได้
  final RepairCategory category;

  RepairModel({
    required this.id,
    required this.title,
    required this.description,
    required this.roomNumber,
    required this.tenantName,
    required this.phoneNumber,
    required this.reportedAt,
    this.imageUrl,
    required this.status,
    required this.category,
  });

  String get reportedTime => AppFormat.time(reportedAt);
  String get reportedDate => AppFormat.date(reportedAt);

  Color get statusColor {
    switch (status) {
      case RepairStatus.pending:
        return AppColors.statusPending;
      case RepairStatus.inProgress:
        return AppColors.statusInProgress;
      case RepairStatus.completed:
        return AppColors.statusCompleted;
      case RepairStatus.cancelled:
        return AppColors.statusCancelled;
    }
  }

  Color get statusBgColor {
    switch (status) {
      case RepairStatus.pending:
        return AppColors.statusPendingSoft;
      case RepairStatus.inProgress:
        return AppColors.statusInProgressSoft;
      case RepairStatus.completed:
        return AppColors.statusCompletedSoft;
      case RepairStatus.cancelled:
        return AppColors.statusCancelledSoft;
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
      case RepairCategory.security:
        return 'Security';
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
      case RepairCategory.security:
        return Icons.security_outlined;
      case RepairCategory.other:
        return Icons.build_outlined;
    }
  }

  factory RepairModel.fromJson(Map<String, dynamic> json) {
    return RepairModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      roomNumber: json['roomNumber'] as String,
      tenantName: json['tenantName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      reportedAt: DateTime.parse(json['reportedAt'] as String),
      imageUrl: json['imageUrl'] as String?,
      status: RepairStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => RepairStatus.pending,
      ),
      category: RepairCategory.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => RepairCategory.other,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'roomNumber': roomNumber,
      'tenantName': tenantName,
      'phoneNumber': phoneNumber,
      'reportedAt': reportedAt.toIso8601String(),
      'imageUrl': imageUrl,
      'status': status.name,
      'category': category.name,
    };
  }

  RepairModel copyWith({RepairStatus? status}) {
    return RepairModel(
      id: id,
      title: title,
      description: description,
      roomNumber: roomNumber,
      tenantName: tenantName,
      phoneNumber: phoneNumber,
      reportedAt: reportedAt,
      imageUrl: imageUrl,
      status: status ?? this.status,
      category: category,
    );
  }
}
