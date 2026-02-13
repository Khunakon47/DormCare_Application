import 'package:dormcare/component/owner/custom_textbutton.dart';
import 'package:dormcare/component/owner/progressbar.dart';
import 'package:dormcare/component/owner/stat_box.dart';
import 'package:dormcare/model/owner/monthly_billing_model.dart';
import 'package:dormcare/model/owner/room_model.dart';
import 'package:dormcare/screen/owner/bills_screen/bills_view_owner_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RevenueCard extends StatelessWidget {
  final List<MonthlyBillingModel> roomBills;
  final List<RoomModel> roomLists;

  const RevenueCard({
    super.key,
    required this.roomBills,
    required this.roomLists,
  });

  @override
  Widget build(BuildContext context) {
    final paid = roomBills.where((e)=>e.isPaid).length;
    final unpaid = roomBills.length - paid;

    final totalRevenue =
        roomBills.where((e)=>e.isPaid).fold(0.0,(s,b)=>s+b.total);

    final totalAll =
        roomBills.fold(0.0,(s,b)=>s+b.total); // ALL bills

    final percent = roomBills.isEmpty
      ? 0.0
      : paid / roomBills.length;
      


    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: roomBills.length,
      separatorBuilder: (_, _) => const SizedBox(height: 15),
      itemBuilder: (context, index) {

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            children: [

              // ===== HEADER =====
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF112546),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      DateFormat('MMM yyyy').format(roomBills.first.postedDate),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('MMM yyyy').format(roomBills.first.postedDate),
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          DateFormat('MMM yyyy').format(roomBills.first.dueDate),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // ===== STATUS =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Expanded(child: StatBox(
                  title: "Collected",
                  value: "$paid Paid",
                  amount: "${totalRevenue.toInt()} THB",
                  color: Colors.green,
                ),),
              const SizedBox(width: 10),
                Expanded(child: StatBox(
                  title: "Need",
                  value: "$unpaid Unpaid",
                  amount: "${totalRevenue.toInt()} THB",
                  color: Colors.orange,
                ),),
              ],),

              const SizedBox(height: 12),

              // ===== TOTAL =====
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total Bill"),
                        Text(
                          "${totalAll.toInt()} THB",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 8),

                    Progressbar(
                      values: percent,
                      fgColor: Colors.green,
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "${(percent * 100).toStringAsFixed(0)}% Collected",
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // ===== VIEW BUTTON =====
              CustomTextbutton(
                textOnBtn: "View Details",
                bgColor: const [Colors.purple],
                fgColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BillsView(
                        bills: roomBills,
                        roomList: roomLists,
                      ),
                    ),
                  );
                },

              ),
            ],
          ),
        );
      },
    );
  }
}
