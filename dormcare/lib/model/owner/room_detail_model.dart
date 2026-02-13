import 'package:flutter/material.dart';

class RoomDetailModel {
  const RoomDetailModel({
    required this.bgColor,
    this.fgColor = Colors.white,
    required this.icon,
    required this.iconColor,
    required this.title,
    this.details,
    this.status,
    this.isStatus = false,
    this.isPaid = false,
  });

  final Color bgColor;
  final Color fgColor;
  final Icon icon;
  final Color iconColor;
  final String title;
  final Map<String, String>? details;
  final Map<String, Widget>? status;
  final bool isStatus;
  final bool isPaid;
}
