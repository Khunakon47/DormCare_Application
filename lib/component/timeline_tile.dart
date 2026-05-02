import 'package:flutter/material.dart';
import 'package:dormcare/theme/app_theme.dart';

class TimelineTile extends StatelessWidget {
  final String label;
  final String subtitle;
  final Color color;
  final bool isDone;
  final bool isLast;

  const TimelineTile({
    super.key,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.isDone,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isDone ? color : AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2),
                boxShadow: isDone
                    ? [
                        BoxShadow(
                          color: color.withValues(alpha: 0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: isDone
                  ? const Icon(Icons.check, size: 14, color: AppColors.white)
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [color, color.withValues(alpha: 0.2)],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 14),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: isDone
                      ? AppColors.textPrimary
                      : AppColors.textTertiary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: AppColors.textTertiary),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}
