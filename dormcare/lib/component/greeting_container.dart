import 'package:flutter/material.dart';

class GreetingContainer extends StatelessWidget {

  final String title;
  final String subtitle;
  
  final List<Color> gradientColor;
  final Color textColor;

  const GreetingContainer({
    super.key,
    required this.title,
    required this.subtitle,
    this.gradientColor = const [
      Color.fromARGB(255, 174, 54, 243), // started color
      Color.fromARGB(255, 139, 39, 233), // ended color
    ],
    this.textColor = Colors.white
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColor,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              subtitle,
              style: TextStyle(
                color: textColor.withValues(alpha: 0.8),
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
  }
}