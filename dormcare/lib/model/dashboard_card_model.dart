import 'package:flutter/material.dart';

class DashboardCardModel {
  const DashboardCardModel({
    this.bgColor = Colors.white,
    this.fgColor = Colors.black,
    required this.icon,
    this.iconColor = Colors.white,
    this.iconSize = 26,

    required this.topRightText,
    this.topRightTextSize = 24,

    this.isRoomOccupiedCard = false,
    this.occupiedRoom,
    this.totalRoom,

    this.currency,

    required this.title,
    this.titleSize = 14,
  });

  final Color bgColor;
  final Color fgColor;
  final Icon icon;
  final Color iconColor;
  final double iconSize;

  final String topRightText;
  final double topRightTextSize;

  final bool isRoomOccupiedCard;
  final int? occupiedRoom;
  final int? totalRoom;

  final String? currency;

  final String title;
  final double titleSize;
}
