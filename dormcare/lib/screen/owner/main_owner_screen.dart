import 'package:dormcare/constants/dataset.dart';
import 'package:dormcare/screen/owner/bills_screen/bills_owner_screen.dart';
import 'package:dormcare/screen/owner/home_screen/home_owner_screen.dart';
import 'package:dormcare/screen/owner/login_screen/login_owner_screen.dart';
import 'package:dormcare/screen/owner/profile_screen/profile_owner_screen.dart';
import 'package:dormcare/screen/owner/repairs_screen/repairs_owner_screen.dart';
import 'package:dormcare/screen/owner/rooms_screen/room_owner_screen.dart';
import 'package:dormcare/screen/tenant/alter_screen/alter_tenant_screen.dart';
import 'package:flutter/material.dart';
import '../../model/tenant/page_data_model.dart';

class MainOwnerScreen extends StatefulWidget {
  const MainOwnerScreen({
    super.key, 
    this.initialIndex = 1,
  });

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
      PageDataModel(
          title: "Login",
          screen: LoginOwnerScreen(
            onLoginSuccess: () {
              _onItemTapped(0);
            },
          ),
        ),
      PageDataModel(
        title: "Dashboard",
        screen: HomeOwnerScreen(),
        actions: [
          IconButton(
            padding: EdgeInsets.only( right: 16, ),
            onPressed: () => {
              ScaffoldMessenger.of(context).clearSnackBars(),
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 2),
                  content: Text("This feature is currently under development.")
                )
              )
            },
            icon: Icon(
              Icons.notifications, 
              size: 32,
              color: Colors.purple,
            ),
          ),
        ],
      ),
      const PageDataModel(
        title: "Rooms",
        screen:
            RoomOwnerScreen(), //delete Center, then replace with the class name of that page
      ),
      const PageDataModel(
        title: "Bills",
        screen:
            BillsOwnerScreen(), //delete Center, then replace with the class name of that page
      ),
      const PageDataModel(
        title: "Repairs",
        screen:
            RepairsOwnerScreen(), //delete Center, then replace with the class name of that page
      ),
      const PageDataModel(
        title: "Profile",
        screen:
            ProfileOwnerScreen(), //delete Center, then replace with the class name of that page
      ),
      PageDataModel(
          title: "Alert",
          screen: AlertTenantScreen(),
        ),
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
            actions: currentPage.actions,
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
            splashColor: ownerTheme.primary.withValues(
              alpha: 0.1,
            ), // สำหรับสีตอนกระจายตัว (ใช้ Colors.transparent สำหรับปิด)
            highlightColor: ownerTheme.secondary.withValues(alpha: 0.1), // สำหรับสีตอนกดค้าง
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex - 1,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,

            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            selectedItemColor: ownerTheme.primary,
            selectedFontSize: 13,
            selectedIconTheme: IconThemeData(size: 26),

            showUnselectedLabels: true,
            unselectedItemColor: ownerTheme.mutedColor,
            unselectedFontSize: 12,
            unselectedIconTheme: IconThemeData(size: 25),

            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: const Icon(Icons.home_outlined),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: const Icon(Icons.home),
                ),
                label: 'Home',
              ),

              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: const Icon(Icons.group_outlined),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: const Icon(Icons.group),
                ),
                label: 'Rooms',
              ),

              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: const Icon(Icons.receipt_long_outlined),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: const Icon(Icons.receipt_long),
                ),
                label: 'Bills',
              ),

              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: const Icon(Icons.build_outlined),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: const Icon(Icons.build),
                ),
                label: 'Repairs',
              ),

              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: const Icon(Icons.person_outline),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: const Icon(Icons.person),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
