import 'package:dormcare/model/repair_model.dart';
import 'package:dormcare/providers/user_provider.dart';
import 'package:dormcare/services/bill_service.dart';
import 'package:dormcare/services/repair_service.dart';
import 'package:dormcare/services/room_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dormcare/theme/app_theme.dart';
import 'package:dormcare/component/stat_owner_card.dart';

class HomeOwnerScreen extends StatelessWidget {
  const HomeOwnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();
    final repairService = RepairService();
    final billService = BillService();
    final roomService = RoomService();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderCard(user),
            const SizedBox(height: 16),
            // Stats จาก Firestore
            StreamBuilder(
              stream: roomService.getRoomsByDorm(user.dormId),
              builder: (context, roomSnap) {
                return StreamBuilder(
                  stream: repairService.getRepairsByDorm(user.dormId),
                  builder: (context, repairSnap) {
                    return StreamBuilder(
                      stream: billService.getBillsByDorm(user.dormId),
                      builder: (context, billSnap) {
                        final rooms = roomSnap.data ?? [];
                        final repairs = repairSnap.data ?? [];
                        final bills = billSnap.data ?? [];

                        final occupiedCount = rooms
                            .where((r) => r.isOccupied)
                            .length;
                        final totalCount = rooms.length;
                        final pendingRepairs = repairs
                            .where((r) => r.status == RepairStatus.pending)
                            .length;
                        final unpaidBills = bills
                            .where((b) => !b.isPaid)
                            .length;
                        final monthlyRevenue = bills
                            .where((b) => b.isPaid)
                            .fold(0.0, (s, b) => s + b.total);

                        return Column(
                          children: [
                            _buildStatsGrid(
                              revenue: monthlyRevenue,
                              pendingRepairs: pendingRepairs,
                              unpaidBills: unpaidBills,
                              occupied: occupiedCount,
                              total: totalCount,
                            ),
                            if (unpaidBills > 0) ...[
                              const SizedBox(height: 16),
                              _buildAlertBanner(unpaidBills),
                            ],
                            const SizedBox(height: 16),
                            _buildSectionLabel('Recent Repair Requests'),
                            const SizedBox(height: 10),
                            _buildRecentRepairs(repairs),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard(UserProvider user) {
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
                    color: AppColors.white.withValues(alpha: 0.8),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.name.isEmpty ? 'Loading...' : user.name,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 12),
                _buildHeaderPill(Icons.apartment_outlined, user.dormId),
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
        color: AppColors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.white.withValues(alpha: 0.7)),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid({
    required double revenue,
    required int pendingRepairs,
    required int unpaidBills,
    required int occupied,
    required int total,
  }) {
    final stats = [
      StatOwnerCard(
        icon: Icons.attach_money,
        label: 'Revenue (Paid)',
        value: revenue.toInt().toString(),
        color: AppColors.success,
        unit: 'THB',
      ),
      StatOwnerCard(
        icon: Icons.build_outlined,
        label: 'Pending Repairs',
        value: pendingRepairs.toString(),
        color: AppColors.warning,
      ),
      StatOwnerCard(
        icon: Icons.receipt_long_outlined,
        label: 'Unpaid Bills',
        value: unpaidBills.toString(),
        color: AppColors.error,
      ),
      StatOwnerCard(
        icon: Icons.meeting_room_outlined,
        label: 'Occupancy',
        value: '$occupied/$total',
        color: AppColors.ownerPrimary,
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2,
      children: stats,
    );
  }

  Widget _buildAlertBanner(int unpaidCount) {
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
                  '$unpaidCount rooms have unpaid bills',
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

  Widget _buildRecentRepairs(List<RepairModel> repairs) {
    // แสดงแค่ 5 อันล่าสุด
    final recent = repairs.take(5).toList();

    if (recent.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider),
        ),
        child: Center(
          child: Text(
            'No repair requests yet',
            style: TextStyle(color: AppColors.textTertiary, fontSize: 13),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: recent.length,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          thickness: 0.5,
          indent: 56,
          color: AppColors.divider,
        ),
        itemBuilder: (context, index) => _buildRepairTile(recent[index]),
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
          color: AppColors.ownerPrimary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.meeting_room_outlined,
          size: 17,
          color: AppColors.ownerPrimary,
        ),
      ),
      title: Text(
        '${item.roomNumber} — ${item.title}',
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        item.reportedDate,
        style: TextStyle(fontSize: 11, color: AppColors.textTertiary),
      ),
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
