import 'package:dormcare/component/owner/custom_textbutton.dart';
import 'package:dormcare/component/owner/filter_sort.dart';
import 'package:dormcare/component/tenant/greeting_container.dart';
import 'package:dormcare/component/owner/room_bottomsheet_filter.dart';
import 'package:dormcare/component/owner/room_bottomsheet_sort.dart';
import 'package:dormcare/component/owner/room_list_card.dart';
import 'package:dormcare/component/owner/search_box.dart';
// import 'package:dormcare/constants/dataset.dart'; // IMPORTANT
import 'package:dormcare/model/owner/room_model.dart';
import 'package:flutter/material.dart';

class RoomOwnerScreen extends StatelessWidget {
  const RoomOwnerScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // ===== USE REAL DATA =====
    // final rooms = roomList;
    final List<RoomModel> roomList = [
      RoomModel(
        roomId: "r001",
        imageUrl: "https://picsum.photos/500/300",
        roomNumber: "A101",
        roomFloor:'1',
        roomType: 'Single',
        price: 3500,
        isOccupied: true,
        tenantName: "Somchai  Prasert",
        tenantPhone: "089-123-8574",
        tenantEmail: "john@gmail.com",
        tenantMoveinDate: DateTime(2024, 9, 1),
        tenantContractEndDate: DateTime(2025, 5, 31),
      ),
      RoomModel(
        roomId: "r002",
        imageUrl: "https://picsum.photos/500/300",
        roomNumber: "A102",
        roomFloor:'1',
        roomType: 'Studio',
        price: 3500,
        isOccupied: false,
        tenantName: null,
        tenantPhone: null,
        tenantEmail: null,
        tenantMoveinDate: null,
        tenantContractEndDate: null,
      ),
      RoomModel(
        roomId: "r003",
        imageUrl: "https://picsum.photos/500/300",
        roomNumber: "B201",
        roomFloor:'2',
        roomType: 'Single',
        price: 4200,
        isOccupied: true,
        tenantName: "Mika",
        tenantPhone: "0887776666",
        tenantEmail: "mika@gmail.com",
        tenantMoveinDate: DateTime(2026, 2, 5),
        tenantContractEndDate: DateTime(2026, 5, 5),
      ),
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
                bgColor: [Color.fromARGB(255,163, 76, 243), Color.fromARGB(255,79,69,226)],
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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: roomList.length,
                itemBuilder: (context, index) {
                  return RoomListCard(
                    room: roomList[index],
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
