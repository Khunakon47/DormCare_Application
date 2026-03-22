import 'package:dormcare/model/owner/monthly_billing_model.dart';
import 'package:dormcare/model/owner/room_model.dart';
import 'package:dormcare/screen/owner/bills_screen/bill_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthlyPaymentScreen extends StatefulWidget {
  final List<MonthlyBillingModel> bills;
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
  late List<MonthlyBillingModel> _bills;

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

  RoomModel? _roomFor(MonthlyBillingModel bill) {
    try {
      return widget.roomList.firstWhere((r) => r.roomNumber == bill.roomNumber);
    } catch (_) {
      return null;
    }
  }

  Future<void> _openDetail(MonthlyBillingModel bill) async {
    final idx = _bills.indexOf(bill);
    final result = await Navigator.push<MonthlyBillingModel>(
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
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: Color(0xFF0D1B2A),
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
                color: Color(0xFF0D1B2A),
              ),
            ),
            Text(
              'Payment Management',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade100, height: 1),
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
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Due $dueLabel',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade400,
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
              itemBuilder: (context, index) => _RoomCard(
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
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildSummaryTile(
                  icon: Icons.check_circle_outline,
                  color: const Color(0xFF66BB6A),
                  bgColor: const Color(0xFFE8F5E9),
                  label: 'Collected',
                  amount: _collected,
                  sub: '$_paidCount rooms',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildSummaryTile(
                  icon: Icons.pending_outlined,
                  color: const Color(0xFFFFA726),
                  bgColor: const Color(0xFFFFF8E1),
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
                        Container(color: Colors.grey.shade100),
                        FractionallySizedBox(
                          widthFactor: pct.clamp(0.0, 1.0),
                          child: Container(color: const Color(0xFF66BB6A)),
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
                  color: Color(0xFF66BB6A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '$_paidCount of $total rooms paid',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade400),
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

// ─── Room Card ────────────────────────────────────────────────────────────────

class _RoomCard extends StatelessWidget {
  final MonthlyBillingModel bill;
  final RoomModel? room;
  final VoidCallback onManage;

  const _RoomCard({
    required this.bill,
    required this.room,
    required this.onManage,
  });

  @override
  Widget build(BuildContext context) {
    final isPaid = bill.isPaid;
    final statusColor = isPaid
        ? const Color(0xFF66BB6A)
        : const Color(0xFFFFA726);
    final statusBg = isPaid ? const Color(0xFFE8F5E9) : const Color(0xFFFFF8E1);
    final statusLabel = isPaid ? 'Paid' : 'Unpaid';
    final statusIcon = isPaid
        ? Icons.check_circle_outline
        : Icons.radio_button_unchecked;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPaid
              ? const Color(0xFF66BB6A).withValues(alpha: 0.25)
              : Colors.grey.shade100,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Header ──────────────────────────────────────────────────
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
                    color: const Color(0xFFA34CF3).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.meeting_room_outlined,
                        size: 12,
                        color: Color(0xFFA34CF3),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        bill.roomNumber,
                        style: const TextStyle(
                          color: Color(0xFFA34CF3),
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
                          color: Color(0xFF0D1B2A),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (room?.roomType != null)
                        Text(
                          room!.roomType,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade400,
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

          Divider(height: 1, thickness: 0.5, color: Colors.grey.shade100),

          // ── Breakdown chips ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
            child: Row(
              children: [
                Expanded(
                  child: _buildChip(
                    Icons.home_outlined,
                    const Color(0xFF367BF3),
                    const Color(0xFFEFF6FF),
                    'Rent',
                    bill.rent.toInt(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildChip(
                    Icons.water_drop_outlined,
                    const Color(0xFF00BCD4),
                    const Color(0xFFECFEFF),
                    'Water',
                    (bill.water * bill.waterUnit).toInt(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildChip(
                    Icons.bolt_outlined,
                    const Color(0xFFFFA726),
                    const Color(0xFFFFFBEB),
                    'Elec.',
                    (bill.electric * bill.electricUnit).toInt(),
                  ),
                ),
                if (bill.other > 0) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildChip(
                      Icons.add_circle_outline,
                      Colors.grey.shade400,
                      Colors.grey.shade50,
                      'Other',
                      bill.other.toInt(),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // ── Footer — total + manage button ───────────────────────────
          Container(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
              border: Border(top: BorderSide(color: Colors.grey.shade100)),
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
                        color: Colors.grey.shade400,
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
                            color: Color(0xFF0D1B2A),
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
                              color: Color(0xFF9AA5B4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                // ── Manage button — sole tap target ──────────────────
                GestureDetector(
                  onTap: onManage,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFA34CF3).withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFFA34CF3).withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.payments_outlined,
                          size: 14,
                          color: Color(0xFFA34CF3),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Manage',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFA34CF3),
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
