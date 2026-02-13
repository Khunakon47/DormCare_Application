import 'package:dormcare/component/owner/filter_sort.dart';
import 'package:dormcare/component/tenant/greeting_container.dart';
import 'package:dormcare/component/owner/room_bottomsheet_filter.dart';
import 'package:dormcare/component/owner/room_bottomsheet_sort.dart';
import 'package:dormcare/component/owner/roombills.dart';
import 'package:dormcare/component/owner/search_box.dart';
import 'package:dormcare/constants/dataset.dart';
import 'package:dormcare/model/owner/monthly_billing_model.dart';
import 'package:dormcare/model/owner/room_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BillsView extends StatelessWidget {
  final List<RoomModel> roomList;
  final List<MonthlyBillingModel> bills;

  const BillsView({super.key, required this.bills, required this.roomList});

  String formatDate(DateTime? d) {
    if (d == null) return "-";
    return DateFormat('dd MMM yyyy').format(d);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Back", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GreetingContainer(bgColor: ownerTheme.bgGradientColors, title: DateFormat('MMM yyyy').format(bills.first.postedDate), subtitle: "subtitle"),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SearchBox(),
                const SizedBox(width: 8),

                FilterSort(
                  iconColor: Colors.blue,
                  icon: Icon(Icons.filter_alt_outlined),
                  bgColor: Colors.white,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(child: RoomBottomsheetFilter());
                      },
                    );
                  },
                ),

                const SizedBox(width: 8),

                FilterSort(
                  icon: Icon(Icons.swap_vert),
                  iconColor: Colors.purple,
                  bgColor: Colors.white,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(child: RoomBottomsheetSort());
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 15,),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: bills.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return Roombills(roomList: roomList[index], bill: bills[index]);
              },
            ),
          ],
        ),
      )
    );
  }
}
