import 'package:dormcare/component/tenant/announcement_container.dart';
import 'package:dormcare/component/tenant/expense_card.dart';
import 'package:dormcare/model/tenant/expense_model.dart';
import 'package:flutter/material.dart';

class ExpensesTenantScreen extends StatefulWidget {
  const ExpensesTenantScreen({super.key});

  @override
  State<ExpensesTenantScreen> createState() => _ExpensesTenantScreenState();
}

class _ExpensesTenantScreenState extends State<ExpensesTenantScreen>
  with SingleTickerProviderStateMixin {

  late TabController _tabController;

  // จำลองข้อมูล (Mock Data)
  final List<ExpenseModel> _allBills = [
    // Current Bill (Unpaid)
    ExpenseModel(
      id: '1',
      month: 'December',
      year: '2024',
      roomRent: 2500,
      waterUnits: 18,
      electricityUnits: 150,
      status: ExpenseStatus.unpaid,
      billDate: "22 Jan 2025",
      dueDate: "5 Jan 2025",
      paidDate: "",
    ),

    // History (Paid)
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
    // currentBill
    final currentBill = _allBills.firstWhere(
      (e) => e.status == ExpenseStatus.unpaid,
      orElse: () => _allBills[0], // กันตายกรณีไม่มีบิลค้าง
    );
    // historyBills
    final historyBills = _allBills
      .where((e) => e.status == ExpenseStatus.paid)
      .toList();

    return Column(
      children: [
        // Tab bar section
        Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: const Color(0xFF367BF3),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(height: 44, text: 'Current'),
                Tab(height: 44, text: 'History'),
              ],
            ),
          ),
        ),

        SizedBox(height: 16),

        // Tab content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(), // ปิดการ swipe
            children: [
              // ============ Tab 1: Current Month ============
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bill update schedule(Announcement) section
                      AnnouncementContainer(
                        sideColor: Color(0xFF367BF3),
                        bgColor: Color(0xFFE3F2FD),
                        textColor: Color(0xFF1565C0),
                        icon: Icon(Icons.calendar_today),
                        title: 'Bill Update Schedule',
                        decscription:
                            'Bills are posted on the 25th of each month. Payment deadline is the 5th of the following month.',
                      ),

                      SizedBox(height: 16),

                      // Current Bill section
                      CurrentBillCard(data: currentBill),

                      SizedBox(height: 16),

                      // Payment Location(Announcement) Section
                      AnnouncementContainer(
                        sideColor: Color(0xFFFFC107),
                        bgColor: Color(0xFFFFF9E6),
                        textColor: Color(0xFFA67C00),
                        icon: Icon(Icons.info_outline),
                        title: 'Payment Location',
                        decscription:
                          'Please visit the management office on the ground floor to make your payment. Office hours: Mon-Fri 8:00-17:00, Sat 9:00-12:00',
                      ),

                      SizedBox(height: 16),

                      // Report button section
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => {ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  "This feature is currently under development",
                                ),
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(seconds: 2),
                              ),
                            ),
                            
                          },
                          icon: const Icon(
                            Icons.report_problem_outlined,
                            color: Colors.red,
                            size: 22,
                          ),
                          label: const Text(
                            'Report Payment Issue',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.red, width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ============ Tab 2: History ============
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: historyBills.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return HistoryBillCard(data: historyBills[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
