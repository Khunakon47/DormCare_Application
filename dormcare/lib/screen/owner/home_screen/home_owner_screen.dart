import 'package:flutter/material.dart';
import 'package:dormcare/theme/app_theme.dart';
import 'package:dormcare/model/owner/repair_owner_model.dart';
import 'package:dormcare/component/stat_owner_card.dart';

class HomeOwnerScreen extends StatelessWidget {
  const HomeOwnerScreen({super.key});

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
            const SizedBox(height: 16),
            _buildStatsGrid(),
            const SizedBox(height: 16),
            _buildAlertBanner(),
            const SizedBox(height: 16),
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
          colors: [AppColors.ownerPrimary, AppColors.ownerSecondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.ownerPrimary.withValues(alpha: 0.35),
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
                  'JoBy Khunakon',
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
              border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
              borderRadius: BorderRadius.circular(12),
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
      StatOwnerCard(
        icon: Icons.attach_money,
        label: 'Monthly Revenue',
        value: '8,097',
        color: AppColors.success,
      ),
      StatOwnerCard(
        icon: Icons.build_outlined,
        label: 'Pending Repairs',
        value: '5',
        color: AppColors.warning,
      ),
      StatOwnerCard(
        icon: Icons.receipt_long_outlined,
        label: 'Unpaid Bills',
        value: '2',
        color: AppColors.error,
      ),
      StatOwnerCard(
        icon: Icons.notifications_outlined,
        label: 'Unread Alerts',
        value: '3',
        color: AppColors.billRent,
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2,
      children: stats.map((stat) => stat).toList(),
    );
  }

  Widget _buildAlertBanner() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              size: 18,
              color: AppColors.error,
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
                    color: AppColors.error,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '12 rooms have unpaid bills — due Jan 5, 2025',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.error.withValues(alpha: 0.8),
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
        color: AppColors.textPrimary,
        letterSpacing: -0.2,
      ),
    );
  }

  Widget _buildRecentRepairs() {
    final repairs = <RepairOwnerModel>[
      RepairOwnerModel(
        id: "1",
        title: "Air conditioner not cooling",
        description: "The air conditioner in room 301 is not cooling properly.",
        roomNumber: "301",
        tenantName: "John Doe",
        phoneNumber: "+1234567890",
        reportedAt: DateTime(2024, 12, 10),
        status: RepairOwnerStatus.completed,
      ),
      RepairOwnerModel(
        id: "2",
        title: "Leaking faucet",
        roomNumber: "201",
        description: "The faucet in the bathroom of room 201 is leaking.",
        tenantName: "Jane Smith",
        phoneNumber: "+0987654321",
        reportedAt: DateTime(2024, 12, 12),
        status: RepairOwnerStatus.inProgress,
      ),
      RepairOwnerModel(
        id: "3",
        title: "Light bulb replacement",
        roomNumber: "101",
        description: "The light bulb in room 101 needs to be replaced.",
        tenantName: "Alice Johnson",
        phoneNumber: "+1122334455",
        reportedAt: DateTime(2024, 12, 15),
        status: RepairOwnerStatus.pending,
      ),
      RepairOwnerModel(
        id: "4",
        title: "Leaking faucet",
        roomNumber: "201",
        description: "The faucet in the bathroom of room 201 is leaking.",
        tenantName: "Bob Wilson",
        phoneNumber: "+1122334455",
        reportedAt: DateTime(2024, 12, 12),
        status: RepairOwnerStatus.inProgress,
      ),
      RepairOwnerModel(
        id: "5",
        title: "Light bulb replacement",
        roomNumber: "101",
        description: "The light bulb in room 101 needs to be replaced.",
        tenantName: "Charlie Brown",
        phoneNumber: "+5544332211",
        reportedAt: DateTime(2024, 12, 15),
        status: RepairOwnerStatus.pending,
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
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
        itemBuilder: (context, index) => _buildRepairTile(repairs[index]),
      ),
    );
  }

  Widget _buildRepairTile(RepairOwnerModel item) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      // Icon pill
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.ownerPrimary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.meeting_room_outlined,
          size: 17,
          color: AppColors.ownerPrimary,
        ),
      ),
      // Title
      title: Text(
        '${item.roomNumber} — ${item.title}',
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      // Subtitle
      subtitle: Text(
        item.reportedDate,
        style: TextStyle(fontSize: 11, color: Colors.grey.shade400),
      ),
      // Status pill
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: item.statusColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: item.statusColor.withValues(alpha: 0.25)),
        ),
        child: Text(
          item.statusText,
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            color: item.statusColor,
          ),
        ),
      ),
    );
  }
}
