

import 'package:dormcare/component/room_bottomsheet_filter.dart';
import 'package:dormcare/component/room_bottomsheet_sort.dart';
import 'package:dormcare/component/room_list_card.dart';
import 'package:dormcare/model/room_data_model.dart';
import 'package:flutter/material.dart';

class RoomOwnerScreen extends StatelessWidget{
  const RoomOwnerScreen({super.key});


  @override
  Widget build(BuildContext context) {
    
    final List<RoomDataModel>roominfo = [
      RoomDataModel(),
      RoomDataModel(),
      RoomDataModel(),
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>{},
        heroTag: 'room_list_fab',
        tooltip: "Add Room",
        backgroundColor: Colors.purple,
        child: Icon(Icons.add, color: Colors.white, size: 32,),
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color.fromARGB(255, 174, 54, 243), // started color
                      const Color.fromARGB(255, 139, 39, 233), // ended color
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Room Management",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "Manage all rooms and tenants",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15,),

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
                          const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 10),
                          Expanded(  // Also wrap TextField with Expanded
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
                                )
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
                        showModalBottomSheet(context: context, 
                          builder: (context){
                            return SizedBox(
                              child: RoomBottomsheetFilter(),
                            );
                          }
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
                      onPressed: ()=>{
                        showModalBottomSheet(context: context, 
                          builder: (context){
                            return SizedBox(
                              child: RoomBottomsheetSort(),
                            );
                          }
                        )
                      }, 
                      icon: Icon(
                        Icons.swap_vert,
                        size: 32,
                        color: Colors.purple,
                      )
                    )
                  ),
                ],
              ),

              SizedBox(height: 15,),

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
                  itemCount: roominfo.length)
              ),
            ],
          ),
        )
      ),
    );
  }
}