import 'package:flutter/material.dart';
import 'package:dormcare/model/page_data_model.dart';

import 'home_screen/home_tenant_screen.dart';
import 'expenses_screen/expenses_tenant_screen.dart';
import 'repair_screen/repair_tenant_screen.dart';
import 'alter_screen/alter_tenant_screen.dart';
import 'profile_screen/profile_tenant_screen.dart';

class MainTenantScreen extends StatefulWidget {
  const MainTenantScreen({super.key});

  @override
  State<MainTenantScreen> createState() => _MainTenantScreenState();
}

class _MainTenantScreenState extends State<MainTenantScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<PageDataModel> pages = [
      const PageDataModel(title: "Home", screen: HomeTenantScreen()),
      const PageDataModel(title: "Expenses", screen: ExpensesTenantScreen()),
      const PageDataModel(title: "Repairs", screen: RepairTenantScreen()),
      const PageDataModel(title: "Alerts", screen: AlertTenantScreen()),
      const PageDataModel(title: "Profile", screen: ProfileTenantScreen()),
    ];

    final PageDataModel currentPage = pages[_selectedIndex];

    return Scaffold(
      appBar: AppBar(
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

      bottomNavigationBar: Container(
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
            splashColor: const Color(0xFF367BF3).withValues(alpha: 0.1),
            highlightColor: const Color(0xFF367BF3).withValues(alpha: 0.1),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,

            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF367BF3),
            selectedFontSize: 13,
            selectedIconTheme: const IconThemeData(size: 26),

            showUnselectedLabels: true,
            unselectedItemColor: Colors.grey,
            unselectedFontSize: 12,
            unselectedIconTheme: const IconThemeData(size: 25),

            items: [
              // Home
              _buildBottomNavBarItem(
                lebel: 'Home',
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(Icons.home),
              ),
              // Expenses
              _buildBottomNavBarItem(
                lebel: 'Expenses',
                icon: const Icon(Icons.receipt_long_outlined),
                activeIcon: const Icon(Icons.receipt_long),
              ),
              // Repairs
              _buildBottomNavBarItem(
                lebel: 'Repairs',
                icon: const Icon(Icons.build_outlined),
                activeIcon: const Icon(Icons.build),
              ),
              // Alerts
              _buildBottomNavBarItem(
                lebel: 'Alerts',
                icon: const Icon(Icons.notifications_outlined),
                activeIcon: const Icon(Icons.notifications),
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

  // Private method to build BottomNavigationBarItem
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
