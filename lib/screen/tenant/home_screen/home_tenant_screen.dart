import 'package:dormcare/model/repair_model.dart';
import 'package:dormcare/providers/user_provider.dart';
import 'package:dormcare/services/bill_service.dart';
import 'package:dormcare/services/notification_service.dart';
import 'package:dormcare/services/repair_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dormcare/theme/app_theme.dart';
import 'package:dormcare/component/stat_tenant_card.dart';

class HomeTenantScreen extends StatelessWidget {
  const HomeTenantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();
    final billService = BillService();
    final repairService = RepairService();
    final notifService = NotificationService();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderCard(user),
            const SizedBox(height: 14),
            // Bill + Stats + Recent Repairs จาก Firestore
            StreamBuilder(
              stream: billService.getBillsByTenant(user.uid),
              builder: (context, billSnap) {
                return StreamBuilder(
                  stream: repairService.getRepairsByTenant(user.uid),
                  builder: (context, repairSnap) {
                    return StreamBuilder(
                      stream: notifService.getTenantNotifications(user.uid),
                      builder: (context, notifSnap) {
                        final bills = billSnap.data ?? [];
                        final repairs = repairSnap.data ?? [];
                        final notifs = notifSnap.data ?? [];

                        // หาบิลที่ยังไม่จ่าย (ล่าสุด)
                        final unpaidBill = bills
                            .where((b) => !b.isPaid)
                            .toList();
                        final currentBill = unpaidBill.isNotEmpty
                            ? unpaidBill.first
                            : null;

                        final pendingCount = repairs
                            .where((r) => r.status == RepairStatus.pending)
                            .length;
                        final completedCount = repairs
                            .where((r) => r.status == RepairStatus.completed)
                            .length;
                        final unreadCount = notifs
                            .where((n) => !n.isRead)
                            .length;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (currentBill != null)
                              _buildBillCard(currentBill),
                            if (currentBill != null) const SizedBox(height: 14),
                            _buildStatRow(
                              pending: pendingCount,
                              completed: completedCount,
                              unread: unreadCount,
                            ),
                            const SizedBox(height: 14),
                            _buildSectionLabel('Recent Repairs'),
                            const SizedBox(height: 8),
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
                Row(
                  children: [
                    _buildHeaderPill(
                      Icons.meeting_room_outlined,
                      'Room ${user.roomNumber}',
                    ),
                    const SizedBox(width: 8),
                    _buildHeaderPill(Icons.apartment_outlined, user.dormId),
                  ],
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

  Widget _buildBillCard(dynamic bill) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
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
                  'Due ${bill.dueDate.day}/${bill.dueDate.month}/${bill.dueDate.year}',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${bill.total.toInt()}',
                style: const TextStyle(
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
                  color: AppColors.textTertiary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow({
    required int pending,
    required int completed,
    required int unread,
  }) {
    return Row(
      children: [
        Expanded(
          child: StatTenantCard(
            icon: Icons.build_outlined,
            label: 'Pending\nRepairs',
            value: '$pending',
            color: AppColors.warning,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: StatTenantCard(
            icon: Icons.check_circle_outline,
            label: 'Completed\nRepairs',
            value: '$completed',
            color: AppColors.success,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: StatTenantCard(
            icon: Icons.notifications_outlined,
            label: 'Unread\nAlerts',
            value: '$unread',
            color: AppColors.tenantPrimary,
          ),
        ),
      ],
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
    final recent = repairs.take(4).toList();

    if (recent.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
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
        borderRadius: BorderRadius.circular(16),
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
        itemBuilder: (context, i) => _buildRepairTile(recent[i]),
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
        style: TextStyle(fontSize: 11, color: AppColors.textTertiary),
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
