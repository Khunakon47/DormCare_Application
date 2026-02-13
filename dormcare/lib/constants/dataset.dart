import 'package:dormcare/model/owner/dorm_model.dart';
import 'package:dormcare/model/owner/monthly_billing_model.dart';
import 'package:dormcare/model/owner/owner_app_theme.dart';
import 'package:dormcare/model/owner/owner_model.dart';
import 'package:dormcare/model/owner/repair_report_model.dart';
import 'package:dormcare/model/owner/room_model.dart';
import 'package:dormcare/model/tenant_model.dart';
import 'package:flutter/material.dart';


List<TenantModel> generateTenantBills() {
  return monthlyBills.map((bill) {
    final room = roomList.firstWhere(
      (r) => r.roomNumber == bill.roomNumber,
    );

    return TenantModel(
      roomNumber: bill.roomNumber,
      username: room.tenantName ?? "Empty",
      rentFee: bill.rent,
      waterBill: bill.water,
      electricBill: bill.electric,
      waterUnit: bill.waterUnit,
      electricUnit: bill.electricUnit,
      statusPaid: bill.isPaid,
    );
  }).toList();
}

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




final OwnerModel ownerProfile = OwnerModel(
  ownerId: "owner001",
  name: "Somchai Wong",
  email: "somchai@gmail.com",
  phone: "0812345678",
  profileImage: "https://i.pravatar.cc/300",
  dorm: dormsList,
);

final OwnerAppTheme ownerTheme = OwnerAppTheme(
  primary: const Color(0xFF367BF3),
  secondary: const Color(0xFF9436F3),
  accent: const Color(0xFFFFB703),

  textPrimary: Colors.white,
  textSecondary: const Color(0xFFE0E0E0),
  textAccent: const Color(0xFFFFB703),

  mutedColor: const Color(0xFF9E9E9E),
  bgGradientColors: const [Color(0xFF367BF3), Color(0xFF9436F3)],
);


// ===============================================================
// ===============================================================
// ===============================================================

final DormModel dormsList = DormModel(
  dormId: "dorm001",
  dormName: "Green Ville Dorm",
  address: "Mukdahan, Thailand",
  image: "https://picsum.photos/500/300",
  rooms: roomList,
  repairReports: repairReports,
  monthlyBills: monthlyBills,
);

// ===============================================================
// ===============================================================
// ===============================================================


final List<RoomModel> roomList = [
  RoomModel(
    roomId: "r001",
    image: "https://picsum.photos/500/300",
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
    image: "https://picsum.photos/500/300",
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
    image: "https://picsum.photos/500/300",
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

// ===============================================================
// ===============================================================
// ===============================================================


final List<RepairReportModel> repairReports = [
  RepairReportModel(
    reportId: "rep001",
    roomNumber: "A101",
    title: "Air conditioner broken",
    description: "AC not cooling properly",
    status: "pending",
    date: DateTime(2026, 2, 5),
  ),
  RepairReportModel(
    reportId: "rep002",
    roomNumber: "B201",
    title: "Water leak",
    description: "Leak under sink",
    status: "fixing",
    date: DateTime(2026, 2, 6),
  ),
  RepairReportModel(
    reportId: "rep003",
    roomNumber: "A102",
    title: "Light bulb out",
    description: "Bathroom light not working",
    status: "done",
    date: DateTime(2026, 1, 28),
  ),
];

// ===============================================================
// ===============================================================
// ===============================================================

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


// ===============================================================
// ===============================================================
// ===============================================================
