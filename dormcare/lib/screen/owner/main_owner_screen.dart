import 'package:flutter/material.dart';
import 'package:dormcare/model/page_data_model.dart';

import 'bills_screen/bills_owner_screen.dart';
import 'home_screen/home_owner_screen.dart';
import 'login_screen/login_owner_screen.dart';
import 'profile_screen/profile_owner_screen.dart';
import 'repairs_screen/repairs_owner_screen.dart';
import 'rooms_screen/room_owner_screen.dart';
import 'alter_screen/alter_tenant_screen.dart';

class MainOwnerScreen extends StatefulWidget {
  const MainOwnerScreen({super.key, this.initialIndex = 1});

  final int initialIndex;

  @override
  State<MainOwnerScreen> createState() => _MainOwnerScreenState();
}

class _MainOwnerScreenState extends State<MainOwnerScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // กำหนดค่าเริ่มต้นจาก parameter
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<PageDataModel> pages = [
      // Login screen
      PageDataModel(title: "Login",screen: LoginOwnerScreen(onLoginSuccess: () {_onItemTapped(0);}),),
      // Dashboard/Home screen
      PageDataModel(title: "Dashboard",screen: HomeOwnerScreen(),),
      // Room management screen
      const PageDataModel(title: "Rooms",screen: RoomOwnerScreen(),),
      // Bill management screen
      const PageDataModel(title: "Bills",screen: BillsOwnerScreen(),),
      // Repair management screen
      const PageDataModel(title: "Repairs",screen: RepairsOwnerScreen(),),
      // Profile/Setting screen
      const PageDataModel(title: "Profile",screen: ProfileOwnerScreen(),),
      // Alert/Notification screen
      const PageDataModel(title: "Alert", screen: AlertTenantScreen()),
    ];

    final PageDataModel currentPage = pages[_selectedIndex];

    return Scaffold(
      appBar: currentPage.title == "Login"
        ? null
        : AppBar(
            title: Text(
              currentPage.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                padding: EdgeInsets.only(right: 16),
                onPressed: () => {
                  ScaffoldMessenger.of(context).clearSnackBars(),
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 2),
                      content: Text("This feature is currently under development."),
                    ),
                  ),
                },
                icon: Icon(Icons.notifications, size: 32, color: Colors.purple),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(color: Colors.grey.shade300, height: 1.0),
            ),
          ),

      body: currentPage.screen,

      bottomNavigationBar: currentPage.title == "Login"
        ? null
        : Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Color(0xFFA34CF3).withValues(alpha: 0.1), // สำหรับสีตอนกระจายตัว (ใช้ Colors.transparent สำหรับปิด)
              highlightColor: Color(0xFF9436F3).withValues(alpha: 0.1), // สำหรับสีตอนกดค้าง
            ),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex - 1,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,

              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              selectedItemColor: Color(0xFFA34CF3),
              selectedFontSize: 13,
              selectedIconTheme: IconThemeData(size: 26),

              showUnselectedLabels: true,
              unselectedItemColor: Color(0xFF9436F3),
              unselectedFontSize: 12,
              unselectedIconTheme: IconThemeData(size: 25),

              items: [
                // Home
                _buildBottomNavBarItem(
                  lebel: 'Home',
                  icon: const Icon(Icons.home_outlined),
                  activeIcon: const Icon(Icons.home),
                ),

                // Room Management
                _buildBottomNavBarItem(
                  lebel: 'Rooms',
                  icon: const Icon(Icons.meeting_room_outlined),
                  activeIcon: const Icon(Icons.meeting_room),
                ),

                // Bills
                _buildBottomNavBarItem(
                  lebel: 'Bills',
                  icon: const Icon(Icons.receipt_long_outlined),
                  activeIcon: const Icon(Icons.receipt_long),
                ),

                // Repairs
                _buildBottomNavBarItem(
                  lebel: 'Repairs',
                  icon: const Icon(Icons.build_outlined),
                  activeIcon: const Icon(Icons.build),
                ),

                // Profile
                _buildBottomNavBarItem(
                  lebel: 'Profile',
                  icon: const Icon(Icons.person_outline),
                  activeIcon: const Icon(Icons.person),
                ),
              ],
            ),
          ),
        ),
    );
  }

  // ฟังก์ชันช่วยสร้าง BottomNavigationBarItem เพื่อให้โค้ดดูสะอาดและสั้นลง
  BottomNavigationBarItem _buildBottomNavBarItem({
    required String lebel,
    required Icon icon,
    required Icon activeIcon,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(padding: EdgeInsets.only(top: 8), child: icon),
      activeIcon: Padding(padding: EdgeInsets.only(top: 8), child: activeIcon),
      label: lebel,
    );
  }
}
