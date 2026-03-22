import 'package:flutter/material.dart';
import 'package:dormcare/model/page_data_model.dart';

import 'home_screen/home_owner_screen.dart';
import 'rooms_screen/room_owner_screen.dart';
import 'bills_screen/bills_owner_screen.dart';
import 'repairs_screen/repairs_owner_screen.dart';
import 'profile_screen/profile_owner_screen.dart';
import 'alter_screen/alter_owner_screen.dart';

class MainOwnerScreen extends StatefulWidget {
  const MainOwnerScreen({super.key});

  @override
  State<MainOwnerScreen> createState() => _MainOwnerScreenState();
}

class _MainOwnerScreenState extends State<MainOwnerScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<PageDataModel> pages = [
      const PageDataModel(title: "Dashboard", screen: HomeOwnerScreen()),
      const PageDataModel(title: "Rooms", screen: RoomOwnerScreen()),
      const PageDataModel(title: "Bills", screen: BillsOwnerScreen()),
      const PageDataModel(title: "Repairs", screen: RepairsOwnerScreen()),
      const PageDataModel(title: "Profile", screen: ProfileOwnerScreen()),
    ];

    final PageDataModel currentPage = pages[_selectedIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFA34CF3),
        foregroundColor: Color(0xFFFFFFFF),
        title: Text(
          currentPage.title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AlertOwnerScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 1.2,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // notification icon
                      const Icon(
                        Icons.notifications_outlined,
                        size: 24,
                        color: Colors.white,
                      ),

                      // badge(Ui only)
                      Positioned(
                        right: -1,
                        top: -1,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade300, height: 0.5),
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
            splashColor: Color(0xFFA34CF3).withValues(alpha: 0.1),
            highlightColor: Color(0xFF9436F3).withValues(alpha: 0.1),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,

            backgroundColor: Theme.of(context).scaffoldBackgroundColor,

            selectedItemColor: const Color(0xFFA34CF3),
            unselectedItemColor: Colors.grey,

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
                label: 'Rooms',
                icon: const Icon(Icons.meeting_room_outlined),
                activeIcon: const Icon(Icons.meeting_room),
              ),
              _buildBottomNavBarItem(
                label: 'Bills',
                icon: const Icon(Icons.receipt_long_outlined),
                activeIcon: const Icon(Icons.receipt_long),
              ),
              _buildBottomNavBarItem(
                label: 'Repairs',
                icon: const Icon(Icons.build_outlined),
                activeIcon: const Icon(Icons.build),
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