import 'package:flutter/material.dart';
import '../../model/tenant/alert_model.dart';

class AlertCard extends StatelessWidget {
  final AlertModel data;
  final VoidCallback onTap;

  const AlertCard({super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: data.isRead ? const Color(0xFFF5F5F5) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: data.categoryBgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    data.categoryIcon,
                    color: data.categoryColor,
                    size: 26,
                  ),
                ),

                const SizedBox(width: 16),

                // 2. Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              data.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: data.isRead
                                    ? FontWeight.w600
                                    : FontWeight.bold,
                                color: Colors.black87,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // วันที่
                          Text(
                            data.date,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      // [เพิ่มส่วนนี้] Category Tag
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: data
                              .categoryBgColor, // ใช้สีพื้นหลังเดียวกับไอคอนแต่จางๆ
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: data.categoryColor.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          data.categoryText,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: data.categoryColor,
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        data.description,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // 3. Unread Indicator
                if (!data.isRead)
                  Container(
                    margin: const EdgeInsets.only(left: 8, top: 5),
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF3D00),
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
