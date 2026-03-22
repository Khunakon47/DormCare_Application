import 'package:flutter/material.dart';
import 'package:dormcare/model/owner/bill_model.dart';
import 'package:dormcare/model/owner/room_model.dart';
import 'package:dormcare/theme/app_theme.dart';
import 'package:intl/intl.dart';

class BillRoomCard extends StatelessWidget {
  final BillModel bill;
  final RoomModel? room;
  final VoidCallback onManage;

  const BillRoomCard({
    super.key,
    required this.bill,
    required this.room,
    required this.onManage,
  });

  @override
  Widget build(BuildContext context) {
    final isPaid = bill.isPaid;
    final statusColor = isPaid
        ? AppColors.success
        : AppColors.warning;
    final statusBg = isPaid ? AppColors.successSoft : AppColors.warningSoft;
    final statusLabel = isPaid ? 'Paid' : 'Unpaid';
    final statusIcon = isPaid
        ? Icons.check_circle_outline
        : Icons.radio_button_unchecked;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPaid
              ? AppColors.success.withValues(alpha: 0.25)
              : AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 13, 14, 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.ownerPrimary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.meeting_room_outlined,
                        size: 12,
                        color: AppColors.ownerPrimary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        bill.roomNumber,
                        style: const TextStyle(
                          color: AppColors.ownerPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        room?.tenantName ?? '—',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (room?.roomType != null)
                        Text(
                          room!.roomType,
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textHint,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, size: 11, color: statusColor),
                      const SizedBox(width: 4),
                      Text(
                        statusLabel,
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
          ),

          Divider(height: 1, thickness: 0.5, color: AppColors.border),

          // Breakdown chips
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
            child: Row(
              children: [
                Expanded(
                  child: _buildChip(
                    Icons.home_outlined,
                    AppColors.billRent,
                    AppColors.billRentSoft,
                    'Rent',
                    bill.rent.toInt(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildChip(
                    Icons.water_drop_outlined,
                    AppColors.billWater,
                    AppColors.billWaterSoft,
                    'Water',
                    (bill.water * bill.waterUnit).toInt(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildChip(
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
                    child: _buildChip(
                      Icons.add_circle_outline,
                      AppColors.textHint,
                      AppColors.divider,
                      'Other',
                      bill.other.toInt(),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Footer
          Container(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.textHint,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          NumberFormat('#,##0').format(bill.total.toInt()),
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                            letterSpacing: -0.5,
                            height: 1,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 3, bottom: 2),
                          child: Text(
                            'THB',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textHint,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onManage,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.ownerPrimary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.ownerPrimary.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.payments_outlined,
                          size: 14,
                          color: AppColors.ownerPrimary,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Manage',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.ownerPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(
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
}
