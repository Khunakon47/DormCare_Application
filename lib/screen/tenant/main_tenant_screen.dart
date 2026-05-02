import 'package:flutter/material.dart';
import 'package:dormcare/model/page_data_model.dart';

import 'home_screen/home_tenant_screen.dart';
import 'expenses_screen/expenses_tenant_screen.dart';
import 'repair_screen/repair_tenant_screen.dart';
import 'alter_screen/alter_tenant_screen.dart';
import 'profile_screen/profile_tenant_screen.dart';

import 'package:dormcare/theme/app_theme.dart';

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
      const PageDataModel(title: "Monthly Bills", screen: ExpensesTenantScreen()),
      const PageDataModel(title: "Repairs Report", screen: RepairTenantScreen()),
      const PageDataModel(title: "Notifications", screen: AlertTenantScreen()),
      const PageDataModel(title: "Profile", screen: ProfileTenantScreen()),
    ];

    final PageDataModel currentPage = pages[_selectedIndex];

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: AppColors.tenantPrimary,
        title: Text(
          currentPage.title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: AppColors.tenantPrimary),          
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.textDisabled, height: 0.5),
        ),
      ),

      body: currentPage.screen,

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.textSecondary.withValues(alpha: 0.2),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: AppColors.tenantPrimary.withValues(alpha: 0.1),
            highlightColor: AppColors.tenantPrimary.withValues(alpha: 0.1),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,

            backgroundColor: Theme.of(context).scaffoldBackgroundColor,

            selectedItemColor: AppColors.tenantPrimary,
            unselectedItemColor: AppColors.textSecondary,

            selectedFontSize: 13,
            unselectedFontSize: 12,

            selectedIconTheme: const IconThemeData(size: 26),
            unselectedIconTheme: const IconThemeData(size: 24),

            showUnselectedLabels: true,

            items: [
              _buildBottomNavBarItem(
                label: 'Home',
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(Icons.home),
              ),
              _buildBottomNavBarItem(
                label: 'Expenses',
                icon: const Icon(Icons.receipt_long_outlined),
                activeIcon: const Icon(Icons.receipt_long),
              ),
              _buildBottomNavBarItem(
                label: 'Repairs',
                icon: const Icon(Icons.build_outlined),
                activeIcon: const Icon(Icons.build),
              ),
              _buildBottomNavBarItem(
                label: 'Alerts',
                icon: const Icon(Icons.notifications_outlined),
                activeIcon: const Icon(Icons.notifications),
              ),
              _buildBottomNavBarItem(
                label: 'Profile',
                icon: const Icon(Icons.person_outline),
                activeIcon: const Icon(Icons.person),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavBarItem({
    required String label,
    required Icon icon,
    required Icon activeIcon,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(padding: EdgeInsets.only(top: 8), child: icon),
      activeIcon: Padding(padding: EdgeInsets.only(top: 8), child: activeIcon),
      label: label,
    );
  }
}