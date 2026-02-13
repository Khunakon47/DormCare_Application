import 'package:dormcare/component/owner/custom_textbutton.dart';
import 'package:dormcare/component/owner/tag.dart';
import 'package:dormcare/model/owner/room_model.dart';
import 'package:dormcare/screen/owner/rooms_screen/room_viewdetail_owner_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RoomListCard extends StatelessWidget {
  final RoomModel room;

  const RoomListCard({super.key, required this.room});
  String safe(dynamic v) => v?.toString() ?? "-";

  String formatDate(DateTime? d) {
    if (d == null) return "-";
    return DateFormat('dd MMM yyyy').format(d);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(room.image, fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Room - ${room.roomNumber}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Tag(type: StatusType.roomStatus, value: room.isOccupied?"Occupied":"Vaccant", text: room.isOccupied?"Occupied":"Vaccant"),
                  SizedBox(width: 10),
                  Tag(type: StatusType.room, value: room.roomType, text: room.roomType),  
                ],
              ),
            ],
          ),

          SizedBox(height: 10),

          Row(
            children: [
              Icon(Icons.person_outline),
              SizedBox(width: 10),
              Text(
                safe(room.tenantName),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          Row(
            children: [
              Icon(Icons.attach_money),
              SizedBox(width: 10),
              Text(
                '${room.price} THB/month',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          Row(
            children: [
              Icon(Icons.phone_outlined),
              SizedBox(width: 10),
              Text(
                safe(room.tenantPhone),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: CustomTextbutton(
              textOnBtn: "View Details",
              outLined: true,
              bgColor: [Colors.purple],
              fgColor: Colors.purple,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RoomViewdetail(room: room,)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
