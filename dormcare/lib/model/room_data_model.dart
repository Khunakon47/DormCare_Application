import 'package:flutter/material.dart';

class RoomDataModel {
  final String imageUrl;
  final int roomNumber;
  final String userName;
  final String phoneNum;
  final double rentFee;

  final String roomStats;
  final Color roomStatsColor;
  final Color roomStatsBgColor;

  final String roomType;
  final Color roomTypeColor;
  final Color roomTypeBgColor;

  final Color viewBtnColor;
  final Color viewBtnTextColor;

  const RoomDataModel({
    this.imageUrl = "assets/images/Flower.png",
    this.roomNumber = 300,
    this.userName = "Hello",
    this.phoneNum = "123456789",
    this.rentFee = 120,

    this.roomStats = "Complete",
    this.roomType = "Single",

    this.roomStatsBgColor = Colors.purpleAccent,
    this.roomStatsColor = Colors.purple,

    this.roomTypeBgColor = Colors.greenAccent,
    this.roomTypeColor = Colors.green,

    this.viewBtnColor = Colors.purple,
    this.viewBtnTextColor = Colors.purple,
  });
}