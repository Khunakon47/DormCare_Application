import 'package:dormcare/model/owner/alert_owner_model.dart';
import 'package:flutter/material.dart';

class AlertOwnerCard extends StatelessWidget {
  final AlertOwnerModel data;
  final VoidCallback onTap;

  const AlertOwnerCard({super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: data.isRead
                ? Colors.grey.shade100
                : data.categoryColor.withValues(alpha: 0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: data.categoryBgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  data.categoryIcon,
                  size: 20,
                  color: data.categoryColor,
                ),
              ),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            data.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: data.isRead
                                  ? FontWeight.w600
                                  : FontWeight.w700,
                              color: const Color(0xFF0D1B2A),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          data.displayDate,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                    if (data.roomNumber != null) ...[
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFFA34CF3,
                          ).withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.meeting_room_outlined,
                              size: 11,
                              color: Color(0xFFA34CF3),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Room ${data.roomNumber}'
                              '${data.tenantName != null ? '  ·  ${data.tenantName}' : ''}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFFA34CF3),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 5),
                    Text(
                      data.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              if (!data.isRead) ...[
                const SizedBox(width: 8),
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: const BoxDecoration(
                    color: Color(0xFFA34CF3),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
