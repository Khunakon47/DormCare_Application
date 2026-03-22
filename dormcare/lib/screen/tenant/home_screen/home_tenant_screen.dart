import 'package:flutter/material.dart';
import 'package:dormcare/theme/app_theme.dart';
import 'package:dormcare/model/repair_model.dart';
import 'package:dormcare/component/stat_tenant_card.dart';

class HomeTenantScreen extends StatelessWidget {
  const HomeTenantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
            const SizedBox(height: 14),
            _buildSectionLabel('Recent Repairs'),
            const SizedBox(height: 8),
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
          colors: [AppColors.tenantPrimary, AppColors.tenantSecondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.tenantPrimary.withValues(alpha: 0.35),
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
                    color: AppColors.surface.withValues(alpha: 0.8),
                    fontSize: 14,
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
              border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.white,
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
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
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
              color: AppColors.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.receipt_long_outlined,
              size: 22,
              color: AppColors.error,
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
                    color: AppColors.textPrimary,
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
                  color: AppColors.error,
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
      StatTenantCard(
        icon: Icons.build_outlined,
        label: 'Pending\nRepairs',
        value: '2',
        color: AppColors.warning,
      ),
      StatTenantCard(
        icon: Icons.check_circle_outline,
        label: 'Completed\nRepairs',
        value: '5',
        color: AppColors.success,
      ),
      StatTenantCard(
        icon: Icons.notifications_outlined,
        label: 'Unread\nAlerts',
        value: '2',
        color: AppColors.tenantPrimary,
      ),
    ];

    return Row(
      children: stats.asMap().entries.map((e) {
        final isLast = e.key == stats.length - 1;
        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: StatTenantCard(
                  icon: e.value.icon,
                  label: e.value.label,
                  value: e.value.value,
                  color: e.value.color,
                ),
              ),
              if (!isLast) const SizedBox(width: 10),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.2,
      ),
    );
  }

  Widget _buildRecentRepairs() {
    final repairs = [
      RepairModel(
        id: '1',
        title: 'Air conditioner not cooling',
        description: '',
        roomNumber: '301',
        tenantName: 'JoBy Khuna',
        phoneNumber: '081-234-5678',
        reportedAt: DateTime(2024, 12, 10),
        status: RepairStatus.completed,
        category: RepairCategory.appliance,
      ),
      RepairModel(
        id: '2',
        title: 'Leaking faucet',
        description: '',
        roomNumber: '301',
        tenantName: 'JoBy Khuna',
        phoneNumber: '081-234-5678',
        reportedAt: DateTime(2024, 12, 12),
        status: RepairStatus.inProgress,
        category: RepairCategory.plumbing,
      ),
      RepairModel(
        id: '3',
        title: 'Light bulb replacement',
        description: '',
        roomNumber: '301',
        tenantName: 'JoBy Khuna',
        phoneNumber: '081-234-5678',
        reportedAt: DateTime(2025, 1, 5),
        status: RepairStatus.inProgress,
        category: RepairCategory.electrical,
      ),
      RepairModel(
        id: '4',
        title: 'Door lock jammed',
        description: '',
        roomNumber: '301',
        tenantName: 'JoBy Khuna',
        phoneNumber: '081-234-5678',
        reportedAt: DateTime(2025, 1, 8),
        status: RepairStatus.pending,
        category: RepairCategory.security,
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
        itemBuilder: (context, i) => _buildRepairTile(repairs[i]),
      ),
    );
  }

  Widget _buildRepairTile(RepairModel item) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: item.statusColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(Icons.build_outlined, size: 17, color: item.statusColor),
      ),
      title: Text(
        item.title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        item.reportedDate,
        style: TextStyle(fontSize: 11, color: Colors.grey.shade400),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: item.statusColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          item.statusText,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: item.statusColor,
          ),
        ),
      ),
    );
  }
}
