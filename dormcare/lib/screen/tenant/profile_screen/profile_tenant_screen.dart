import 'package:dormcare/screen/tenant/main_tenant_screen.dart';
import 'package:flutter/material.dart';

class ProfileTenantScreen extends StatelessWidget {
  const ProfileTenantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> profileItems = [
      "Edit Profile",
      "Payment History",
      "Settings",
      "Help & Support",
    ];

    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          // section 1
          Container(
            padding: EdgeInsets.all(40),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.5),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFF3B82F6),
                    child: Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                ),

                SizedBox(height: 16),

                Text(
                  "JoBy Khuna",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 10),

                Text(
                  "Room 301 - Dorm 27",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          // section 2
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1,),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            // ใช้ ClipRRect เพื่อบังคับให้ Ripple และพื้นหลังอยู่ในกรอบโค้งมน
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Material(
                color: Colors.white,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),

                  itemCount: profileItems.length,
                  
                  separatorBuilder: (context, index) => 
                    const Divider(height: 1, thickness: 1, indent: 16, /* เว้นระยะซ้าย */ endIndent: 16, /* เว้นระยะขวา */ color: Color(0xFFEEEEEE),
                  ),

                  itemBuilder: (context, index) {
                    // ListTile มี InkWell (Ripple Effect) ในตัวอยู่แล้ว
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 4,
                      ),
                      title: Text(
                        profileItems[index],
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: Colors.grey,
                      ),
                      onTap: () {
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
                    );
                  },
                ),
              ),
            ),
          ),

          SizedBox(height: 16),

          // section 3
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainTenantScreen(
                      initialIndex: 0,
                    ), // ส่งกลับไปหน้า Main โดยเริ่มที่ index 0
                  ),
                  (route) => false, // ล้าง Stack ทั้งหมด
                );
              },
              label: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
