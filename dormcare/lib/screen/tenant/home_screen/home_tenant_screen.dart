import 'package:flutter/material.dart';

class HomeTenantScreen extends StatelessWidget {
  const HomeTenantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderCard(),
            const SizedBox(height: 14),
            _buildBillCard(),
            const SizedBox(height: 14),
            _buildStatRow(),
            const SizedBox(height: 20),
            _buildSectionLabel('Recent Repairs'),
            const SizedBox(height: 10),
            _buildRecentRepairs(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF367BF3), Color(0xFF2457D9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF367BF3).withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning 👋',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'JoBy Khuna',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildHeaderPill(Icons.meeting_room_outlined, 'Room 301'),
                    const SizedBox(width: 8),
                    _buildHeaderPill(Icons.apartment_outlined, 'Dorm 27'),
                  ],
                ),
              ],
            ),
          ),
          // Unread notification dot
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFA726),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                const Text(
                  '2 unread',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderPill(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.white70),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFEF5350).withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFEF5350).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.receipt_long_outlined,
              size: 22,
              color: Color(0xFFEF5350),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bill Due Soon',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0D1B2A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'January 2025 — due Jan 5',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                '3,212',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFEF5350),
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                'THB',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow() {
    final stats = [
      _StatData(
        icon: Icons.build_outlined,
        label: 'Pending\nRepairs',
        value: '2',
        color: const Color(0xFFFFA726),
      ),
      _StatData(
        icon: Icons.check_circle_outline,
        label: 'Completed\nRepairs',
        value: '5',
        color: const Color(0xFF66BB6A),
      ),
      _StatData(
        icon: Icons.notifications_outlined,
        label: 'Unread\nAlerts',
        value: '2',
        color: const Color(0xFF367BF3),
      ),
    ];

    return Row(
      children: stats.asMap().entries.map((e) {
        final isLast = e.key == stats.length - 1;
        return Expanded(
          child: Row(
            children: [
              Expanded(child: _buildStatCard(e.value)),
              if (!isLast) const SizedBox(width: 10),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatCard(_StatData data) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: data.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(data.icon, size: 16, color: data.color),
          ),
          const SizedBox(height: 10),
          Text(
            data.value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: data.color,
              letterSpacing: -0.5,
              height: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            data.label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Color(0xFF0D1B2A),
        letterSpacing: -0.2,
      ),
    );
  }

  Widget _buildRecentRepairs() {
    final repairs = [
      _RepairItem(
        'Air conditioner not cooling',
        'Dec 10, 2024',
        _RepairStatus.completed,
      ),
      _RepairItem('Leaking faucet', 'Dec 12, 2024', _RepairStatus.inProgress),
      _RepairItem(
        'Light bulb replacement',
        'Jan 5, 2025',
        _RepairStatus.inProgress,
      ),
      _RepairItem('Door lock jammed', 'Jan 8, 2025', _RepairStatus.pending),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: repairs.length,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          thickness: 0.5,
          indent: 56,
          color: Colors.grey.shade100,
        ),
        itemBuilder: (context, i) => _buildRepairTile(repairs[i]),
      ),
    );
  }

  Widget _buildRepairTile(_RepairItem item) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: item.status.color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(Icons.build_outlined, size: 17, color: item.status.color),
      ),
      title: Text(
        item.title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Color(0xFF0D1B2A),
        ),
      ),
      subtitle: Text(
        item.date,
        style: TextStyle(fontSize: 11, color: Colors.grey.shade400),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: item.status.color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          item.status.label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: item.status.color,
          ),
        ),
      ),
    );
  }
}

class _StatData {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _StatData({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });
}

enum _RepairStatus {
  pending,
  inProgress,
  completed;

  String get label {
    switch (this) {
      case _RepairStatus.pending:
        return 'Pending';
      case _RepairStatus.inProgress:
        return 'In Progress';
      case _RepairStatus.completed:
        return 'Done';
    }
  }

  Color get color {
    switch (this) {
      case _RepairStatus.pending:
        return const Color(0xFFFFA726);
      case _RepairStatus.inProgress:
        return const Color(0xFF42A5F5);
      case _RepairStatus.completed:
        return const Color(0xFF66BB6A);
    }
  }
}

class _RepairItem {
  final String title;
  final String date;
  final _RepairStatus status;
  const _RepairItem(this.title, this.date, this.status);
}
