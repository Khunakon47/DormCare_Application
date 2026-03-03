import 'package:flutter/material.dart';
import 'package:dormcare/model/dashboard_card_model.dart';

class HomeDashboardCard extends StatelessWidget {
  const HomeDashboardCard({super.key, required this.model});

  final DashboardCardModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: model.bgColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
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
              Icon(
                model.icon.icon,
                color: model.iconColor,
                size: model.iconSize,
              ),
              Text(
                model.isRoomOccupiedCard
                    ? "${model.occupiedRoom} / ${model.totalRoom}"
                    : model.topRightText,
                style: TextStyle(
                  color: model.fgColor,
                  fontSize: model.topRightTextSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(
            width: double.infinity,
            child: Text(
              model.currency ?? '',
              style: TextStyle(fontSize: 12, color: model.fgColor),
              textAlign: TextAlign.right,
            ),
          ),

          SizedBox(height: 12),

          Text(
            model.title,
            style: TextStyle(color: model.fgColor, fontSize: model.titleSize),
          ),
        ],
      ),
    );
  }
}
