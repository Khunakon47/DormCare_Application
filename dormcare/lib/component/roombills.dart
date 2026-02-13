import 'package:dormcare/component/custom_textbutton.dart';
import 'package:dormcare/component/tag.dart';
import 'package:dormcare/model/owner/room_model.dart';
import 'package:dormcare/model/owner/monthly_billing_model.dart';
import 'package:dormcare/screen/owner/bills_screen/bills_edit_owner_screen.dart';
import 'package:flutter/material.dart';

class Roombills extends StatelessWidget {
  final RoomModel roomList;
  final MonthlyBillingModel bill;

  const Roombills({
    super.key,
    required this.roomList,
    required this.bill,
  });

  String safe(dynamic v) => v?.toString() ?? "-";

  @override
  Widget build(BuildContext context) {

    final total = bill.total;
    final waterTotal = bill.water * bill.waterUnit;
    final electricTotal = bill.electric * bill.electricUnit;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ===== ROOM + STATUS =====
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    roomList.roomNumber,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 10),

                  Tag(
                    type: StatusType.payment,
                    value: bill.isPaid,
                    text: bill.isPaid ? "Paid" : "Unpaid",
                  ),
                ],
              ),

              Text(
                '${total.toInt()} THB',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),

          const SizedBox(height: 5),

          // ===== roomList NAME =====
          Text(
            safe(roomList.tenantName),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 10),

          // ===== BILL DETAILS =====
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _billRow("Room Rent", "${bill.rent.toInt()} THB"),

                _billRow(
                  "Water (${bill.water} units × ${bill.waterUnit}฿)",
                  "${waterTotal.toInt()} THB",
                ),

                _billRow(
                  "Electric (${bill.electric} units × ${bill.electricUnit}฿)",
                  "${electricTotal.toInt()} THB",
                ),

                if (bill.other > 0)
                  _billRow("Other", "${bill.other.toInt()} THB"),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ===== ACTION BUTTONS =====
          Row(
            children: [

              Expanded(
                child: CustomTextbutton(
                  textOnBtn: bill.isPaid ? "Paid" : "Mark Paid",
                  outLined: true,
                  fgColor: Colors.black,
                  // toggle status logic later
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: CustomTextbutton(
                  textOnBtn: "Edit Info",
                  bgColor: const [Colors.purple],
                  fgColor: Colors.white,
                  icon: const Icon(Icons.edit_note),
                  iconColor: Colors.white,
                  iconSize: 22,
                  spacing: 8,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BillsEditOwner(bill: bill),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _billRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(color: Colors.black, fontSize: 12)),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
