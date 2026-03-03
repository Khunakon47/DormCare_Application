import 'package:flutter/material.dart';

import 'package:dormcare/component/tenant/announcement_container.dart';
import 'package:dormcare/component/tenant/greeting_container.dart';
import 'package:dormcare/component/tenant/home_dashboard_card.dart';

import 'package:dormcare/model/recent_repair_model.dart';
import 'package:dormcare/model/dashboard_card_model.dart';

class HomeOwnerScreen extends StatelessWidget {
  const HomeOwnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<RecentRepairModel> maintenances = [
      const RecentRepairModel(
        roomNumber: "Room 301",
        title: "Air conditioner not cooling",
        date: 10,
        month: "Dec",
        year: 2024,
        statusIcon: Icon(Icons.check_circle_outline, color: Colors.green),
      ),

      const RecentRepairModel(
        roomNumber: "Room 201",
        title: "Leaking faucet",
        date: 12,
        month: "Dec",
        year: 2024,
        statusIcon: Icon(Icons.access_time, color: Colors.orange),
      ),

      const RecentRepairModel(
        roomNumber: "Room 101",
        title: "Light bulb replacement (Bathroom)",
        date: 5,
        month: "Jan",
        year: 2025,
        statusIcon: Icon(Icons.access_time, color: Colors.orange),
      ),
    ];

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          children: [
            // Greeting Section
            GreetingContainer(
              title: "Welcome, Owner",
              icon: Icon(Icons.waving_hand),
              subtitle: "KKU Dorm 27",
              bgColor: [
                Color.fromARGB(255, 163, 76, 243),
                Color.fromARGB(255, 79, 69, 226),
              ],
            ),

            SizedBox(height: 15),

            // Dashboard Row 1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: HomeDashboardCard(
                    model: DashboardCardModel(
                      bgColor: Colors.blueAccent,
                      fgColor: Colors.white,
                      isRoomOccupiedCard: true,
                      occupiedRoom: 45,
                      totalRoom: 50,
                      icon: Icon(Icons.home_outlined),
                      title: "Rooms Occupied",
                      titleSize: 16, 
                      topRightText: '',
                      iconSize: 30
                    ),
                  ),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: HomeDashboardCard(
                    model: DashboardCardModel(
                      bgColor: Colors.green,
                      fgColor: Colors.white,
                      icon: Icon(Icons.attach_money),
                      iconColor: Colors.white,
                      iconSize: 30,
                      topRightText: "8097",
                      currency: "THB",
                      title: "Monthly Revenue",
                      titleSize: 16, 
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),

            // Dashboard Row 2
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: HomeDashboardCard(
                    model: DashboardCardModel(
                      bgColor: Colors.orange,
                      fgColor: Colors.white,
                      icon: Icon(Icons.build_outlined),
                      iconColor: Colors.white,
                      topRightText: "5",
                      title: "Pending Repairs",
                      titleSize: 16, 
                      iconSize: 30
                    ),
                  ),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: HomeDashboardCard(
                    model: DashboardCardModel(
                      bgColor: Colors.redAccent,
                      fgColor: Colors.white,
                      icon: Icon(Icons.info_outline),
                      iconColor: Colors.white,
                      iconSize: 30,
                      topRightText: "2",
                      title: "Unpaid Bills",
                      titleSize: 16,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),

            // Quick Actions section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  SizedBox(height: 20),

                  Row(
                    children: [
                      // Manage Rooms Button
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.blueAccent.withValues(alpha: 0.15),
                          ),
                          child: TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "This feature is currently under development",
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.meeting_room_outlined, color: Colors.blueAccent, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  "Manage Rooms",
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ),

                      SizedBox(width: 10),

                      // View Reports Button
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.green.withValues(alpha: 0.15),
                          ),
                          child: TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "This feature is currently under development",
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.receipt_long_outlined, color: Colors.green, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  "View Reports",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),

            // Recent Repairs Section 
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
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

            // Announcement Section
            AnnouncementContainer(
              sideColor: Colors.red,
              bgColor: Colors.red.withValues(alpha: 0.1),
              textColor: Colors.redAccent,
              icon: Icon(Icons.info_outline),
              title: "Payment Reminder Needed",
              decscription: "12 Rooms have unpaid bills. Due date: 5 Jan 2025",
            ),

            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
