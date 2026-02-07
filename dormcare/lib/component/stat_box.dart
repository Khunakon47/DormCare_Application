import 'package:flutter/material.dart';

class StatBox extends StatelessWidget {

  final String title;
  final String value;
  final String amount;
  final Color color;

  const StatBox({
    super.key,
    required this.title,
    required this.value,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 10, color: color)),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(amount, style: TextStyle(fontSize: 10, color: color)),
          ],
        ),
      ),
    );
  }
}