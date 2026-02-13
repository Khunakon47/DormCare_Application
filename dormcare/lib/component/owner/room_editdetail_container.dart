import 'package:dormcare/component/owner/custom_textbutton.dart';
import 'package:dormcare/model/owner/repair_report_model.dart';
import 'package:flutter/material.dart';

class RoomEditdetailContainer extends StatelessWidget {
  const RoomEditdetailContainer({
    super.key,
    required this.title,
    required this.icon,

    /// 🔥 manual inject
    this.details = const {},
    this.status = const {},
    this.inListView,

    this.navBtn = false,
    this.textBtnOnly = true,
    this.shadowOn = false,
    this.bgColor = Colors.white,
    this.fgColor = Colors.blueAccent,
    this.iconColor = Colors.red,
    this.iconSize = 28,
    this.boxShadowOn = false,
  });

  final String title;
  final Icon icon;

  /// 🔥 editable textfields
  final Map<String, String> details;

  /// 🔥 widget status (dropdown/tag/switch etc)
  final Map<String, Widget> status;

  /// 🔥 repair/history list
  final List<RepairReportModel>? inListView;

  final bool navBtn;
  final bool textBtnOnly;
  final bool shadowOn;
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
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                )
              ]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= HEADER =================
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

          const SizedBox(height: 12),

          // ================= LIST =================
          if (inListView != null && inListView!.isNotEmpty) ...[
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: inListView!.length,
              itemBuilder: (context, index) {
                final maintenance = inListView![index];

                Icon statusIcon;
                switch (maintenance.status.toLowerCase()) {
                  case 'pending':
                    statusIcon =
                        const Icon(Icons.pending_actions, color: Colors.orange);
                    break;
                  case 'fixing':
                    statusIcon =
                        const Icon(Icons.build_circle, color: Colors.amber);
                    break;
                  default:
                    statusIcon =
                        const Icon(Icons.check_circle, color: Colors.green);
                }

                return Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      maintenance.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    subtitle: Text(
                      'Room ${maintenance.roomNumber}',
                      style: TextStyle(
                        color: Colors.black,
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

          // ================= EDITABLE DETAILS =================
          ...details.entries.map(
            (entry) => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 1,
                horizontal: 8
              ),
              margin: EdgeInsets.symmetric(
                vertical: 5
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key,
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14)),

                  SizedBox(
                    width: 140,
                    child: TextField(
                      controller: TextEditingController(text: entry.value),
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ================= STATUS =================
          if (status.isNotEmpty) const SizedBox(height: 6),

          ...status.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key,
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14)),
                  entry.value,
                ],
              ),
            ),
          ),

          const SizedBox(height: 15),

          // ================= NAV BTN =================
          if (navBtn)
            CustomTextbutton(
              textOnBtn: "View Full History",
              icon: const Icon(Icons.arrow_forward),
              iconColor: fgColor,
              iconSize: 22,
              bgColor: [bgColor],
              fgColor: fgColor,
              shadowOff: shadowOn,
              textBtnOnly: textBtnOnly,
            ),
        ],
      ),
    );
  }
}
