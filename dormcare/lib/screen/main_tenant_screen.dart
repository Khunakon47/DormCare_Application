import 'package:dormcare/model/page_data_model.dart';
import 'package:dormcare/screen/profile_tenant_screen.dart';
import 'package:flutter/material.dart';
import 'home_tenant_screen.dart';

class MainTenantScreen extends StatefulWidget {
  const MainTenantScreen({super.key});

  @override
  State<MainTenantScreen> createState() => _MainTenantScreenState();
}

class _MainTenantScreenState extends State<MainTenantScreen> {
  int _selectedIndex = 0;

  final EdgeInsets paddingtop = EdgeInsets.only(top: 8);

  final List<PageDataModel> _pages = [
    const PageDataModel(
      title: "Home",
      screen: HomeTenantScreen(),
    ),
    const PageDataModel(
      title: "Expenses",
      screen: Center(child: Text("Expenses")),
      actions: [Padding(padding: EdgeInsets.only(right: 16),child: Icon(Icons.filter_list))],
    ),
    const PageDataModel(
      title: "Repairs",
      screen: Center(child: Text("Repairs")),
    ),
    const PageDataModel(
      title: "Alerts",
      screen: Center(child: Text("Alerts")),
    ),
    const PageDataModel(
      title: "Profile",
      screen: ProfileTenantScreen(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final PageDataModel currentPage = _pages[_selectedIndex];

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
            splashColor: const Color(0xFF367BF3).withValues(
              alpha: 0.1,
            ), // สำหรับสีตอนกระจายตัว (ใช้ Colors.transparent สำหรับปิด)
            highlightColor: const Color(
              0xFF367BF3,
            ).withValues(alpha: 0.1), // สำหรับสีตอนกดค้าง
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
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
              BottomNavigationBarItem(
                icon: Padding(
                  padding: paddingtop,
                  child: const Icon(Icons.home_outlined),
                ),
                activeIcon: Padding(
                  padding: paddingtop,
                  child: const Icon(Icons.home),
                ),
                label: 'Home',
              ),

              BottomNavigationBarItem(
                icon: Padding(
                  padding: paddingtop,
                  child: const Icon(Icons.receipt_long_outlined),
                ),
                activeIcon: Padding(
                  padding: paddingtop,
                  child: const Icon(Icons.receipt_long),
                ),
                label: 'Expenses',
              ),

              BottomNavigationBarItem(
                icon: Padding(
                  padding: paddingtop,
                  child: const Icon(Icons.build_outlined),
                ),
                activeIcon: Padding(
                  padding: paddingtop,
                  child: const Icon(Icons.build),
                ),
                label: 'Repairs',
              ),

              BottomNavigationBarItem(
                icon: Padding(
                  padding: paddingtop,
                  child: const Icon(Icons.notifications_outlined),
                ),
                activeIcon: Padding(
                  padding: paddingtop,
                  child: const Icon(Icons.notifications),
                ),
                label: 'Alerts',
              ),

              BottomNavigationBarItem(
                icon: Padding(
                  padding: paddingtop,
                  child: const Icon(Icons.person_outline),
                ),
                activeIcon: Padding(
                  padding: paddingtop,
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
