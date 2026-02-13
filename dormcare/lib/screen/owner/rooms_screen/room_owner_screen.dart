import 'package:dormcare/component/custom_textbutton.dart';
import 'package:dormcare/component/filter_sort.dart';
import 'package:dormcare/component/greeting_container.dart';
import 'package:dormcare/component/room_bottomsheet_filter.dart';
import 'package:dormcare/component/room_bottomsheet_sort.dart';
import 'package:dormcare/component/room_list_card.dart';
import 'package:dormcare/component/search_box.dart';
import 'package:dormcare/constants/dataset.dart'; // IMPORTANT
import 'package:flutter/material.dart';

class RoomOwnerScreen extends StatelessWidget {
  const RoomOwnerScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // ===== USE REAL DATA =====
    final rooms = roomList;

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
                bgColor: ownerTheme.bgGradientColors,
              ),

              SizedBox(height: 15),

              /// ===== SEARCH + FILTER =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SearchBox(),
                  const SizedBox(width: 8),

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
                    icon: Icon(Icons.swap_vert),
                    iconColor: Colors.purple,
                    bgColor: Colors.white,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(child: RoomBottomsheetSort());
                        },
                      );
                    },
                  ),
                ],
              ),

              SizedBox(height: 15),

              /// ===== ROOM LIST =====
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rooms.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),

                itemBuilder: (context, index) {
                  final room = rooms[index];

                  return RoomListCard(
                    room: room, // 👈 PASS REAL ROOM MODEL
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
