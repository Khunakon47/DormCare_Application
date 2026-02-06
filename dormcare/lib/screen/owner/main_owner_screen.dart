import 'package:dormcare/screen/owner/bills_screen/bills_owner_screen.dart';
import 'package:dormcare/screen/owner/home_screen/home_owner_screen.dart';
import 'package:dormcare/screen/owner/profile_screen/profile_owner_screen.dart';
import 'package:dormcare/screen/owner/repairs_screen/repairs_owner_screen.dart';
import 'package:dormcare/screen/owner/rooms_screen/room_owner_screen.dart';
import 'package:flutter/material.dart';
import '../../model/page_data_model.dart';

class MainOwnerScreen extends StatefulWidget {
  const MainOwnerScreen({super.key});

  @override
  State<MainOwnerScreen> createState() => _MainOwnerScreenState();
}

class _MainOwnerScreenState extends State<MainOwnerScreen> {
  int _selectedIndex = 0;

  final EdgeInsets paddingtop = EdgeInsets.only(top: 8);

  final List<PageDataModel> _pages = [
    PageDataModel(
      title: "Dashboard",
      screen: HomeOwnerScreen(), // do like this, for below pages
      actions: [
        IconButton(
          padding: EdgeInsets.only( right: 16, ),
          onPressed: () => {},
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
        title: Text(currentPage.title),
        actions: currentPage.actions,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(color: Colors.grey.shade300, height: 1.0),
        ),
      ),

      body: currentPage.screen,

      bottomNavigationBar: Container(
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

            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                label: 'Rooms',
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
                label: 'Bills',
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
                label: 'Repairs',
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
