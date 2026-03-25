import 'package:dormcare/model/owner/bill_model.dart';
import 'package:dormcare/model/owner/room_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'post_bill_form_screen.dart';
import 'package:dormcare/theme/app_theme.dart';
import 'package:dormcare/component/room_select_card.dart';

class PostBillRoomSelectScreen extends StatelessWidget {
  final int year;
  final int month;
  final List<RoomModel> roomList;
  final List<BillModel> existingBills;

  const PostBillRoomSelectScreen({
    super.key,
    required this.year,
    required this.month,
    required this.roomList,
    required this.existingBills,
  });

  // ─── Build ───────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final monthLabel = DateFormat('MMMM yyyy').format(DateTime(year, month));

    // ห้องที่ออกบิลเดือนนี้ไปแล้ว
    final postedRooms = existingBills
        .where((b) => b.postedDate.year == year && b.postedDate.month == month)
        .map((b) => b.roomNumber)
        .toSet();

    final occupied = roomList.where((r) => r.isOccupied).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Select Room',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(color: Colors.grey.shade300, height: 1.0),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Month banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            color: const Color(0xFFF8F0FF),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  size: 16,
                  color: AppColors.ownerPrimary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Posting bills for $monthLabel',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ownerPrimary,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Occupied Rooms',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${occupied.length} rooms',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: occupied.isEmpty
                ? Center(
                    child: Text(
                      'No occupied rooms',
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
                    itemCount: occupied.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final room = occupied[index];
                      final isPosted = postedRooms.contains(room.roomNumber);
                      return RoomSelectCard(
                        room: room,
                        isPosted: isPosted,
                        onTap: isPosted
                            ? null
                            : () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PostBillFormScreen(
                                    year: year,
                                    month: month,
                                    room: room,
                                  ),
                                ),
                              ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
