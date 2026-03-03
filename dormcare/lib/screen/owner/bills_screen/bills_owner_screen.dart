import 'package:dormcare/component/owner/custom_textbutton.dart';
import 'package:dormcare/component/tenant/greeting_container.dart';
import 'package:dormcare/component/owner/revenue_card.dart';
import 'package:dormcare/model/owner/monthly_billing_model.dart';
import 'package:dormcare/model/owner/owner_app_theme.dart';
import 'package:dormcare/model/owner/room_model.dart';
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

    final OwnerAppTheme ownerTheme = OwnerAppTheme(
      primary: Color(0xFFA34CF3),
      secondary: const Color(0xFF9436F3),
      accent: const Color(0xFFFFB703),

      textPrimary: Colors.white,
      textSecondary: const Color(0xFFE0E0E0),
      textAccent: const Color(0xFFFFB703),

      mutedColor: const Color(0xFF9E9E9E),
      bgGradientColors: const [Color(0xFF367BF3), Color(0xFF9436F3)],
    );

    final List<MonthlyBillingModel> monthlyBills = [
      MonthlyBillingModel(
        billId: "bill001",
        roomNumber: "A101",
        postedDate: DateTime(2026, 1, 28),
        dueDate: DateTime(2026, 2, 5),
        rent: 3500,

        water: 12,        // 12 units used
        waterUnit: 15,    // 15฿ per unit

        electric: 120,    // 120 units used
        electricUnit: 7,  // 7฿ per unit

        other: 0,
        isPaid: true,
      ),
      MonthlyBillingModel(
        billId: "bill002",
        roomNumber: "A102",
        postedDate: DateTime(2026, 2, 28),
        dueDate: DateTime(2026, 5, 5),
        rent: 3500,

        water: 8,
        waterUnit: 15,

        electric: 90,
        electricUnit: 7,

        other: 0,
        isPaid: false,
      ),
      MonthlyBillingModel(
        billId: "bill003",
        roomNumber: "B201",
        postedDate: DateTime(2026, 1, 28),
        dueDate: DateTime(2026, 2, 5),
        rent: 4200,

        water: 15,
        waterUnit: 15,

        electric: 150,
        electricUnit: 7,

        other: 100,
        isPaid: true,
      ),
    ];

    Map<String, List<MonthlyBillingModel>> groupBillsByMonth(List<MonthlyBillingModel> bills) {
      Map<String, List<MonthlyBillingModel>> grouped = {};

      for (var bill in bills) {
        final key = "${bill.postedDate.year}-${bill.postedDate.month}";

        if (!grouped.containsKey(key)) {
          grouped[key] = [];
        }

        grouped[key]!.add(bill);
      }

      return grouped;
    }

    final List<RoomModel> roomList = [
      RoomModel(
        roomId: "r001",
        imageUrl: "https://picsum.photos/500/300",
        roomNumber: "A101",
        roomFloor:'1',
        roomType: 'Single',
        price: 3500,
        isOccupied: true,
        tenantName: "John",
        tenantPhone: "0991112222",
        tenantEmail: "john@gmail.com",
        tenantMoveinDate: DateTime(2026, 2, 5),
        tenantContractEndDate: DateTime(2026, 2, 5),
      ),
      RoomModel(
        roomId: "r002",
        imageUrl: "https://picsum.photos/500/300",
        roomNumber: "A102",
        roomFloor:'1',
        roomType: '2 Beds',
        price: 3500,
        isOccupied: false,
        tenantName: null,
        tenantPhone: null,
        tenantEmail: null,
        tenantMoveinDate: null,
        tenantContractEndDate: null,
      ),
      RoomModel(
        roomId: "r003",
        imageUrl: "https://picsum.photos/500/300",
        roomNumber: "B201",
        roomFloor:'2',
        roomType: 'Single',
        price: 4200,
        isOccupied: true,
        tenantName: "Mika",
        tenantPhone: "0887776666",
        tenantEmail: "mika@gmail.com",
        tenantMoveinDate: DateTime(2026, 2, 5),
        tenantContractEndDate: DateTime(2026, 5, 5),
      ),
    ];

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
