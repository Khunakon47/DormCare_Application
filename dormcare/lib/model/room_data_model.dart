import 'package:flutter/material.dart';

class RoomDataModel {
  final String imageUrl;
  final int roomNumber;
  final int roomFloor;

  final String userName;
  final String phoneNum;

  final double rentFee;
  final double deposit;

  final String roomStats;
  final Color roomStatsColor;
  final Color roomStatsBgColor;

  final String roomType;
  final Color roomTypeColor;
  final Color roomTypeBgColor;

  final Color viewBtnColor;
  final Color viewBtnTextColor;

  final int totalUser;
  final int totalUserPaid;
  final int totalUserUnpaid;
  final String postedDate;
  final String postedMY;
  final String dueDate;
  final int totalRoom;

  final String repairStatus;
  final String repairTitle;


  const RoomDataModel({
    this.rentFee = 2500,
    this.deposit = 5000,

    this.totalRoom = 50,

    this.totalUser = 45,
    this.totalUserPaid = 33,
    this.totalUserUnpaid = 12,
    
    this.postedDate = "Dec 25, 2025",
    this.dueDate = "Jan 5, 2026",
    this.postedMY = "December 2025",

    this.imageUrl = "assets/images/Flower.png",
    this.roomNumber = 300,
    this.roomFloor = 2,
    this.userName = "John Doe",
    this.phoneNum = "123456789",

    this.roomStats = "Occupied",
    this.roomType = "Single",

    this.roomStatsBgColor = Colors.purpleAccent,
    this.roomStatsColor = Colors.purple,

    this.roomTypeBgColor = Colors.greenAccent,
    this.roomTypeColor = Colors.green,

    this.viewBtnColor = Colors.purple,
    this.viewBtnTextColor = Colors.purple,

    this.repairStatus = "completed",
    this.repairTitle = "TV Not Woring"
  });
}