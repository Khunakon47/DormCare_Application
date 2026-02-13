import 'package:dormcare/component/tenant/announcement_container.dart';
import 'package:dormcare/component/owner/custom_textbutton.dart';
import 'package:dormcare/component/tenant/greeting_container.dart';
import 'package:dormcare/component/tenant/home_dashboard_card.dart';
// import 'package:dormcare/component/owner/room_detail_container.dart';
import 'package:dormcare/constants/dataset.dart';
// import 'package:dormcare/model/owner/repair_report_model.dart';
// import 'package:dormcare/model/owner/room_model.dart';
import 'package:dormcare/model/tenant/repair_tenant_model.dart';
import 'package:flutter/material.dart';

class HomeOwnerScreen extends StatelessWidget {
  const HomeOwnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<RepairTenant> maintenances = [
      const RepairTenant(
        roomNumber: "Room 301",
        title: "Air conditioner not cooling",
        date: 10,
        month: "Dec",
        year: 2024,
        statusIcon: Icon(Icons.check_circle_outline, color: Colors.green),
      ),

      const RepairTenant(
        roomNumber: "Room 201",
        title: "Leaking faucet",
        date: 12,
        month: "Dec",
        year: 2024,
        statusIcon: Icon(Icons.access_time, color: Colors.orange),
      ),

      const RepairTenant(
        roomNumber: "Room 101",
        title: "Light bulb replacement (Bathroom)",
        date: 5,
        month: "Jan",
        year: 2025,
        statusIcon: Icon(Icons.access_time, color: Colors.orange),
      ),
    ];

    // ===== CALCULATED DATA =====
    final int totalRooms = roomList.length;

    final double monthlyRevenue = monthlyBills
        .where((b) => b.isPaid) // only paid bills count
        .fold(0, (sum, b) => sum + b.rent + b.water + b.electric + b.other);

    final int pendingRepairs = repairReports
        .where((r) => r.status == "pending")
        .length;

    final int fixingRepairs = repairReports
        .where((r) => r.status == "fixing")
        .length;

    // final latestReport = repairReports.isNotEmpty ? repairReports.first : null;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            GreetingContainer(
              title: "Welcome, Owner",
              subtitle: dormsList.dormName,
              bgColor: [Color.fromARGB(255,163, 76, 243), Color.fromARGB(255,79,69,226)],
            ),

            SizedBox(height: 15),

            /// ================= DASHBOARD ROW 1 =================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: HomeDashboardCard(
                    bgColor: Colors.blue,
                    fgColor: Colors.white,
                    icon: Icon(Icons.home_outlined),
                    iconColor: Colors.white,
                    iconSize: 32,
                    topRightText: totalRooms.toString(),
                    bottomLeftText: "Rooms Occupied",
                    isOwner: true,
                    topRightTextSize: 24,
                    totalRoom: totalRooms,
                  ),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: HomeDashboardCard(
                    bgColor: Colors.green,
                    fgColor: Colors.white,
                    icon: Icon(Icons.attach_money),
                    iconColor: Colors.white,
                    iconSize: 32,
                    topRightText: monthlyRevenue.toStringAsFixed(0),
                    bottomLeftText: "Monthly Revenue",
                    isOwner: false,
                    topRightTextSize: 24,
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),

            /// ================= DASHBOARD ROW 2 =================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: HomeDashboardCard(
                    bgColor: Colors.orange,
                    fgColor: Colors.white,
                    icon: Icon(Icons.build_outlined),
                    iconColor: Colors.white,
                    iconSize: 28,
                    topRightText: pendingRepairs.toString(),
                    bottomLeftText: "Pending Repairs",
                    topRightTextSize: 24,
                    isOwner: false,
                  ),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: HomeDashboardCard(
                    bgColor: Colors.red,
                    fgColor: Colors.white,
                    icon: Icon(Icons.info_outline),
                    iconColor: Colors.white,
                    iconSize: 32,
                    topRightText: fixingRepairs.toString(),
                    bottomLeftText: "Unpaid Bills",
                    topRightTextSize: 24,
                    isOwner: false,
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),

            /// ================= QUICK ACTION =================
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    offset: const Offset(0, 1),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextbutton(
                          icon: Icon(Icons.add),
                          iconColor: Colors.blueAccent,
                          iconSize: 24,
                          spacing: 4,
                          fontSize: 14,
                          textOnBtn: "Post New Bills",
                          fgColor: Colors.blueAccent,
                          bgColor: [Colors.blueAccent.withValues(alpha: 0.15)],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CustomTextbutton(
                          icon: Icon(Icons.group_outlined),
                          iconColor: Colors.purpleAccent,
                          iconSize: 20,
                          spacing: 2,
                          textOnBtn: "Manage Rooms",
                          fontSize: 14,
                          fgColor: Colors.purpleAccent,
                          bgColor: [
                            Colors.purpleAccent.withValues(alpha: 0.15),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),

            AnnouncementContainer(
              sideColor: Colors.red,
              bgColor: Colors.redAccent.withValues(alpha: 0.15),
              textColor: Colors.redAccent,
              icon: Icon(Icons.info_outline),
              title: "Payment Reminder Needed",
              decscription: "12 Rooms have unpaid bills. Due date: 5 Jan 2025",
            ),

            SizedBox(height: 15),

            /// ================= RECENT REPAIRS =================
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.build_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Recent Maintenance",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),

                    itemCount: maintenances.length,
                    itemBuilder: (context, index) {
                      final maintenance = maintenances[index];
                      return Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(
                            "${maintenance.roomNumber} - ${maintenance.title}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                "${maintenance.date} ${maintenance.month}, ${maintenance.year}",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          trailing: maintenance.statusIcon,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),

            /// ================= ANNOUNCEMENT =================
            // if (latestReport != null)
          ],
        ),
      ),
    );
  }
}
