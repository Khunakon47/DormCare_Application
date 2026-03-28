import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:dormcare/model/owner/bill_model.dart';
import 'package:dormcare/model/owner/room_model.dart';
import 'monthly_payment_owner_screen.dart';
import 'post_bill_room_select_screen.dart';
import 'package:dormcare/theme/app_theme.dart';

class BillsOwnerScreen extends StatefulWidget {
  const BillsOwnerScreen({super.key});

  @override
  State<BillsOwnerScreen> createState() => _BillsOwnerScreenState();
}

class _BillsOwnerScreenState extends State<BillsOwnerScreen> {
  int? _selectedYear; // null = All

  final List<BillModel> _allBills = [
    BillModel(
      billId: 'bill001',
      roomNumber: 'A101',
      postedDate: DateTime(2026, 1, 28),
      dueDate: DateTime(2026, 2, 5),
      rent: 3500,
      waterRate: 12,
      waterUnit: 15,
      electricRate: 120,
      electricUnit: 7,
      other: 0,
      isPaid: true,
    ),
    BillModel(
      billId: 'bill002',
      roomNumber: 'A102',
      postedDate: DateTime(2026, 1, 28),
      dueDate: DateTime(2026, 2, 5),
      rent: 3500,
      waterRate: 8,
      waterUnit: 15,
      electricRate: 90,
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
      waterRate: 15,
      waterUnit: 15,
      electricRate: 150,
      electricUnit: 7,
      other: 100,
      isPaid: true,
    ),
    BillModel(
      billId: 'bill004',
      roomNumber: 'A101',
      postedDate: DateTime(2025, 12, 28),
      dueDate: DateTime(2026, 1, 5),
      rent: 3500,
      waterRate: 10,
      waterUnit: 15,
      electricRate: 110,
      electricUnit: 7,
      other: 0,
      isPaid: true,
    ),
    BillModel(
      billId: 'bill005',
      roomNumber: 'B201',
      postedDate: DateTime(2025, 12, 28),
      dueDate: DateTime(2026, 1, 5),
      rent: 4200,
      waterRate: 12,
      waterUnit: 15,
      electricRate: 130,
      electricUnit: 7,
      other: 0,
      isPaid: true,
    ),
  ];

  final List<RoomModel> _roomList = [
    RoomModel(
      roomId: 'r001',
      imageUrl: '',
      roomNumber: 'A101',
      roomFloor: '1',
      roomType: 'Single',
      price: 3500,
      isOccupied: true,
      tenantName: 'Somchai P.',
      tenantPhone: '089-123-8574',
      tenantEmail: 'somchai@gmail.com',
      tenantMoveinDate: DateTime(2024, 9, 1),
      tenantContractEndDate: DateTime(2025, 5, 31),
    ),
    RoomModel(
      roomId: 'r002',
      imageUrl: '',
      roomNumber: 'A102',
      roomFloor: '1',
      roomType: 'Studio',
      price: 3500,
      isOccupied: true,
      tenantName: 'Nattaya W.',
      tenantPhone: '082-345-6789',
      tenantEmail: 'nattaya@gmail.com',
      tenantMoveinDate: DateTime(2024, 10, 1),
      tenantContractEndDate: DateTime(2025, 9, 30),
    ),
    RoomModel(
      roomId: 'r003',
      imageUrl: '',
      roomNumber: 'B201',
      roomFloor: '2',
      roomType: 'Single',
      price: 4200,
      isOccupied: true,
      tenantName: 'Mika T.',
      tenantPhone: '088-777-6666',
      tenantEmail: 'mika@gmail.com',
      tenantMoveinDate: DateTime(2026, 2, 5),
      tenantContractEndDate: DateTime(2026, 5, 5),
    ),
  ];

  // Fixed year options
  static const List<int> _yearOptions = [2026, 2025, 2024, 2023, 2022];

  Map<String, List<BillModel>> get _grouped {
    final filtered = _selectedYear == null
        ? _allBills
        : _allBills.where((b) => b.postedDate.year == _selectedYear).toList();
    final map = <String, List<BillModel>>{};
    for (final b in filtered) {
      final key =
          '${b.postedDate.year}-${b.postedDate.month.toString().padLeft(2, '0')}';
      map.putIfAbsent(key, () => []).add(b);
    }
    return map;
  }

  List<String> get _sortedKeys {
    final keys = _grouped.keys.toList()..sort((a, b) => b.compareTo(a));
    return keys;
  }

