import 'package:flutter/material.dart';

class RecentRepairModel {
  const RecentRepairModel({
    this.roomNumber,
    required this.title,
    required this.date,
    required this.month,
    required this.year,
    required this.statusIcon,
  });

  final String? roomNumber;
  final String title;
  final int date;
  final String month;
  final int year;
  final Icon statusIcon;
}
