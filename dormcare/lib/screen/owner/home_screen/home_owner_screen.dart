import 'package:flutter/material.dart';

class HomeOwnerScreen extends StatelessWidget {
  const HomeOwnerScreen({super.key});

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
            _buildStatsGrid(),
            const SizedBox(height: 14),
            _buildAlertBanner(),
            const SizedBox(height: 20),
            _buildSectionLabel('Recent Repair Requests'),
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
          colors: [Color(0xFFA34CF3), Color(0xFF5B3FBF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFA34CF3).withValues(alpha: 0.35),
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
                _buildHeaderPill(Icons.apartment_outlined, 'KKU Dorm 27'),
              ],
            ),
          ),
          // Occupancy pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text(
                  '45/50',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'occupied',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 10,
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

  Widget _buildStatsGrid() {
    final stats = [
      _StatData(
        Icons.attach_money,
        'Monthly Revenue',
        '8,097',
        'THB',
        const Color(0xFF66BB6A),
      ),
      _StatData(
        Icons.build_outlined,
        'Pending Repairs',
        '5',
        null,
        const Color(0xFFFFA726),
      ),
      _StatData(
        Icons.receipt_long_outlined,
        'Unpaid Bills',
        '2',
        'rooms',
        const Color(0xFFEF5350),
      ),
      _StatData(
        Icons.notifications_outlined,
        'Unread Alerts',
        '3',
        null,
        const Color(0xFF367BF3),
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2,
      children: stats.map((s) => _buildStatCard(s)).toList(),
    );
  }

  Widget _buildStatCard(_StatData data) {
    return Container(
      padding: const EdgeInsets.all(14),
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
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: data.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(data.icon, size: 18, color: data.color),
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
                      data.value,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: data.color,
                        letterSpacing: -0.5,
                        height: 1,
                      ),
                    ),
                    if (data.unit != null) ...[
                      const SizedBox(width: 3),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 1),
                        child: Text(
                          data.unit!,
                          style: TextStyle(
                            fontSize: 10,
                            color: data.color.withValues(alpha: 0.7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  data.label,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade400,
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

  Widget _buildAlertBanner() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEF5350).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFEF5350).withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFEF5350).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              size: 18,
              color: Color(0xFFEF5350),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Payment Reminder Needed',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFEF5350),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '12 rooms have unpaid bills — due Jan 5, 2025',
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xFFEF5350).withValues(alpha: 0.8),
                    height: 1.4,
                  ),
                ),
              ],
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
        'Room 301',
        'Air conditioner not cooling',
        'Dec 10, 2024',
        _RepairStatus.completed,
      ),
      _RepairItem(
        'Room 201',
        'Leaking faucet',
        'Dec 12, 2024',
        _RepairStatus.inProgress,
      ),
      _RepairItem(
        'Room 101',
        'Light bulb replacement',
        'Jan 5, 2025',
        _RepairStatus.pending,
      ),
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
        itemBuilder: (_, i) => _buildRepairTile(repairs[i]),
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
          color: const Color(0xFFA34CF3).withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.meeting_room_outlined,
          size: 17,
          color: Color(0xFFA34CF3),
        ),
      ),
      title: Text(
        '${item.room} — ${item.title}',
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
  final String? unit;
  final Color color;
  const _StatData(this.icon, this.label, this.value, this.unit, this.color);
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
  final String room;
  final String title;
  final String date;
  final _RepairStatus status;
  const _RepairItem(this.room, this.title, this.date, this.status);
}
