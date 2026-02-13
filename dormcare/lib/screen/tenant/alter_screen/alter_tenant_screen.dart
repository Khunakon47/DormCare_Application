import 'package:dormcare/component/tenant/alert_card.dart';
import 'package:dormcare/component/tenant/alert_filter_sheet.dart';
import 'package:dormcare/component/tenant/alert_sort_sheet.dart'; 
import 'package:dormcare/model/tenant/alert_model.dart';
import 'package:flutter/material.dart';
import 'package:dormcare/component/tenant/greeting_container.dart';

class AlertTenantScreen extends StatefulWidget {
  const AlertTenantScreen({super.key});

  @override
  State<AlertTenantScreen> createState() => _AlertTenantScreenState();
}

class _AlertTenantScreenState extends State<AlertTenantScreen> {
  // Mock Data
  final List<AlertModel> _allAlerts = [
    AlertModel(
      id: '1',
      title: 'Water Cut Announcement',
      description:
          'Water supply will be suspended for maintenance on 15 Feb from 10:00 AM to 2:00 PM.',
      date: 'Today',
      category: AlertCategory.emergency,
      isRead: false,
    ),
    AlertModel(
      id: '2',
      title: 'Parcel Arrived',
      description: 'You have a package waiting at the front desk. (Box #A12)',
      date: 'Yesterday',
      category: AlertCategory.parcel,
      isRead: false,
    ),
    AlertModel(
      id: '3',
      title: 'Electricity Bill Due',
      description:
          'Your electricity bill for January is ready. Please pay before the 25th.',
      date: 'Jan 10',
      category: AlertCategory.bill,
      isRead: true,
    ),
    AlertModel(
      id: '4',
      title: 'Gym Cleaning Schedule',
      description:
          'The gym will be closed for deep cleaning every Monday morning.',
      date: 'Jan 05',
      category: AlertCategory.general,
      isRead: true,
    ),
  ];

  List<AlertModel> _displayedAlerts = [];
  AlertCategory? _selectedCategory; // Null = All
  bool? _selectedReadStatus;        // Null = All, True = Read, False = Unread
  AlertSortOption _currentSort = AlertSortOption.newest;

  @override
  void initState() {
    super.initState();
    _processData(); // เรียกใช้ตอนเริ่มเพื่อโหลดข้อมูล
  }

  void _processData() {
    setState(() {
      // 1. Filter
      var result = _allAlerts.where((alert) {
        bool matchCategory = _selectedCategory == null || alert.category == _selectedCategory;
        bool matchRead = _selectedReadStatus == null || alert.isRead == _selectedReadStatus;
        return matchCategory && matchRead;
      }).toList();

      // 2. Sort
      // ถ้าใช้ข้อมูลจริง ต้องแก้จุดนี้(เปลี่ยนจากString ใน model เป็นวันที่จริง)
      if (_currentSort == AlertSortOption.unreadFirst) {
        result.sort((a, b) {
           if (a.isRead == b.isRead) return 0;
           return a.isRead ? 1 : -1; // ในไฟล์Model default คือ False (Unread) มาก่อน True
        });
      } else if (_currentSort == AlertSortOption.oldest) {
        result = result.reversed.toList();
      }
      // Newest ไม่ต้องทำอะไรเพราะ Mock Data เรียงมาแล้ว

      _displayedAlerts = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
          // Header
          Container(
             padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
             child: const GreetingContainer(
              bgColor: [Color(0xFF367BF3), Color(0xFF2761E9)],
              title: "Notifications",
              icon: Icon(Icons.notifications_active),
              subtitle: "Stay updated with dorm news",
            ),
          ),

          const SizedBox(height: 16),

          // Search & Filter Area
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Search bar
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.grey),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              // เพิ่มทีหลัง
                            },
                            style: const TextStyle(color: Colors.black, fontSize: 14),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search...",
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          
                const SizedBox(width: 8),
          
                // Filter button
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true, // Modal จะถูกจำกัดความสูงไว้ที่ ไม่เกินครึ่งหน้าจอ (50%) เสมอ, true อนุญาตให้ยืดหยุ่นเกินครึ่งหน้าจอได้ กรณีเนื้อหายาว
                        useSafeArea: true,        // ป้องกันเนื้อหาทับ Status bar(Tabที่แสดงเวลา, แบตเตอรี่, สัญญาณมือถือ)(ข้างบนสุดของจอมือถือ) กรณีเนื้อหายาวมากอาจทำให้ทับกัน
                        showDragHandle: true,     // แสดงเส้นขีดเล็กๆ บนสุดของ Modal เพื่อบอกผู้ใช้ว่าสามารถลากปิดได้
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) {
                          return AlertFilterSheet(
                            initialCategory: _selectedCategory,
                            initialReadStatus: _selectedReadStatus,
                            onApply: (category, isRead) {
                              _selectedCategory = category;
                              _selectedReadStatus = isRead;
                              _processData(); // อัปเดตหน้าจอ
                            },
                          );
                        },
                      );
                    },
                    // ------------------------------------
                    icon: Icon(
                      Icons.filter_alt_outlined,
                      // เปลี่ยนสีถ้ามีการ Filter ค้างไว้
                      color: (_selectedCategory != null || _selectedReadStatus != null) ? Colors.orange : Colors.blue,
                      size: 30,
                    ),
                  ),
                ),
          
                const SizedBox(width: 8),
          
                // Sort button
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled:
                            true, // Modal จะถูกจำกัดความสูงไว้ที่ ไม่เกินครึ่งหน้าจอ (50%) เสมอ, true อนุญาตให้ยืดหยุ่นเกินครึ่งหน้าจอได้ กรณีเนื้อหายาว
                        useSafeArea:
                            true, // ป้องกันเนื้อหาทับ Status bar(Tabที่แสดงเวลา, แบตเตอรี่, สัญญาณมือถือ)(ข้างบนสุดของจอมือถือ) กรณีเนื้อหายาวมากอาจทำให้ทับกัน
                        showDragHandle:
                            true, // แสดงเส้นขีดเล็กๆ บนสุดของ Modal เพื่อบอกผู้ใช้ว่าสามารถลากปิดได้
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) {
                          return AlertSortSheet(
                            currentSort: _currentSort,
                            onApply: (sortOption) {
                              _currentSort = sortOption;
                              _processData(); // อัปเดตหน้าจอ
                            },
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.swap_vert, size: 30, color: Colors.purple),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Alert List
          Expanded(
            child: _displayedAlerts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_off_outlined, size: 80, color: Colors.grey.shade300),
                        const SizedBox(height: 16),
                        Text("No notifications found", style: TextStyle(color: Colors.grey.shade500, fontSize: 16)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _displayedAlerts.length,
                    itemBuilder: (context, index) {
                      return AlertCard(
                        data: _displayedAlerts[index],
                        onTap: () {
                          setState(() {
                             // อัปเดตตัวแปรจริงใน _allAlerts
                             final id = _displayedAlerts[index].id;
                             final originalIndex = _allAlerts.indexWhere((e) => e.id == id);
                             if (originalIndex != -1) {
                               _allAlerts[originalIndex].isRead = true;
                             }
                             _processData();
                          });

                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("${_displayedAlerts[index].title} marked as read."),
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}