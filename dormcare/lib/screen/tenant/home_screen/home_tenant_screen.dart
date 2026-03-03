import 'package:dormcare/component/tenant/announcement_container.dart';
import 'package:dormcare/component/tenant/greeting_container.dart';
import 'package:dormcare/model/dashboard_card_model.dart';
import 'package:flutter/material.dart';
import '../../../component/tenant/home_dashboard_card.dart';
import '../../../model/recent_repair_model.dart';

class HomeTenantScreen extends StatelessWidget {
  const HomeTenantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<RecentRepairModel> repairs = [
      const RecentRepairModel(
        title: "Air conditioner not cooling",
        date: 10,
        month: "Dec",
        year: 2024,
        statusIcon: Icon(Icons.check_circle_outline, color: Colors.green),
      ),

      const RecentRepairModel(
        title: "Leaking faucet",
        date: 12,
        month: "Dec",
        year: 2024,
        statusIcon: Icon(Icons.access_time, color: Colors.orange),
      ),

      const RecentRepairModel(
        title: "Light bulb replacement (Bathroom)",
        date: 5,
        month: "Jan",
        year: 2025,
        statusIcon: Icon(Icons.access_time, color: Colors.orange),
      ),

      const RecentRepairModel(
        title: "Door lock jammed",
        date: 8,
        month: "Jan",
        year: 2025,
        statusIcon: Icon(Icons.build_circle_outlined, color: Colors.redAccent),
      ),

      const RecentRepairModel(
        title: "Clogged shower drain",
        date: 20,
        month: "Nov",
        year: 2024,
        statusIcon: Icon(Icons.check_circle_outline, color: Colors.green),
      ),
    ];

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          children: [
            // Greeting Section
            GreetingContainer(
              bgColor: [const Color(0xFF367BF3), const Color(0xFF2761E9)],
              title: "Welcome, JoBy",
              icon: Icon(Icons.waving_hand),
              subtitle: "Room 301 - Dorm 27",
            ),

            SizedBox(height: 16),

            // Dashboard section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: HomeDashboardCard(
                    model: DashboardCardModel(
                      icon: Icon(Icons.build_outlined),
                      iconColor: Colors.orange,
                      topRightText: "2",
                      title: "Pending Repairs",
                    ),
                  ),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: HomeDashboardCard(
                    model: DashboardCardModel(
                      icon: Icon(Icons.attach_money),
                      iconColor: Colors.green,
                      iconSize: 30,
                      topRightText: "3,212",
                      currency: "THB",
                      title: "Room Rent - Unpaid",
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Announcement Section
            AnnouncementContainer(
              sideColor: const Color(0xFFFFC107),
              bgColor: const Color(0xFFFFF9E6),
              textColor: Color(0xFFA67C00),
              icon: Icon(Icons.info_outline),
              title: 'Payment Reminder',
              decscription:
                  'You have 1 bills due on Jan 5, 2025 (18 days remaining)',
            ),

            SizedBox(height: 16),

            // Recent Repairs Section
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.1),
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

                    itemCount: repairs.length,
                    itemBuilder: (context, index) {
                      final maintenance = repairs[index];
                      return Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(
                            maintenance.title,
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

            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
