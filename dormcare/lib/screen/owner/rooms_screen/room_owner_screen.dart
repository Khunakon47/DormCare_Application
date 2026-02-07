import 'package:dormcare/component/custom_textbutton.dart';
import 'package:dormcare/component/filter_sort.dart';
import 'package:dormcare/component/greeting_container.dart';
import 'package:dormcare/component/room_bottomsheet_filter.dart';
import 'package:dormcare/component/room_bottomsheet_sort.dart';
import 'package:dormcare/component/room_list_card.dart';
import 'package:dormcare/component/search_box.dart';
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
      floatingActionButton: CustomTextbutton(
        floatingButton: true,
        heroTag: 'room_list_fab',
        tooltip: 'Add Room',
        icon: Icon(Icons.add),
        iconColor: Colors.white,
        bgColor: [Colors.purple],
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
                  SearchBox(),

                  const SizedBox(width: 8), // Add spacing between widgets

                  FilterSort(
                    iconColor: Colors.blue,
                    icon: Icon(Icons.filter_alt_outlined),
                    bgColor: Colors.white,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(child: RoomBottomsheetFilter());
                        },
                      );
                    },
                  ),

                  const SizedBox(width: 8),

                  FilterSort(
                    icon: Icon(Icons.swap_vert,),
                    iconColor: Colors.purple,
                    bgColor: Colors.white,
                    onPressed: () => {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SizedBox(child: RoomBottomsheetSort());
                          },
                        ),
                      },
                  ),
                ],
              ),

              SizedBox(height: 15),

              Container(
                padding: EdgeInsets.zero,
                child: ListView.separated(
                  shrinkWrap: true, // กำหนดให้ ListView สูงเท่ากับจำนวนรายการจริง (ป้องกัน Error เรื่องความสูง) (ไม่ใช้ = Error)
                  physics: const NeverScrollableScrollPhysics(), // ปิดการเลื่อนในตัวเอง เพื่อให้เลื่อนตามหน้าจอหลักได้อย่างสมูธ

                  itemBuilder: (context, index) {
                    final maintenance = roominfo[index];
                    return RoomListCard(maintenance: maintenance);
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
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
