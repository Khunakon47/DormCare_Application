import 'package:dormcare/component/owner/custom_textbutton.dart';
import 'package:dormcare/component/tenant/greeting_container.dart';
import 'package:dormcare/component/owner/revenue_card.dart';
import 'package:dormcare/constants/dataset.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BillsOwnerScreen extends StatelessWidget {
  const BillsOwnerScreen({super.key});

  String formatDate(DateTime? d) {
    if (d == null) return "-";
    return DateFormat('dd MMM yyyy').format(d);
  }

  @override
  Widget build(BuildContext context) {

    final grouped = groupBillsByMonth(monthlyBills);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [

          GreetingContainer(
            bgColor: ownerTheme.bgGradientColors,
            title: "Room Bills",
            subtitle: "Monthly revenue overview",
          ),

          const SizedBox(height: 20),

          CustomTextbutton(
            shadowOff: false,
            icon: Icon(Icons.add),
            iconColor: Colors.white,
            fgColor: Colors.white,
            bgColor: [Colors.purple],
            textOnBtn: "Post New Monthly Bills",
            spacing: 10,
          ),

          const SizedBox(height: 20),

          ...grouped.entries.map((entry) {
            final monthBills = entry.value;
            return RevenueCard(
              roomLists: roomList,
              roomBills: monthBills,
            );

          })

        ],
      ),
    );
  }
}
