import 'package:dormcare/component/greeting_container.dart';
import 'package:dormcare/component/room_bottomsheet_filter.dart';
import 'package:dormcare/component/room_bottomsheet_sort.dart';
import 'package:dormcare/component/room_list_card.dart';
import 'package:dormcare/model/room_data_model.dart';
import 'package:flutter/material.dart';

class RoomOwnerScreen extends StatelessWidget {
  const RoomOwnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<RoomDataModel> roominfo = [
      RoomDataModel(),
      RoomDataModel(),
      RoomDataModel(),
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        heroTag: 'room_list_fab',
        tooltip: "Add Room",
        backgroundColor: Colors.purple,
        child: Icon(Icons.add, color: Colors.white, size: 32),
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              GreetingContainer(
                title: "Room Management",
                subtitle: "Manage all rooms and tenants",
                bgColor: [
                  Colors.purple,
                  Colors.blue,
                ],
              ),

              SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Wrap the search container with Expanded
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 12,
                        top: 5,
                        right: 5,
                        bottom: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withValues(alpha: 0.1),
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
                            // Also wrap TextField with Expanded
                            child: TextField(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search by room...",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 8), // Add spacing between widgets

                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withValues(alpha: 0.1),
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
                          builder: (context) {
                            return SizedBox(child: RoomBottomsheetFilter());
                          },
                        );
                      },
                      icon: Icon(
                        Icons.filter_alt_outlined,
                        color: Colors.blue,
                        size: 32,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8), // Add spacing between widgets

                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () => {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SizedBox(child: RoomBottomsheetSort());
                          },
                        ),
                      },
                      icon: Icon(
                        Icons.swap_vert,
                        size: 32,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15),

              Container(
                padding: EdgeInsets.zero,
                child: ListView.separated(
                  shrinkWrap:
                      true, // กำหนดให้ ListView สูงเท่ากับจำนวนรายการจริง (ป้องกัน Error เรื่องความสูง) (ไม่ใช้ = Error)
                  physics:
                      const NeverScrollableScrollPhysics(), // ปิดการเลื่อนในตัวเอง เพื่อให้เลื่อนตามหน้าจอหลักได้อย่างสมูธ

                  itemBuilder: (context, index) {
                    final maintenance = roominfo[index];
                    return RoomListCard(maintenance: maintenance);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: roominfo.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
