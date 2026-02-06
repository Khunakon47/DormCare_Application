import 'package:dormcare/component/announcement_container.dart';
import 'package:dormcare/component/current_bill_card.dart';
import 'package:flutter/material.dart';

class ExpensesTenantScreen extends StatefulWidget {
  const ExpensesTenantScreen({super.key});

  @override
  State<ExpensesTenantScreen> createState() => _ExpensesTenantScreenState();
}

class _ExpensesTenantScreenState extends State<ExpensesTenantScreen> /*add it to enable tab bar*/ with SingleTickerProviderStateMixin {

  late TabController _tabController;

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

  void _handleReportbtn(BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("This feature is currently under development"),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 3),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tab bar section
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: const Color(0xFF367BF3), // สีตัวอักษรของ tab ที่เลือก
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),

                unselectedLabelColor:Colors.grey, // สีตัวอักษรของ tab ที่ไม่ได้เลือก
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),

                indicator: BoxDecoration(
                  color: Colors.white, // สีพื้นหลังของ tab ที่เลือก (ขาว)
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                indicatorSize: TabBarIndicatorSize.tab, // ทำสีพื้นหลังเต็ม tab (ถ้าไม่ใช้ สีพื้นหลังจะครอบแค่ความยาวตัวหนังสือ)
                dividerColor: Colors.transparent, // ซ่อนเส้นใต้ TabBar
                tabs: const [
                  Tab(height: 44, text: 'Current Month'),
                  Tab(height: 44, text: 'History'),
                ],
              ),
            ),

            SizedBox(height: 16),

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
            CurrentBillCard(
              month: 'December',
              year: 2024,
              billDate: 'Dec 25, 2024',
              dueDate: 'Jan 5, 2025',
              roomRent: 2500,
              waterUnits: 18,
              electricityUnits: 150,
              isPaid: false,
            ),

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
            Container(
              padding: EdgeInsets.all(0),
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => {_handleReportbtn(context)},
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
                  side: const BorderSide(
                    color: Colors.red,
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
