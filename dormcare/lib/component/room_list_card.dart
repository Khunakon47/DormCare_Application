import 'package:dormcare/component/tag.dart';
import 'package:dormcare/screen/owner/rooms_screen/room_viewdetail_owner_screen.dart';
import 'package:dormcare/model/room_data_model.dart';
import 'package:flutter/material.dart';

class RoomListCard extends StatelessWidget {
  final RoomDataModel maintenance;

  const RoomListCard({super.key, required this.maintenance});

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
              child: Image.asset(maintenance.imageUrl, fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Room - ${maintenance.roomNumber}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              Tag(type: StatusType.roomStatus, value: maintenance.roomStats, text: maintenance.roomStats),
              SizedBox(width: 10),
              Tag(type: StatusType.room, value: maintenance.roomType, text: maintenance.roomType),
            ],
          ),

          SizedBox(height: 10),

          Row(
            children: [
              Icon(Icons.person_outline),
              SizedBox(width: 10),
              Text(
                maintenance.userName,
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
                '${maintenance.rentFee} THB/month',
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
                maintenance.phoneNum,
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
            child: OutlinedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RoomViewdetail()),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: maintenance.viewBtnColor, width: 1.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "View Details",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: maintenance.viewBtnTextColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
