import 'package:dormcare/model/repair_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dormcare/model/owner/bill_model.dart';
import 'package:dormcare/model/owner/room_model.dart';

import 'package:dormcare/theme/app_theme.dart';
import 'package:dormcare/utils/format.dart';

class RoomDetailScreen extends StatelessWidget {
  final RoomModel room;

  const RoomDetailScreen({super.key, required this.room});

  // enum RepairStatus { pending, inProgress, completed, cancelled }
  static final List<RepairModel> _allRepairs = [
    RepairModel(
      id: 'rep001',
      roomNumber: 'A101',
      title: 'Air conditioner broken',
      description: 'AC not cooling properly',
      tenantName: 'Somchai Prasert',
      phoneNumber: '089-123-8574',
      reportedAt: DateTime(2026, 2, 5),
      status: RepairStatus.pending,
      category: RepairCategory.appliance,
    ),
    RepairModel(
      id: 'rep002',
      roomNumber: 'B201',
      title: 'Water leak',
      description: 'Leak under sink',
      tenantName: 'Natcha Wong',
      phoneNumber: '081-456-7890',
      reportedAt: DateTime(2026, 2, 6),
      status: RepairStatus.inProgress,
      category: RepairCategory.plumbing,
    ),
    RepairModel(
      id: 'rep003',
      roomNumber: 'A102',
      title: 'Light bulb out',
      description: 'Bathroom light not working',
      tenantName: 'Somchai Prasert',
      phoneNumber: '089-123-8574',
      reportedAt: DateTime(2026, 1, 28),
      status: RepairStatus.completed,
      category: RepairCategory.electrical,
    ),
  ];

  static final List<BillModel> _allBills = [
    BillModel(
      billId: 'bill001',
      roomNumber: 'A101',
      postedDate: DateTime(2026, 1, 28),
      dueDate: DateTime(2026, 2, 5),
      rent: 3500,
      water: 12,
      waterUnit: 15,
      electric: 120,
      electricUnit: 7,
      other: 0,
      isPaid: true,
    ),
    BillModel(
      billId: 'bill002',
      roomNumber: 'A102',
      postedDate: DateTime(2026, 2, 28),
      dueDate: DateTime(2026, 5, 5),
      rent: 3500,
      water: 8,
      waterUnit: 15,
      electric: 90,
      electricUnit: 7,
      other: 0,
      isPaid: false,
    ),
    BillModel(
      billId: 'bill003',
      roomNumber: 'B201',
      postedDate: DateTime(2026, 1, 28),
      dueDate: DateTime(2026, 2, 5),
      rent: 4200,
      water: 15,
      waterUnit: 15,
      electric: 150,
      electricUnit: 7,
      other: 100,
      isPaid: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final roomBills = _allBills
        .where((b) => b.roomNumber == room.roomNumber)
        .toList();
    final roomRepairs = _allRepairs
        .where((r) => r.roomNumber == room.roomNumber)
        .toList();
    final latestBill = roomBills.isNotEmpty ? roomBills.last : null;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: AppColors.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Room ${room.roomNumber}',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'Floor ${room.roomFloor} · ${room.roomType}',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.textTertiary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'This feature is currently under development',
                    ),
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: const Icon(
                Icons.edit_outlined,
                size: 15,
                color: AppColors.ownerPrimary,
              ),
              label: const Text(
                'Edit',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.ownerPrimary,
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.divider, height: 1),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            _buildImage(),
            const SizedBox(height: 14),

            // Status chips row
            _buildStatusChips(latestBill),
            const SizedBox(height: 16),

            // Room info card
            _buildSectionCard(
              icon: Icons.meeting_room_outlined,
              title: 'Room Details',
              child: _buildInfoRows([
                ('Room Number', room.roomNumber),
                ('Floor', 'Floor ${room.roomFloor}'),
                ('Type', room.roomType),
                ('Monthly Rent', '${room.price.toInt()} THB / month'),
              ]),
            ),
            const SizedBox(height: 12),

            // Tenant info card
            _buildSectionCard(
              icon: Icons.person_outline,
              title: 'Tenant Information',
              child: room.isOccupied
                  ? _buildInfoRows([
                      ('Name', AppFormat.strOrDash(room.tenantName)),
                      ('Phone', AppFormat.strOrDash(room.tenantPhone)),
                      ('Email', AppFormat.strOrDash(room.tenantEmail)),
                      (
                        'Move-in Date',
                        AppFormat.dateOrDash(room.tenantMoveinDate),
                      ),
                      (
                        'Contract Ends',
                        AppFormat.dateOrDash(room.tenantContractEndDate),
                      ),
                    ])
                  : _buildEmptyHint(
                      Icons.person_off_outlined,
                      'No tenant currently',
                    ),
            ),
            const SizedBox(height: 12),

            // Latest bill card
            _buildSectionCard(
              icon: Icons.receipt_long_outlined,
              title: 'Latest Bill',
              child: latestBill != null
                  ? _buildBillContent(latestBill)
                  : _buildEmptyHint(
                      Icons.receipt_outlined,
                      'No bills posted yet',
                    ),
            ),
            const SizedBox(height: 12),

            // Maintenance card
            _buildSectionCard(
              icon: Icons.build_outlined,
              title: 'Maintenance Reports',
              child: roomRepairs.isEmpty
                  ? _buildEmptyHint(
                      Icons.check_circle_outline,
                      'No maintenance reports',
                    )
                  : Column(
                      children: roomRepairs
                          .map(
                            (r) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: _buildRepairRow(r),
                            ),
                          )
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: room.imageUrl.isNotEmpty
          ? AspectRatio(
              aspectRatio: 16 / 7,
              child: Image.network(
                room.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _imagePlaceholder(),
              ),
            )
          : _imagePlaceholder(),
    );
  }

