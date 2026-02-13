import 'package:flutter/material.dart';

class FilterSort extends StatelessWidget {

  final VoidCallback onPressed;
  final Icon? icon;
  final Color bgColor;
  final Color iconColor;
  final double iconSize;


  const FilterSort({
    super.key,
    required this.onPressed,
    this.icon,
    this.iconSize = 32,
    this.iconColor = Colors.red,
    this.bgColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
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
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon?.icon,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}