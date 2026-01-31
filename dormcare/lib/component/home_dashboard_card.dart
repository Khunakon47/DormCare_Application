import 'package:flutter/material.dart';

class HomeDashboardCard extends StatelessWidget {
  const HomeDashboardCard({
    super.key,
    required this.icon,
    required this.coloricon,
    required this.iconsize,
    required this.num,
    this.currency,
    required this.title,

    this.boxColor = const Color.fromARGB(255, 255, 255, 255),
    this.textColor = Colors.black,
  });

  final Icon icon;
  final Color coloricon;
  final double iconsize;
  final int num;
  final String? currency;
  final String title;

  // Added
  final Color boxColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: boxColor,
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
              Icon(icon.icon, color: coloricon, size: iconsize),
              Text(
                num.toString(),
                style: TextStyle(color:textColor, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          SizedBox(
            width: double.infinity,
            child: Text(
              currency ?? '',
              style: TextStyle(fontSize: 12, color: textColor),
              textAlign: TextAlign.right,
            ),
          ),

          SizedBox(height: 12),

          Text(title, style: TextStyle(color: textColor, fontSize: 12)),
        ],
      ),
    );
  }
}
