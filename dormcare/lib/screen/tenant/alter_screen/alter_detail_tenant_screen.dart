import 'package:dormcare/model/tenant/alert_model.dart';
import 'package:flutter/material.dart';

class AlertDetailTenantScreen extends StatelessWidget {
  final AlertModel data;

  const AlertDetailTenantScreen({super.key, required this.data});

  // ─── Build ───────────────────────────────────────────────────────────────

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
            _buildTimestamp(),
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

  Widget _buildTimestamp() {
    return Row(
      children: [
        Icon(Icons.access_time_outlined, size: 13, color: Colors.grey.shade400),
        const SizedBox(width: 5),
        Text(
          _fullDateTime(),
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade400,
            fontWeight: FontWeight.w500,
          ),
        ),
        if (!data.isRead) ...[
          const SizedBox(width: 10),
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: Color(0xFF367BF3),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          const Text(
            'Unread',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF367BF3),
              fontWeight: FontWeight.w600,
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

  // ─── Utils ────────────────────────────────────────────────────────────────

  String _fullDateTime() {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final d = data.createdAt;
    final h = d.hour.toString().padLeft(2, '0');
    final m = d.minute.toString().padLeft(2, '0');
    return '${d.day} ${months[d.month - 1]} ${d.year}  ·  $h:$m';
  }
}
