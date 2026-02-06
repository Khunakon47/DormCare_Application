import 'package:dormcare/component/home_dashboard_card.dart';
import 'package:dormcare/model/repair_tenant_model.dart';
import 'package:flutter/material.dart';

class HomeOwnerScreen extends StatelessWidget {
  const HomeOwnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final List<RepairTenant> maintenances = [
      const RepairTenant(
        title: "Room 301 - Air conditioner not cooling",
        date: 10,
        month: "Dec",
        year: 2024,
        statusIcon: Icon(Icons.check_circle_outline, color: Colors.green),
      ),

      const RepairTenant(
        title: "Room 300 - Light  bulb replacement (Bathroom)",
        date: 12,
        month: "Dec",
        year: 2024,
        statusIcon: Icon(Icons.access_time, color: Colors.orange),
      ),
    ];

    // Don't return Scaffold widget because in the main screen alread exist.
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color.fromARGB(255, 174, 54, 243), // started color
                    const Color.fromARGB(255, 139, 39, 233), // ended color
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome, Owner 👋",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "Room 301 - Dorm 27",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: HomeDashboardCard(
                    icon: Icon(Icons.home_outlined),
                    iconsize: 32,
                    coloricon: Colors.white,
                    num: 2,
                    title: "Rooms Occupied",
                    textColor: Colors.white,
                    boxColor: Colors.blue,
                  ),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: HomeDashboardCard(
                    icon: Icon(Icons.attach_money),
                    iconsize: 32,
                    coloricon: Colors.white,
                    num: 3212,
                    currency: "THB",
                    title: "Monthly Revenue",
                    textColor: Colors.white,
                    boxColor: Colors.green,
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: HomeDashboardCard(
                    icon: Icon(Icons.build_outlined),
                    iconsize: 28,
                    coloricon: Colors.white,
                    num: 2,
                    title: "Pending Repairs",
                    boxColor: Colors.orange,
                    textColor: Colors.white,
                  ),
                ),

                SizedBox(width: 10,),

                Expanded(
                  child: HomeDashboardCard(
                    icon: Icon(Icons.info_outline),
                    iconsize: 32,
                    coloricon: Colors.white,
                    num: 3212,
                    currency: "THB",
                    title: "Room Rent - Unpaid",
                    textColor: Colors.white,
                    boxColor: Colors.red,
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
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
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, color: Colors.white,),
                              SizedBox(width: 10,),
                              Text(
                                "Post Bills",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.purpleAccent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.group_outlined, color: Colors.white,),
                              SizedBox(width: 10,),
                              Text(
                                "Post Bills",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ),
                    ],
                  )
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Recent Maintenance",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      TextButton(onPressed: ()=>{}, child: Text("View all", style: TextStyle(color: Colors.blue, fontSize: 14, fontWeight: FontWeight.w300),))
                    ],
                  ),

                  SizedBox(height: 15),

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