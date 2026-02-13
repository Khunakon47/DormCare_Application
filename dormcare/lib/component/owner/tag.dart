import 'package:flutter/material.dart';

enum StatusType { payment, repair, room, roomStatus }

class Tag extends StatelessWidget {
  const Tag({
    super.key,
    required this.type,
    required this.value,
    required this.text,
    this.radius = 20,
    this.fontWeight = FontWeight.bold,
    this.fontSize = 12,
  });

  final StatusType type;
  final dynamic value;
  final String text;
  final double radius;
  final double fontSize;
  final FontWeight fontWeight;

  Color? _getBgColor() {
    switch (type) {
      case StatusType.payment:
        final bool? paid = value as bool?;
        if (paid == null) return null;
        return paid
            ? Colors.greenAccent.withValues(alpha: 0.25)
            : Colors.redAccent.withValues(alpha: 0.25);

      case StatusType.repair:
        final String? status = value as String?;
        if (status!.toLowerCase() == "completed"){
          return Colors.greenAccent.withValues(alpha: 0.25);
        } else if (status.toLowerCase() == "pending"){
          return Colors.orangeAccent.withValues(alpha: 0.25);
        } else {
          return Colors.redAccent.withValues(alpha: 0.25);
        }

      case StatusType.room:
        final String? roomType = value as String?;
        if (roomType!.toLowerCase() == "single"){
          return Colors.greenAccent.withValues(alpha: 0.25);
        } else if (roomType.toLowerCase() == "studio"){
          return Colors.purpleAccent.withValues(alpha: 0.25);
        } else{
          return Colors.blueAccent.withValues(alpha: 0.25);
        }

      case StatusType.roomStatus:
        final String? roomStats = value as String?;
        if (roomStats!.toLowerCase() == "occupied"){
          return Colors.orangeAccent.withValues(alpha: 0.25);
        } else{
          return Colors.blueAccent.withValues(alpha: 0.25);
        }
    }
  }

  Color? _getFgColor() {
    switch (type) {
      case StatusType.payment:
        final bool? paid = value as bool?;
        if (paid == null) return null;
        return paid
            ? Colors.green
            : Colors.red;

      case StatusType.repair:
        final String? status = value as String?;
        if (status!.toLowerCase() == "completed"){
          return Colors.green;
        } else if (status.toLowerCase() == "pending"){
          return Colors.orange;
        } else {
          return Colors.red;
        }

      case StatusType.room:
        final String? roomType = value as String?;
        if (roomType!.toLowerCase() == "single"){
          return Colors.green;
        } else if (roomType.toLowerCase() == "studio"){
          return Colors.purple;
        } else {
          return Colors.blue;
        }

      case StatusType.roomStatus:
        final String? roomStats = value as String?;
        if (roomStats!.toLowerCase() == "occupied"){
          return Colors.orange;
        } else{
          return Colors.blue;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: _getBgColor(),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: _getFgColor(),
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
