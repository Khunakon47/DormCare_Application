import 'package:dormcare/component/tenant/announcement_container.dart';
import 'package:dormcare/component/owner/custom_textbutton.dart';
import 'package:dormcare/component/tenant/greeting_container.dart';
import 'package:dormcare/component/tenant/home_dashboard_card.dart';
import 'package:dormcare/component/owner/room_detail_container.dart';
import 'package:dormcare/constants/dataset.dart';
import 'package:flutter/material.dart';

class HomeOwnerScreen extends StatelessWidget {
  const HomeOwnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    

    // ===== CALCULATED DATA =====
    final int totalRooms = roomList.length;

    final double monthlyRevenue = monthlyBills
        .where((b) => b.isPaid) // only paid bills count
        .fold(0, (sum, b) => sum + b.rent + b.water + b.electric + b.other);

    final int pendingRepairs =
        repairReports.where((r) => r.status == "pending").length;

    final int fixingRepairs =
        repairReports.where((r) => r.status == "fixing").length;

    final latestReport = repairReports.isNotEmpty ? repairReports.first : null;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            GreetingContainer(
              title: "Welcome, Owner",
              subtitle: dormsList.dormName,
              bgColor: ownerTheme.bgGradientColors,
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
                    bottomLeftText: "Total Rooms",
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
                    bottomLeftText: "Fixing Now",
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
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextbutton(
                          icon: Icon(Icons.add),
                          iconColor: Colors.white,
                          iconSize: 24,
                          textOnBtn: "Post Bills",
                          fgColor: Colors.white,
                          bgColor: [Colors.blueAccent],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CustomTextbutton(
                          icon: Icon(Icons.group_outlined),
                          iconColor: Colors.white,
                          iconSize: 24,
                          textOnBtn: "Tenants",
                          fgColor: Colors.white,
                          bgColor: [Colors.purpleAccent],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),

            /// ================= RECENT REPAIRS =================
            RoomDetailContainer(
              boxShadowOn: false,
              fgColor: Colors.orange,
              bgColor: Colors.orangeAccent.withValues(alpha: 0.25),
              icon: Icon(Icons.build),
              iconColor: Colors.orange,
              title: "Maintenance Reports",
              inListView: repairReports,
              navBtn: true,
            ),

            SizedBox(height: 15),

            /// ================= ANNOUNCEMENT =================
            if (latestReport != null)
              AnnouncementContainer(
                sideColor: Colors.orange,
                bgColor: Colors.orangeAccent.withValues(alpha: 0.15),
                textColor: Colors.deepOrange,
                icon: Icon(Icons.build),
                title: latestReport.title,
                decscription: latestReport.description,
              ),
          ],
        ),
      ),
    );
  }

}