  void _showMonthPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _MonthPickerSheet(
        onSelected: (year, month) {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PostBillRoomSelectScreen(
                year: year,
                month: month,
                roomList: _roomList,
                existingBills: _allBills,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showMonthPicker,
        backgroundColor: AppColors.ownerPrimary,
        elevation: 2,
        icon: const Icon(Icons.add, color: AppColors.white, size: 18),
        label: const Text(
          'Post New Bills',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            _buildYearTabs(),
            const SizedBox(height: 10),
            _buildListHeader(),
            const SizedBox(height: 6),
            Expanded(
              child: _sortedKeys.isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
                      itemCount: _sortedKeys.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) => _MonthBillCard(
                        bills: _grouped[_sortedKeys[index]]!,
                        roomList: _roomList,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYearTabs() {
    // null = All, followed by fixed year options
    final options = <int?>[null, ..._yearOptions];

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: options.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final year = options[index];
          final isSelected = _selectedYear == year;
          final label = year == null ? 'All' : '$year';
          return GestureDetector(
            onTap: () => setState(() => _selectedYear = year),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.ownerPrimary : AppColors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.ownerPrimary : AppColors.border,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.ownerPrimary.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? AppColors.white : AppColors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildListHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _selectedYear == null ? 'All years' : '$_selectedYear',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '${_sortedKeys.length} months',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.divider,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.receipt_long_outlined,
              size: 32,
              color: AppColors.textDisabled,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _selectedYear == null
                ? 'No bills found'
                : 'No bills for $_selectedYear',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Tap + Post New Bills to get started',
            style: TextStyle(color: AppColors.textTertiary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _MonthBillCard extends StatelessWidget {
  final List<BillModel> bills;
  final List<RoomModel> roomList;

  const _MonthBillCard({required this.bills, required this.roomList});

  @override
  Widget build(BuildContext context) {
    final paid = bills.where((b) => b.isPaid).length;
    final unpaid = bills.length - paid;
    final total = bills.length;
    final pct = total == 0 ? 0 : ((paid / total) * 100).round();
    final collected = bills
        .where((b) => b.isPaid)
        .fold(0.0, (s, b) => s + b.total);
    final pending = bills
        .where((b) => !b.isPaid)
        .fold(0.0, (s, b) => s + b.total);
    final monthLabel = DateFormat('MMMM yyyy').format(bills.first.postedDate);
    final dueLabel = DateFormat('d MMM yyyy').format(bills.first.dueDate);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.ownerPrimary, AppColors.ownerDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          monthLabel,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.4,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.schedule_outlined,
                              size: 11,
                              color: AppColors.white.withValues(alpha: 0.65),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Due $dueLabel',
                              style: TextStyle(
                                color: AppColors.white.withValues(alpha: 0.75),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$pct%',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Collection rate',
                        style: TextStyle(
                          color: AppColors.white.withValues(alpha: 0.7),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Body
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  // Collected / Pending amount tiles
                  Row(
                    children: [
                      Expanded(
                        child: _buildAmountTile(
                          color: AppColors.successDark,
                          bgColor: AppColors.successSoft,
                          amount: collected,
                          label: 'THB collected',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildAmountTile(
                          color: AppColors.warning,
                          bgColor: AppColors.warningSoft,
                          amount: pending,
                          label: 'THB pending',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Stat pills — paid / unpaid / billed
                  Row(
                    children: [
                      _buildStatPill(
                        icon: Icons.check_circle_outline,
                        color: AppColors.successDark,
                        bgColor: AppColors.successSoft,
                        value: '$paid',
                        label: 'Paid rooms',
                      ),
                      const SizedBox(width: 8),
                      _buildStatPill(
                        icon: Icons.pending_outlined,
                        color: AppColors.warning,
                        bgColor: AppColors.warningSoft,
                        value: '$unpaid',
                        label: 'Unpaid rooms',
                      ),
                      const SizedBox(width: 8),
                      _buildStatPill(
                        icon: Icons.receipt_outlined,
                        color: AppColors.ownerPrimary,
                        bgColor: AppColors.ownerSoft,
                        value: '$total',
                        label: 'Bills issued',
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Manage payments button
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MonthlyPaymentScreen(
                            bills: bills,
                            roomList: roomList,
                          ),
                        ),
                      ),
                      icon: const Icon(
                        Icons.payments_outlined,
                        size: 16,
                        color: AppColors.ownerPrimary,
                      ),
                      label: const Text(
                        'Manage Payments',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.ownerPrimary,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.ownerSoft,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: AppColors.ownerBorder),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountTile({
    required Color color,
    required Color bgColor,
    required double amount,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${amount.toInt()}',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: color,
              letterSpacing: -0.5,
              height: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatPill({
    required IconData icon,
    required Color color,
    required Color bgColor,
    required String value,
    required String label,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 13, color: color),
            const SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: color,
                height: 1,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                color: color.withValues(alpha: 0.75),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MonthPickerSheet extends StatefulWidget {
  final void Function(int year, int month) onSelected;
  const _MonthPickerSheet({required this.onSelected});

  @override
  State<_MonthPickerSheet> createState() => _MonthPickerSheetState();
}

class _MonthPickerSheetState extends State<_MonthPickerSheet> {
  final _now = DateTime.now();
  late int _year;
  late int _month;

  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  @override
  void initState() {
    super.initState();
    _year = _now.year;
    _month = _now.month;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Month',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.textDeep,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Choose the billing period',
            style: TextStyle(fontSize: 12, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _arrowBtn(Icons.chevron_left, () {
                if (_year > _now.year - 2) setState(() => _year--);
              }),
              const SizedBox(width: 28),
              Text(
                '$_year',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDeep,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(width: 28),
              _arrowBtn(Icons.chevron_right, () {
                if (_year < _now.year + 1) setState(() => _year++);
              }),
            ],
          ),

          const SizedBox(height: 20),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 2.2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 12,
            itemBuilder: (_, i) {
              final m = i + 1;
              final isSelected = _month == m;
              final isFuture = DateTime(_year, m).isAfter(_now);
              return GestureDetector(
                onTap: isFuture ? null : () => setState(() => _month = m),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.ownerPrimary
                        : isFuture
                        ? AppColors.background
                        : AppColors.divider,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      _months[i],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isSelected
                            ? AppColors.white
                            : isFuture
                            ? AppColors.textDisabled
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.ownerPrimary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              onPressed: () => widget.onSelected(_year, _month),
              child: Text(
                'Continue with ${_months[_month - 1]} $_year',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _arrowBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.divider,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 20, color: AppColors.textSecondary),
      ),
    );
  }
}
