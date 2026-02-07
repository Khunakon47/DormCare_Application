import 'package:dormcare/component/custom_textbutton.dart';
import 'package:dormcare/component/greeting_container.dart';
import 'package:dormcare/component/revenue_card.dart';
import 'package:dormcare/model/room_data_model.dart';
import 'package:flutter/material.dart';

class BillsOwnerScreen extends StatelessWidget {
  const BillsOwnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<RoomDataModel> roomBills = [
      RoomDataModel(),
      RoomDataModel(),
      RoomDataModel(),
      RoomDataModel(),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          GreetingContainer(
            bgColor: [Color(0xFFAE36F3), Color(0xFF274EE9)], 
            title: "Room Bills", 
            subtitle: "Edit individual room bills and payment status",
          ),
          const SizedBox(height: 15),
          CustomTextbutton(
            icon: Icon(Icons.add),
            iconColor: Colors.white,
            iconSize: 28,
            textOnBtn: "Post New Monthly Bills",
            bgColor: [Colors.purple],
          ),
          const SizedBox(height: 15),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: RevenueCard(roomBills: roomBills),
          ),
        ],
      ),
    );
  }
}
