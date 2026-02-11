import 'package:flutter/material.dart';

class AnnouncementContainer extends StatelessWidget {
  const AnnouncementContainer({
    super.key,
    required this.sideColor,
    required this.bgColor,
    required this.textColor,
    required this.icon,
    required this.title,
    required this.decscription,
  });

  final Color sideColor;
  final Color bgColor;
  final Color textColor;
  final Icon icon;
  final String title;
  final String decscription; 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: sideColor, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon.icon,
                color: textColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            decscription,
            style: TextStyle(fontSize: 13, color: textColor),
          ),
        ],
      ),
    );
  }
}
