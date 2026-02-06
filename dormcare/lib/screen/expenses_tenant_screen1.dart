import 'package:flutter/material.dart';

class ExpensesTenantScreen1 extends StatefulWidget {
  const ExpensesTenantScreen1({super.key});

  @override
  State<ExpensesTenantScreen1> createState() => _ExpensesTenantScreen1State();
}

class _ExpensesTenantScreen1State extends State<ExpensesTenantScreen1>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedYear = 'All Years';
  String _selectedSort = 'Newest';

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
    return Column(
      children: [
        // Tab Bar
        Container(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            labelColor: const Color(0xFF367BF3),
            unselectedLabelColor: Colors.grey,
            indicatorColor: const Color(0xFF367BF3),
            indicatorWeight: 3,
            tabs: const [
              Tab(text: 'Current Month'),
              Tab(text: 'History'),
            ],
          ),
        ),

        // Tab Bar View
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [_buildCurrentMonthTab(), _buildHistoryTab()],
          ),
        ),
      ],
    );
  }

  // Current Month Tab
  Widget _buildCurrentMonthTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bill Update Schedule Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(12),
                border: Border(
                  left: BorderSide(color: const Color(0xFF367BF3), width: 4),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: const Color(0xFF367BF3),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Bill Update Schedule',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1565C0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Bills are posted on the 25th of each month.\nPayment deadline is the 5th of the following month.',
                    style: TextStyle(fontSize: 13, color: Colors.blue.shade900),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Current Month Bill Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF37474F),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'December 2024',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'Bill Date: Dec 25, 2024',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      const Spacer(),
                      Text(
                        'Due: Jan 5, 2025',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Room Rent Item
            _buildExpenseItem(
              icon: Icons.home,
              iconColor: Colors.blue,
              iconBgColor: Colors.blue.shade50,
              title: 'Room Rent',
              subtitle: 'Monthly payment',
              amount: '2,500',
              currency: 'THB',
            ),

            const SizedBox(height: 12),

            // Water Bill Item
            _buildExpenseItem(
              icon: Icons.water_drop,
              iconColor: Colors.cyan,
              iconBgColor: Colors.cyan.shade50,
              title: 'Water Bill',
              subtitle: '18 units used',
              amount: '180',
              currency: 'THB',
              rate: '10 THB / Unit',
            ),

            const SizedBox(height: 12),

            // Electricity Bill Item
            _buildExpenseItem(
              icon: Icons.bolt,
              iconColor: Colors.amber,
              iconBgColor: Colors.amber.shade50,
              title: 'Electricity Bill',
              subtitle: '150 units used',
              amount: '450',
              currency: 'THB',
              rate: '3 THB / Unit',
            ),

            const SizedBox(height: 16),

            // Total Amount
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        '3,130',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF367BF3),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'THB',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.content_copy, size: 18, color: Colors.grey),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Status
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Status',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Unpaid',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Payment Location
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF9E6),
                borderRadius: BorderRadius.circular(12),
                border: Border(
                  left: BorderSide(color: const Color(0xFFFFC107), width: 4),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: const Color(0xFFA67C00),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Payment Location',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFA67C00),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please visit the management office on the ground floor to make your payment. Office hours: Mon-Fri 8:00-17:00, Sat 9:00-12:00',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.brown.shade700,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Report Payment Issue Button
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.report_problem_outlined,
                    color: Colors.red,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Report Payment Issue',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
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

  // History Tab
  Widget _buildHistoryTab() {
    return Column(
      children: [
        // Filter and Sort Row
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Filter Button
              Expanded(
                child: InkWell(
                  onTap: () => _showYearFilter(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.filter_list,
                          size: 18,
                          color: const Color(0xFF367BF3),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Filter: $_selectedYear',
                          style: TextStyle(fontSize: 13),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.arrow_drop_down, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Sort Button
              Expanded(
                child: InkWell(
                  onTap: () => _showSortOptions(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.swap_vert,
                          size: 18,
                          color: const Color(0xFF367BF3),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Sort: $_selectedSort',
                          style: TextStyle(fontSize: 13),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.arrow_drop_down, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // History List
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildHistoryCard(
                month: 'November 2024',
                paidDate: 'Nov 4, 2024',
                totalAmount: '3055',
                isPaid: true,
                expenses: [
                  {
                    'title': 'Room Rent',
                    'subtitle': '112 Area',
                    'amount': '2,500',
                  },
                  {'title': 'Water', 'subtitle': '15 Units', 'amount': '150'},
                  {
                    'title': 'Electricity',
                    'subtitle': '135 Units',
                    'amount': '405',
                  },
                ],
              ),

              const SizedBox(height: 16),

              _buildHistoryCard(
                month: 'October 2024',
                paidDate: 'Oct 3, 2024',
                totalAmount: '3180',
                isPaid: true,
                expenses: [
                  {
                    'title': 'Room Rent',
                    'subtitle': '112 Area',
                    'amount': '2,500',
                  },
                  {'title': 'Water', 'subtitle': '20 Units', 'amount': '200'},
                  {
                    'title': 'Electricity',
                    'subtitle': '160 Units',
                    'amount': '480',
                  },
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExpenseItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required String amount,
    required String currency,
    String? rate,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    amount,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    currency,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          if (rate != null) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rate',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                Text(
                  rate,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHistoryCard({
    required String month,
    required String paidDate,
    required String totalAmount,
    required bool isPaid,
    required List<Map<String, String>> expenses,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with paid badge
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      month,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Paid on $paidDate',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    totalAmount,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Text('฿', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Expense Items
          ...expenses.map(
            (expense) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getIconBackground(expense['title']!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getIcon(expense['title']!),
                      color: _getIconColor(expense['title']!),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          expense['title']!,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          expense['subtitle']!,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${expense['amount']} ฿',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String title) {
    if (title.contains('Room')) return Icons.home;
    if (title.contains('Water')) return Icons.water_drop;
    if (title.contains('Electricity')) return Icons.bolt;
    return Icons.receipt;
  }

  Color _getIconColor(String title) {
    if (title.contains('Room')) return Colors.blue;
    if (title.contains('Water')) return Colors.cyan;
    if (title.contains('Electricity')) return Colors.amber;
    return Colors.grey;
  }

  Color _getIconBackground(String title) {
    if (title.contains('Room')) return Colors.blue.shade50;
    if (title.contains('Water')) return Colors.cyan.shade50;
    if (title.contains('Electricity')) return Colors.amber.shade50;
    return Colors.grey.shade50;
  }

  void _showYearFilter() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('All Years'),
              onTap: () {
                setState(() => _selectedYear = 'All Years');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('2024'),
              onTap: () {
                setState(() => _selectedYear = '2024');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('2023'),
              onTap: () {
                setState(() => _selectedYear = '2023');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Newest'),
              onTap: () {
                setState(() => _selectedSort = 'Newest');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Oldest'),
              onTap: () {
                setState(() => _selectedSort = 'Oldest');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
