import 'package:dormcare/model/owner/alert_owner_model.dart';
import 'package:flutter/material.dart';

class AlertDetailOwnerScreen extends StatelessWidget {
  final AlertOwnerModel data;

  const AlertDetailOwnerScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text(
          'Notification',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(color: Colors.grey.shade300, height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryBadge(),
            const SizedBox(height: 14),
            _buildTitle(),
            const SizedBox(height: 8),
            _buildMeta(),
            const SizedBox(height: 20),
            const Divider(height: 1),
            const SizedBox(height: 20),
            _buildBody(),
          ],
        ),
      ),
    );
  }

  // ─── Private Helpers ─────────────────────────────────────────────────────

  Widget _buildCategoryBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: data.categoryBgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(data.categoryIcon, size: 14, color: data.categoryColor),
          const SizedBox(width: 6),
          Text(
            data.categoryText,
            style: TextStyle(
              color: data.categoryColor,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      data.title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: Color(0xFF0D1B2A),
        letterSpacing: -0.5,
        height: 1.3,
      ),
    );
  }

  Widget _buildMeta() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timestamp
        Row(
          children: [
            Icon(
              Icons.access_time_outlined,
              size: 13,
              color: Colors.grey.shade400,
            ),
            const SizedBox(width: 5),
            Text(
              data.fullDateTime,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        // Room info (ถ้ามี)
        if (data.roomNumber != null) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF3E8FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.meeting_room_outlined,
                  size: 16,
                  color: Color(0xFFA34CF3),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Room ${data.roomNumber}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFA34CF3),
                      ),
                    ),
                    if (data.tenantName != null)
                      Text(
                        data.tenantName!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildBody() {
    return Text(
      data.description,
      style: TextStyle(fontSize: 15, color: Colors.grey.shade700, height: 1.7),
    );
  }
}