  Widget _imagePlaceholder() {
    return AspectRatio(
      aspectRatio: 16 / 7,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_outlined, color: AppColors.textDisabled, size: 22),
            const SizedBox(width: 8),
            Text(
              'No image',
              style: TextStyle(color: AppColors.textDisabled, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChips(BillModel? latestBill) {
    return Wrap(
      spacing: 8,
      children: [
        _statusChip(
          label: room.isOccupied ? 'Occupied' : 'Vacant',
          color: room.isOccupied ? AppColors.ownerPrimary : AppColors.success,
          bg: room.isOccupied ? AppColors.ownerSoft : AppColors.successSoft,
          icon: room.isOccupied ? Icons.person : Icons.person_off_outlined,
        ),
        _statusChip(
          label: room.roomType,
          color: AppColors.billRent,
          bg: AppColors.tenantSoft,
          icon: Icons.category_outlined,
        ),
        if (latestBill != null)
          _statusChip(
            label: latestBill.isPaid ? 'Paid' : 'Unpaid',
            color: latestBill.isPaid ? AppColors.success : AppColors.warning,
            bg: latestBill.isPaid
                ? AppColors.successSoft
                : AppColors.warningSoft,
            icon: latestBill.isPaid
                ? Icons.check_circle_outline
                : Icons.pending_outlined,
          ),
      ],
    );
  }

  Widget _statusChip({
    required String label,
    required Color color,
    required Color bg,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppColors.ownerPrimary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 15, color: AppColors.ownerPrimary),
                ),
                const SizedBox(width: 9),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Container(height: 1, color: AppColors.divider),
          Padding(padding: const EdgeInsets.all(16), child: child),
        ],
      ),
    );
  }

  Widget _buildInfoRows(List<(String, String)> rows) {
    return Column(
      children: rows.asMap().entries.map((e) {
        final isLast = e.key == rows.length - 1;
        final (label, value) = e.value;
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            if (!isLast) ...[
              const SizedBox(height: 6),
              Divider(height: 1, thickness: 0.5, color: AppColors.divider),
              const SizedBox(height: 6),
            ],
          ],
        );
      }).toList(),
    );
  }

  Widget _buildBillContent(BillModel bill) {
    final isPaid = bill.isPaid;
    final statusColor = isPaid ? AppColors.success : AppColors.warning;
    final statusBg = isPaid ? AppColors.successSoft : AppColors.warningSoft;
    final monthLabel = DateFormat('MMMM yyyy').format(bill.postedDate);
    final dueLabel = DateFormat('d MMM yyyy').format(bill.dueDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Month + status
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              monthLabel,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isPaid
                        ? Icons.check_circle_outline
                        : Icons.pending_outlined,
                    size: 12,
                    color: statusColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isPaid ? 'Paid' : 'Unpaid',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Due $dueLabel',
          style: TextStyle(fontSize: 11, color: AppColors.textTertiary),
        ),
        const SizedBox(height: 12),
        // Breakdown chips
        Row(
          children: [
            Expanded(
              child: _buildBillChip(
                Icons.home_outlined,
                AppColors.billRent,
                AppColors.tenantSoft,
                'Rent',
                bill.rent.toInt(),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildBillChip(
                Icons.water_drop_outlined,
                AppColors.billWater,
                AppColors.billWaterSoft,
                'Water',
                (bill.water * bill.waterUnit).toInt(),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildBillChip(
                Icons.bolt_outlined,
                AppColors.warning,
                AppColors.billElecSoft,
                'Elec.',
                (bill.electric * bill.electricUnit).toInt(),
              ),
            ),
            if (bill.other > 0) ...[
              const SizedBox(width: 8),
              Expanded(
                child: _buildBillChip(
                  Icons.add_circle_outline,
                  AppColors.textTertiary,
                  AppColors.background,
                  'Other',
                  bill.other.toInt(),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 10),
        Divider(height: 1, thickness: 0.5, color: AppColors.divider),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${bill.total.toInt()}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                    height: 1,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 3, bottom: 1),
                  child: Text(
                    'THB',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBillChip(
    IconData icon,
    Color color,
    Color bgColor,
    String label,
    int amount,
  ) {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(height: 5),
          Text(
            '$amount',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: color,
              letterSpacing: -0.3,
              height: 1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: color.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRepairRow(RepairModel repair) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  repair.title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  repair.reportedDate,
                  style: TextStyle(fontSize: 11, color: AppColors.textTertiary),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: repair.statusBgColor, // ใช้ helper จาก model โดยตรง
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(repair.statusIcon, size: 11, color: repair.statusColor),
                const SizedBox(width: 4),
                Text(
                  repair.statusText,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: repair.statusColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyHint(IconData icon, String message) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textDisabled),
        const SizedBox(width: 8),
        Text(
          message,
          style: TextStyle(
            fontSize: 13,
            color: AppColors.textTertiary,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
