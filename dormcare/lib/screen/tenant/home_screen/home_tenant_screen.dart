import 'package:dormcare/component/greeting_container.dart';
import 'package:flutter/material.dart';
import '../../../component/home_dashboard_card.dart';
import '../../../model/repair_tenant_model.dart';

class HomeTenantScreen extends StatelessWidget {
  const HomeTenantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<RepairTenant> maintenances = [
      const RepairTenant(
        title: "Air conditioner not cooling",
        date: 10,
        month: "Dec",
        year: 2024,
        statusIcon: Icon(Icons.check_circle_outline, color: Colors.green),
      ),

      const RepairTenant(
        title: "Leaking faucet",
        date: 12,
        month: "Dec",
        year: 2024,
        statusIcon: Icon(Icons.access_time, color: Colors.orange),
      ),

      const RepairTenant(
        title: "Light bulb replacement (Bathroom)",
        date: 5,
        month: "Jan",
        year: 2025,
        statusIcon: Icon(Icons.access_time, color: Colors.orange),
      ),

      const RepairTenant(
        title: "Door lock jammed",
        date: 8,
        month: "Jan",
        year: 2025,
        statusIcon: Icon(Icons.build_circle_outlined, color: Colors.redAccent),
      ),

      const RepairTenant(
        title: "Clogged shower drain",
        date: 20,
        month: "Nov",
        year: 2024,
        statusIcon: Icon(Icons.check_circle_outline, color: Colors.green),
      ),
    ];

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            // Section 1
            GreetingContainer(
              bgColor: [
                const Color(0xFF367BF3),
                const Color(0xFF2761E9),
              ], 
              title: "Welcome, JoBy",
              icon: Icon(Icons.waves), 
              subtitle: "Room 301 - Dorm 27"
            ),

            SizedBox(height: 15),

            // Section 2
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: HomeDashboardCard(
                    bgColor: Colors.white, 
                    fgColor: Colors.black, 
                    icon: Icon(Icons.build_outlined), 
                    iconColor: Colors.orange, 
                    iconSize: 26, 
                    topRightText: "2", 
                    bottomLeftText: "Pending Repairs", 
                    isOwner: false,
                  )
                ),

                SizedBox(width: 10),

                Expanded(
                  child: HomeDashboardCard(
                    bgColor: Colors.white, 
                    fgColor: Colors.black, 
                    icon: Icon(Icons.attach_money), 
                    iconColor: Colors.green, 
                    iconSize: 30, 
                    topRightText: "3,212", 
                    currency: "THB",
                    bottomLeftText: "Room Rent - Unpaid", 
                    isOwner: false,
                  )
                ),
              ],
            ),

            SizedBox(height: 15),

            // Section 3
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF9E6),
                borderRadius: BorderRadius.circular(12),
                border: const Border(
                  left: BorderSide(color: Color(0xFFFFC107), width: 6.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: Color(0xFFA67C00),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Payment Reminder",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFA67C00),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "You have 1 bills due on Jan 5, 2025 (18 days remaining)",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.brown.shade700,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),

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
                      Icon(Icons.build_outlined,color: Theme.of(context).colorScheme.primary,),
                      SizedBox(width: 8),
                      Text("Recent Maintenance",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    ],
                  ),

                  SizedBox(height: 20),

                  ListView.separated(
                    // เมื่อใช้ ListView ใน column ต้องใช้ 2 โค้ดนี้ด้วยเสมอ
                    shrinkWrap:
                        true, // กำหนดให้ ListView สูงเท่ากับจำนวนรายการจริง (ป้องกัน Error เรื่องความสูง) (ไม่ใช้ = Error)
                    physics:
                        const NeverScrollableScrollPhysics(), // ปิดการเลื่อนในตัวเอง เพื่อให้เลื่อนตามหน้าจอหลักได้อย่างสมูธ

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
          ],
        ),
      ),
    );
  }
}
