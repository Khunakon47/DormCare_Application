import 'package:dormcare/component/custom_textbutton.dart';
import 'package:dormcare/model/repair_tenant_model.dart';
import 'package:dormcare/model/room_detail_model.dart';
import 'package:flutter/material.dart';

class RoomEditdetailContainer extends StatelessWidget {
  const RoomEditdetailContainer({
    super.key,
    required this.roomDetail,
    this.navBtn = false,
    this.textBtnOnly = true,
    this.shadowOn = false,
    this.inListView,
  });

  final RoomDetailModel roomDetail;
  final bool navBtn;
  final bool textBtnOnly;
  final bool shadowOn;
  final List<RepairTenant>? inListView;

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

          if (inListView != null)
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: inListView!.length,
              itemBuilder: (context, index) {
                final maintenance = inListView![index];

                return Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      maintenance.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      "${maintenance.date} ${maintenance.month}, ${maintenance.year}",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    trailing: maintenance.statusIcon,
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            ),

          ...(roomDetail.details ?? {}).entries.map(
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

          ...(roomDetail.status ?? {}).entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.key,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  entry.value,
                ],
              ),
            ),
          ),

          SizedBox(height: 15,),

          if (navBtn)
            CustomTextbutton(
              textOnBtn: "View Full History",
              icon: Icon(Icons.arrow_forward),
              iconColor: roomDetail.fgColor,
              iconSize: 24,
              bgColor: [roomDetail.bgColor],
              fgColor: roomDetail.fgColor,
              shadowOn: shadowOn,
              textBtnOnly: textBtnOnly,
            ),
        ],
      ),
    );
  }
}
