import 'package:flutter/material.dart';

class RoomDetailModel {
  const RoomDetailModel({
    required this.bgColor,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.details,
    this.isStatus = false,
    this.isPaid = false,
  });

  final Color bgColor;
  final Icon icon;
  final Color iconColor;
  final String title;
  final Map<String, String> details;
  final bool isStatus;
  final bool isPaid;
}
