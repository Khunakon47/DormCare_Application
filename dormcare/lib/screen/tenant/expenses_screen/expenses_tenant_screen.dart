import 'package:flutter/material.dart';
import 'package:dormcare/model/tenant/expense_model.dart';
import 'package:dormcare/theme/app_theme.dart';

class ExpensesTenantScreen extends StatefulWidget {
  const ExpensesTenantScreen({super.key});

  @override
  State<ExpensesTenantScreen> createState() => _ExpensesTenantScreenState();
}

class _ExpensesTenantScreenState extends State<ExpensesTenantScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<ExpenseModel> _allBills = [
    ExpenseModel(
      id: '1',
      month: 'December',
      year: '2024',
      roomRent: 2500,
      waterUnits: 18,
      electricityUnits: 150,
      status: ExpenseStatus.unpaid,
      billDate: '22 Jan 2025',
      dueDate: '5 Jan 2025',
      paidDate: '',
    ),
    ExpenseModel(
      id: '2',
      month: 'November',
      year: '2024',
      roomRent: 2500,
      waterUnits: 15,
      electricityUnits: 135,
      status: ExpenseStatus.paid,
      billDate: '',
      dueDate: '',
      paidDate: 'Paid on Nov 1, 2024',
    ),
    ExpenseModel(
      id: '3',
      month: 'October',
      year: '2024',
      roomRent: 2500,
      waterUnits: 15,
      electricityUnits: 160,
      status: ExpenseStatus.paid,
      billDate: '',
      dueDate: '',
      paidDate: 'Paid on Oct 1, 2024',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentBill = _allBills.firstWhere(
      (e) => e.status == ExpenseStatus.unpaid,
      orElse: () => _allBills[0],
    );

    final historyBills = _allBills
        .where((e) => e.status == ExpenseStatus.paid)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildCurrentTab(currentBill),
                _buildHistoryTab(historyBills),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.tenantSoft,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.tenantPrimary.withValues(alpha: 0.15),
          ),
        ),
        child: TabBar(
          controller: _tabController,
          labelColor: AppColors.surface,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: 0.1,
          ),
          unselectedLabelColor: AppColors.tenantPrimary.withValues(alpha: 0.6),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          indicator: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.tenantPrimary, AppColors.tenantDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.tenantPrimary.withValues(alpha: 0.35),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          tabs: const [
            Tab(height: 40, text: 'Current Bill'),
            Tab(height: 40, text: 'History'),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentTab(ExpenseModel bill) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      child: Column(
        children: [
          _buildCurrentHeroCard(bill),
          const SizedBox(height: 14),
          _buildBreakdownCard(bill),
          const SizedBox(height: 14),
          _buildInfoCard(
            icon: Icons.calendar_today_outlined,
            title: 'Bill Update Schedule',
            description:
                'Bills are posted on the 25th of each month. Payment deadline is the 5th of the following month.',
            accentColor: AppColors.tenantPrimary,
          ),
          const SizedBox(height: 10),
          _buildInfoCard(
            icon: Icons.location_on_outlined,
            title: 'Payment Location',
            description:
                'Management office, ground floor. Mon-Fri 8:00-17:00, Sat 9:00-12:00',
            accentColor: AppColors.warning,
          ),
          const SizedBox(height: 14),
          _buildReportButton(),
        ],
      ),
    );
  }

  Widget _buildCurrentHeroCard(ExpenseModel bill) {
    final isPaid = bill.isPaid;

    return Container(
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
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -30,
            right: -20,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface.withValues(alpha: 0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            left: 60,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface.withValues(alpha: 0.04),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${bill.month} ${bill.year}',
                            style: const TextStyle(
                              color: AppColors.surface,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.schedule_rounded,
                                size: 11,
                                color: AppColors.surface.withValues(alpha: 0.6),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Due: ${bill.dueDate}',
                                style: TextStyle(
                                  color: AppColors.surface.withValues(
                                    alpha: 0.65,
                                  ),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Status badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: isPaid
                            ? AppColors.surface.withValues(alpha: 0.2)
                            : AppColors.surface.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: AppColors.surface.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.circle_rounded,
                            size: 12,
                            color: isPaid
                                ? AppColors.success
                                : AppColors.statusCancelled.withValues(
                                    alpha: 0.9,
                                  ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            isPaid ? 'Paid' : 'Unpaid',
                            style: TextStyle(
                              color: AppColors.surface.withValues(alpha: 0.9),
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                // Total amount
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${bill.totalAmount}',
                      style: const TextStyle(
                        color: AppColors.surface,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -2,
                        height: 1,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        'THB',
                        style: TextStyle(
                          color: AppColors.surface.withValues(alpha: 0.9),
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Divider
                Container(
                  height: 1,
                  color: AppColors.surface.withValues(alpha: 0.15),
                ),

                const SizedBox(height: 16),

                // Mini breakdown pills
                Row(
                  children: [
                    _buildMiniPill(
                      Icons.home_rounded,
                      '${bill.roomRent}',
                      'Rent',
                      AppColors.onGradientRent,
                    ),
                    const SizedBox(width: 8),
                    _buildMiniPill(
                      Icons.water_drop_rounded,
                      '${bill.waterBill}',
                      'Water',
                      AppColors.onGradientWater,
                    ),
                    const SizedBox(width: 8),
                    _buildMiniPill(
                      Icons.bolt_rounded,
                      '${bill.electricityBill}',
                      'Elec.',
                      AppColors.onGradientElec,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniPill(
    IconData icon,
    String value,
    String label,
    Color iconColor,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.surface.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.surface.withValues(alpha: 0.15)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 13, color: iconColor),
            const SizedBox(width: 6),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: AppColors.surface,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      color: AppColors.surface,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreakdownCard(ExpenseModel bill) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
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
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Row(
              children: [
                const Text(
                  'Bill  Breakdown',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                Text(
                  'Bill date: ${bill.billDate}',
                  style: TextStyle(fontSize: 11, color: AppColors.textTertiary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          _buildBreakdownRow(
            icon: Icons.home_rounded,
            iconColor: AppColors.tenantPrimary,
            label: 'Room Rent',
            subtitle: 'Monthly payment',
            amount: bill.roomRent,
          ),
          Divider(
            height: 1,
            thickness: 0.5,
            indent: 56,
            color: AppColors.divider,
          ),
          _buildBreakdownRow(
            icon: Icons.water_drop_rounded,
            iconColor: AppColors.billWater,
            label: 'Water Bill',
            subtitle: '${bill.waterUnits} units × ${bill.waterRate} THB',
            amount: bill.waterBill,
          ),
          Divider(
            height: 1,
            thickness: 0.5,
            indent: 56,
            color: AppColors.divider,
          ),
          _buildBreakdownRow(
            icon: Icons.bolt_rounded,
            iconColor: AppColors.warning,
            label: 'Electricity Bill',
            subtitle:
                '${bill.electricityUnits} units × ${bill.electricityRate} THB',
            amount: bill.electricityBill,
          ),

          // Total row
          Container(
            margin: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.tenantPrimary, AppColors.tenantDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppColors.tenantPrimary.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.summarize_rounded,
                  size: 16,
                  color: AppColors.white.withValues(alpha: 0.7),
                ),
                const SizedBox(width: 8),
                Text(
                  'Total Due',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white.withValues(alpha: 0.7),
                  ),
                ),
                const Spacer(),
                Text(
                  '${bill.totalAmount}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: AppColors.surface,
                    letterSpacing: -1,
                    height: 1,
                  ),
                ),
                const SizedBox(width: 5),
                Padding(
                  padding: EdgeInsets.only(bottom: 1),
                  child: Text(
                    'THB',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white.withValues(alpha: 0.6),
                      letterSpacing: 0.5,
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

  Widget _buildBreakdownRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String subtitle,
    required int amount,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: iconColor.withValues(alpha: 0.2)),
            ),
            child: Icon(icon, size: 17, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 11, color: AppColors.textTertiary),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$amount',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'THB',
                style: TextStyle(fontSize: 10, color: AppColors.textTertiary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String description,
    required Color accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accentColor.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 17, color: accentColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: accentColor,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: accentColor.withValues(alpha: 0.8),
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

  Widget _buildReportButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: () {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('This feature is currently under development'),
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            ),
          );
        },
        icon: const Icon(
          Icons.report_problem_outlined,
          color: AppColors.error,
          size: 18,
        ),
        label: const Text(
          'Report Payment Issue',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.error,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.errorSoft,
          side: const BorderSide(color: AppColors.errorBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryTab(List<ExpenseModel> historyBills) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      child: Column(
        children: [
          Row(
            children: [
              // Search bar
              Expanded(
                child: Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.tenantPrimary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, size: 18, color: AppColors.textTertiary),
                      const SizedBox(width: 8),
                      Text(
                        'Search repairs...',
                        style: TextStyle(
                          color: AppColors.textTertiary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Filter button
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.tenantPrimary.withValues(alpha: 0.3),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.filter_alt_outlined,
                    size: 20,
                    color: AppColors.tenantPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Sort button
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.tenantPrimary.withValues(alpha: 0.3),
                  ),
                ),
                child: const Icon(
                  Icons.sort,
                  size: 20,
                  color: AppColors.tenantPrimary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Bills count
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Text(
                  '${historyBills.length} bills',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 6),

          // History bills
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: historyBills.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) =>
                _buildHistoryCard(historyBills[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(ExpenseModel bill) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border(
          left: const BorderSide(color: AppColors.tenantPrimary, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(14, 14, 16, 16),
      child: Column(
        children: [
          // Header row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${bill.month} ${bill.year}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      bill.paidDate,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              // Paid badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.successSoft,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.successDark,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Paid',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.successDeep,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Chips row
          Row(
            children: [
              Expanded(
                child: _buildHistoryChip(
                  icon: Icons.home_rounded,
                  iconColor: AppColors.tenantPrimary,
                  bgColor: AppColors.tenantSoft,
                  borderColor: AppColors.tenantPrimary,
                  valueColor: AppColors.tenantDark,
                  labelColor: AppColors.tenantDark,
                  label: 'Rent',
                  amount: bill.roomRent,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildHistoryChip(
                  icon: Icons.water_drop_rounded,
                  iconColor: AppColors.billWater,
                  bgColor: AppColors.billWaterSoft,
                  borderColor: AppColors.billWater,
                  valueColor: AppColors.billWaterDark,
                  labelColor: AppColors.billWaterLabel,
                  label: 'Water',
                  amount: bill.waterBill,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildHistoryChip(
                  icon: Icons.bolt_rounded,
                  iconColor: AppColors.billElec,
                  bgColor: AppColors.warningSoft,
                  borderColor: AppColors.billElec,
                  valueColor: AppColors.billElecDark,
                  labelColor: AppColors.billElecLabel,
                  label: 'Electricity',
                  amount: bill.electricityBill,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Total row (gradient)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.tenantPrimary, AppColors.tenantSecondary],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Text(
                  'Total paid',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.surface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  '${bill.totalAmount}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.surface,
                    letterSpacing: -1,
                    height: 1,
                  ),
                ),
                const SizedBox(width: 4),
                Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Text(
                    'THB',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white.withValues(alpha: 0.7),
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

  Widget _buildHistoryChip({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required Color borderColor,
    required Color valueColor,
    required Color labelColor,
    required String label,
    required int amount,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 14, color: iconColor),
          const SizedBox(height: 5),
          Text(
            '$amount',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: valueColor,
              letterSpacing: -0.4,
              height: 1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: labelColor,
            ),
          ),
        ],
      ),
    );
  }
}
