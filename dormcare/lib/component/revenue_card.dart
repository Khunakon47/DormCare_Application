import 'package:dormcare/component/custom_textbutton.dart';
import 'package:dormcare/component/progressbar.dart';
import 'package:dormcare/component/stat_box.dart';
import 'package:dormcare/model/room_data_model.dart';
import 'package:dormcare/model/tenant_model.dart';
import 'package:dormcare/screen/owner/bills_screen/bills_view_owner_screen.dart';
import 'package:flutter/material.dart';

class RevenueCard extends StatelessWidget {
  final List<RoomDataModel> roomBills;
  final Color headerBgColor;
  final Color headerFgColor;
  final Color textColor;


  const RevenueCard({
    super.key,
    required this.roomBills,
    this.headerBgColor = const Color(0xFF112546),
    this.headerFgColor = Colors.white,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: roomBills.length,
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemBuilder: (context, index) {
        final bill = roomBills[index];

        final double collected = bill.totalUser == 0
            ? 0
            : bill.totalUserPaid / bill.totalUser;

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                offset: const Offset(0, 0),
                blurRadius: 10,
                spreadRadius: 0.2,
              ),
            ],
          ),
          child: Column(
            children: [
              // ===== MONTH HEADER =====
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: headerBgColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bill.postedMY,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: headerFgColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Posted on ${bill.postedDate}",
                          style: TextStyle(color: headerFgColor),
                        ),
                        Text(
                          "Due: ${bill.dueDate}",
                          style: TextStyle(color: headerFgColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ===== PAID / UNPAID =====
              Row(
                children: [
                  StatBox(
                    title: "Paid",
                    value: "${bill.totalUserPaid}/${bill.totalUser}",
                    amount: "${bill.rentFee} THB",
                    color: Colors.green,
                  ),
                  const SizedBox(width: 10),
                  StatBox(
                    title: "Unpaid",
                    value: "${bill.totalUserUnpaid}/${bill.totalUser}",
                    amount: "${bill.rentFee} THB",
                    color: Colors.red,
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // ===== PROGRESS =====
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Revenue",
                          style: TextStyle(fontSize: 10, color: textColor),
                        ),
                        Text(
                          "${(bill.rentFee * bill.totalUserPaid).toInt()} THB",
                          style: TextStyle(
                            fontSize: 16, color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Progressbar(values: collected, fgColor: Colors.green,),
                    const SizedBox(height: 6),

                    Text(
                      "${(collected * 100).toStringAsFixed(0)}% Collected",
                      style: TextStyle(fontSize: 10, color: textColor),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ===== VIEW BUTTON =====
              CustomTextbutton(
                textOnBtn: "View Details",
                bgColor: [bill.viewBtnColor],
                outLined: true,
                fgColor: Colors.purple,
                iconColor: Colors.purple,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BillsView(
                        tenantModel: [
                          TenantModel(),
                          TenantModel(),
                          TenantModel(),
                        ],
                        postedData: roomBills[index],
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