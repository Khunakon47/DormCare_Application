import 'package:dormcare/model/owner/bill_model.dart';
import 'package:dormcare/model/owner/room_model.dart';
import 'package:dormcare/screen/owner/bills_screen/bill_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dormcare/theme/app_theme.dart';
import 'package:dormcare/component/bill_room_card.dart';

class MonthlyPaymentScreen extends StatefulWidget {
  final List<BillModel> bills;
  final List<RoomModel> roomList;

  const MonthlyPaymentScreen({
    super.key,
    required this.bills,
    required this.roomList,
  });

  @override
  State<MonthlyPaymentScreen> createState() => _MonthlyPaymentScreenState();
}

class _MonthlyPaymentScreenState extends State<MonthlyPaymentScreen> {
  late List<BillModel> _bills;

  @override
  void initState() {
    super.initState();
    _bills = List.from(widget.bills);
  }

  // ─── Computed ────────────────────────────────────────────────────────────

  int get _paidCount => _bills.where((b) => b.isPaid).length;
  int get _unpaidCount => _bills.length - _paidCount;
  double get _collected =>
      _bills.where((b) => b.isPaid).fold(0, (s, b) => s + b.total);
  double get _pending =>
      _bills.where((b) => !b.isPaid).fold(0, (s, b) => s + b.total);

  RoomModel? _roomFor(BillModel bill) {
    try {
      return widget.roomList.firstWhere((r) => r.roomNumber == bill.roomNumber);
    } catch (_) {
      return null;
    }
  }

  Future<void> _openDetail(BillModel bill) async {
    final idx = _bills.indexOf(bill);
    final result = await Navigator.push<BillModel>(
      context,
      MaterialPageRoute(
        builder: (_) => BillDetailScreen(bill: bill, room: _roomFor(bill)),
      ),
    );
    if (result != null && mounted) setState(() => _bills[idx] = result);
  }

  // ─── Build ───────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final monthLabel = DateFormat('MMMM yyyy').format(_bills.first.postedDate);
    final dueLabel = DateFormat('d MMM yyyy').format(_bills.first.dueDate);
    final total = _bills.length;
    final pct = total == 0 ? 0.0 : _paidCount / total;

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
              monthLabel,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'Payment Management',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.textTertiary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.divider, height: 1),
        ),
      ),
      body: Column(
        children: [
          _buildSummaryPanel(pct, total, dueLabel),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_bills.length} rooms billed',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Due $dueLabel',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textTertiary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 48),
              itemCount: _bills.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) => BillRoomCard(
                bill: _bills[index],
                room: _roomFor(_bills[index]),
                onManage: () => _openDetail(_bills[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Summary panel ────────────────────────────────────────────────────────

  Widget _buildSummaryPanel(double pct, int total, String dueLabel) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildSummaryTile(
                  icon: Icons.check_circle_outline,
                  color: AppColors.success,
                  bgColor: AppColors.successSoft,
                  label: 'Collected',
                  amount: _collected,
                  sub: '$_paidCount rooms',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildSummaryTile(
                  icon: Icons.pending_outlined,
                  color: AppColors.warning,
                  bgColor: AppColors.warningSoft,
                  label: 'Pending',
                  amount: _pending,
                  sub: '$_unpaidCount rooms',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: SizedBox(
                    height: 7,
                    child: Stack(
                      children: [
                        Container(color: AppColors.divider),
                        FractionallySizedBox(
                          widthFactor: pct.clamp(0.0, 1.0),
                          child: Container(color: AppColors.success),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${(pct * 100).round()}%',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '$_paidCount of $total rooms paid',
              style: TextStyle(fontSize: 11, color: AppColors.textTertiary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryTile({
    required IconData icon,
    required Color color,
    required Color bgColor,
    required String label,
    required double amount,
    required String sub,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 13),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 12, color: color),
              const SizedBox(width: 5),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                NumberFormat('#,##0').format(amount.toInt()),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: color,
                  letterSpacing: -0.5,
                  height: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, bottom: 2),
                child: Text(
                  'THB',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: color.withValues(alpha: 0.65),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            sub,
            style: TextStyle(
              fontSize: 10,
              color: color.withValues(alpha: 0.65),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
