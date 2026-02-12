import 'package:flutter/material.dart';
import 'package:dormcare/model/page_data_model.dart';

import 'login_screen/login_tenant_screen.dart';
import 'home_screen/home_tenant_screen.dart';
import 'expenses_screen/expenses_tenant_screen.dart';
import 'repair_screen/repair_tenant_screen.dart';
import 'alter_screen/alter_tenant_screen.dart';
import 'profile_screen/profile_tenant_screen.dart';

class MainTenantScreen extends StatefulWidget {
  const MainTenantScreen({
    super.key, 
    this.initialIndex = 4
  });

  final int initialIndex;

  @override
  State<MainTenantScreen> createState() => _MainTenantScreenState();
}

class _MainTenantScreenState extends State<MainTenantScreen> {
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
        screen: LoginTenantScreen(
          onLoginSuccess: () {
            _onItemTapped(0);
          },
        ),
      ),
      const PageDataModel(title: "Home", screen: HomeTenantScreen()),
      const PageDataModel(title: "Expenses", screen: ExpensesTenantScreen()),
      const PageDataModel(title: "Repairs", screen: RepairTenantScreen()),
      const PageDataModel(title: "Alerts", screen: AlertTenantScreen()),
      const PageDataModel(title: "Profile", screen: ProfileTenantScreen()),
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
          color: Colors.white,
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
            splashColor: const Color(0xFF367BF3).withValues(alpha: 0.1), // สำหรับสีตอนกระจายตัว (ใช้ Colors.transparent สำหรับปิด)
            highlightColor: const Color(0xFF367BF3).withValues(alpha: 0.1), // สำหรับสีตอนกดค้าง
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex - 1,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,

            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF367BF3),
            selectedFontSize: 13,
            selectedIconTheme: IconThemeData(size: 26),

            showUnselectedLabels: true,
            unselectedItemColor: Colors.grey,
            unselectedFontSize: 12,
            unselectedIconTheme: IconThemeData(size: 25),

            items: [
              // Home
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: const Icon(Icons.home_outlined),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: const Icon(Icons.home),
                ),
                label: 'Home',
              ),
              
              // Expenses
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: const Icon(Icons.receipt_long_outlined),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: const Icon(Icons.receipt_long),
                ),
                label: 'Expenses',
              ),

              // Repairs
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: const Icon(Icons.build_outlined),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: const Icon(Icons.build),
                ),
                label: 'Repairs',
              ),

              // Alerts
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: const Icon(Icons.notifications_outlined),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: const Icon(Icons.notifications),
                ),
                label: 'Alerts',
              ),

              // Profile
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: const Icon(Icons.person_outline),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(top: 8),
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
