import 'package:dormcare/model/owner/monthly_billing_model.dart';
import 'package:dormcare/model/owner/room_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'post_bill_form_screen.dart';

class PostBillRoomSelectScreen extends StatelessWidget {
  final int year;
  final int month;
  final List<RoomModel> roomList;
  final List<MonthlyBillingModel> existingBills;

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
      backgroundColor: const Color(0xFFF7F8FA),
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
                  color: Color(0xFFA34CF3),
                ),
                const SizedBox(width: 8),
                Text(
                  'Posting bills for $monthLabel',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFA34CF3),
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
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final room = occupied[index];
                      final isPosted = postedRooms.contains(room.roomNumber);
                      return _RoomSelectCard(
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

// ─── Room Select Card ─────────────────────────────────────────────────────────

class _RoomSelectCard extends StatelessWidget {
  final RoomModel room;
  final bool isPosted;
  final VoidCallback? onTap;

  const _RoomSelectCard({
    required this.room,
    required this.isPosted,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isPosted ? 0.55 : 1.0,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isPosted ? Colors.grey.shade200 : Colors.grey.shade100,
            ),
            boxShadow: [
              if (!isPosted)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
            ],
          ),
          child: Row(
            children: [
              // Room badge
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(
                    0xFFA34CF3,
                  ).withValues(alpha: isPosted ? 0.05 : 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.meeting_room_outlined,
                  size: 20,
                  color: Color(0xFFA34CF3),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Room ${room.roomNumber}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0D1B2A),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 12,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          room.tenantName ?? '-',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.layers_outlined,
                          size: 12,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Floor ${room.roomFloor}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Status
              if (isPosted)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.check,
                        size: 12,
                        color: Color(0xFF66BB6A),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Posted',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFA34CF3).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Post Bill',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFA34CF3),
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 10,
                        color: Color(0xFFA34CF3),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
