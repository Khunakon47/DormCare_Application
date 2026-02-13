import 'package:flutter/material.dart';

class HomeDashboardCard extends StatelessWidget {
  const HomeDashboardCard({
    super.key,
    required this.bgColor,
    required this.fgColor,
    required this.icon,
    required this.iconColor,
    required this.iconSize,
    required this.topRightText,
    this.topRightTextSize,
    this.totalUser,
    required this.bottomLeftText,
    this.bottomLeftTextSize, 
    this.currency,
    this.totalRoom,
    required this.isOwner,
    this.fontSize = 20,
  });

  final Color bgColor;
  final Color fgColor;
  final Icon icon;
  
  final Color iconColor;
  final double iconSize;
  final String topRightText;
  final int? totalUser;
  final double? topRightTextSize;
  final int? totalRoom;

  final String? currency;
  final String bottomLeftText;
  final double? bottomLeftTextSize;
  final bool isOwner;

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon.icon, color: iconColor, size: iconSize),
              Text(
                isOwner
                  ? "${topRightText.toString()} / ${totalRoom.toString()}"
                  : topRightText.toString(),
                style: TextStyle(color:fgColor, fontSize: topRightTextSize, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          SizedBox(
            width: double.infinity,
            child: Text(
              currency ?? '',
              style: TextStyle(fontSize: 12, color: fgColor),
              textAlign: TextAlign.right,
            ),
          ),

          SizedBox(height: 12),

          Text(
            bottomLeftText, 
            style: TextStyle(
              color: fgColor, 
              fontSize: bottomLeftTextSize
            )
          ),
        ],
      ),
    );
  }
}
