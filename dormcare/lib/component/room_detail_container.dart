import 'package:dormcare/component/tag.dart';
import 'package:dormcare/model/room_detail_model.dart';
import 'package:flutter/material.dart';

class RoomDetailContainer extends StatelessWidget {
  const RoomDetailContainer({super.key, required this.roomDetail});

  final RoomDetailModel roomDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: roomDetail.bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(roomDetail.icon.icon, color: roomDetail.iconColor, size: 28),
              SizedBox(width: 6),
              Text(
                roomDetail.title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          ...roomDetail.details.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.key,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  Text(
                    entry.value,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),

          if (roomDetail.isStatus) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Status", style: TextStyle(color: Colors.black54)),
                roomDetail.isPaid
                    ? const Tag(
                        bgColor: Colors.green,
                        fgColor: Colors.white,
                        text: "Paid",
                      )
                    : const Tag(
                        bgColor: Colors.red,
                        fgColor: Colors.white,
                        text: "Unpaid",
                      ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
