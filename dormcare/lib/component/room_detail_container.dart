import 'package:dormcare/component/custom_textbutton.dart';
import 'package:dormcare/model/owner/repair_report_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RoomDetailContainer extends StatelessWidget {
  const RoomDetailContainer({
    super.key,
    required this.title,
    required this.icon,

    /// 🔥 manual inject
    this.details = const {},
    this.status = const {},
    this.inListView,

    this.navBtn = false,
    this.textBtnOnly = true,
    this.shadowOff = true,
    this.topRight,
    this.boxShadowOn = true,
    this.bgColor = Colors.white,
    this.iconColor = Colors.blueAccent,
    this.iconSize = 28,
    this.fgColor = Colors.blueAccent,
  });

  final String title;
  final Icon icon;

  /// 🔥 manual maps
  final Map<String, String> details;
  final Map<String, Widget> status;
  final List<RepairReportModel>? inListView;

  final bool navBtn;
  final bool textBtnOnly;
  final bool shadowOff;
  final Widget? topRight;
  final bool boxShadowOn;
  final Color bgColor;
  final Color fgColor;
  final Color iconColor;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: boxShadowOn
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  offset: const Offset(0, 2),
                  blurRadius: 10,
                )
              ]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= HEADER =================
          Row(
            mainAxisAlignment: topRight == null
                ? MainAxisAlignment.start
                : MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon.icon, color: iconColor, size: iconSize),
                  const SizedBox(width: 6),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              if (topRight != null) topRight!,
            ],
          ),

          const SizedBox(height: 12),

          // ================= LIST SECTION =================
          if (inListView != null && inListView!.isNotEmpty) ...[
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: inListView!.length,
              itemBuilder: (context, index) {
                final repair = inListView![index];
                final formattedDate =
                    DateFormat('dd MMM yyyy').format(repair.date);

                Icon statusIcon;
                switch (repair.status.toLowerCase()) {
                  case 'done':
                    statusIcon =
                        const Icon(Icons.check_circle, color: Colors.green);
                    break;
                  case 'fixing':
                    statusIcon =
                        const Icon(Icons.build_circle, color: Colors.orange);
                    break;
                  default:
                    statusIcon =
                        const Icon(Icons.pending_actions, color: Colors.amber);
                }

                return Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      'Room ${repair.roomNumber} - ${repair.title}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    subtitle: Text(
                      formattedDate,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    trailing: statusIcon,
                  ),
                );
              },
              separatorBuilder: (_, _) => const SizedBox(height: 10),
            ),
            const SizedBox(height: 10),
          ],

          // ================= DETAILS =================
          ...details.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key,
                      style: const TextStyle(color: Colors.black)),
                  Text(entry.value,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),

          // ================= STATUS =================
          if (status.isNotEmpty) const SizedBox(height: 8),

          ...status.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key,
                      style: const TextStyle(color: Colors.black54)),
                  entry.value,
                ],
              ),
            ),
          ),

          const SizedBox(height: 15),

          // ================= NAV BUTTON =================
          if (navBtn)
            CustomTextbutton(
              textOnBtn: "View Full History",
              icon: const Icon(Icons.arrow_forward),
              iconColor: fgColor,
              iconSize: 22,
              bgColor: [bgColor],
              fgColor: fgColor,
              shadowOff: shadowOff,
              textBtnOnly: textBtnOnly,
            ),
        ],
      ),
    );
  }
}
