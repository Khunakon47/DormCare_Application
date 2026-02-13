import 'package:flutter/material.dart';

class Progressbar extends StatelessWidget {

  final Color bgColor;
  final double opacity;
  final Color fgColor;
  final double values;
  final double height;
  final double radius;
  
  const Progressbar({
    super.key,
    this.bgColor = Colors.grey,
    this.opacity = 0.25,
    this.fgColor = Colors.amber,
    this.values = 100,
    this.height = 8,
    this.radius = 50,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: LinearProgressIndicator(
        value: values,
        minHeight: height,
        backgroundColor: bgColor.withValues(
          alpha: opacity,
        ),
        color: fgColor,
      ),
    );
  }
}