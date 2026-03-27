import 'package:flutter/material.dart';
import 'package:dormcare/theme/app_theme.dart';

class StatOwnerCard extends StatelessWidget {
  const StatOwnerCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.unit,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final String? unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: color,
                        letterSpacing: -0.5,
                        height: 1,
                      ),
                    ),
                    if (unit != null) ...[
                      const SizedBox(width: 3),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 1),
                        child: Text(
                          unit!,
                          style: TextStyle(
                            fontSize: 10,
                            color: color.withValues(alpha: 0.7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.textTertiary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
