import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  const Tag({
    super.key,
    required this.bgColor,
    required this.fgColor,
    required this.text
  });

  final Color bgColor;
  final Color fgColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fgColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
