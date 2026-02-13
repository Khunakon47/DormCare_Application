import 'package:dormcare/model/owner/monthly_billing_model.dart';
import 'package:dormcare/model/owner/repair_report_model.dart';
import 'package:dormcare/model/owner/room_model.dart';

class DormModel {
  final String dormId;
  final String dormName;
  final String address;
  final String image;
  final List<RoomModel> rooms;
  final List<RepairReportModel> repairReports;
  final List<MonthlyBillingModel> monthlyBills;

  DormModel({
    required this.dormId,
    required this.dormName,
    required this.address,
    required this.image,
    required this.rooms,
    required this.repairReports,
    required this.monthlyBills,
  });

  factory DormModel.fromJson(Map<String, dynamic> json) {
    return DormModel(
      dormId: json['dormId'],
      dormName: json['dormName'],
      address: json['address'],
      image: json['image'],
      rooms: (json['rooms'] as List)
          .map((e) => RoomModel.fromJson(e))
          .toList(),
      repairReports: (json['repairReports'] as List)
          .map((e) => RepairReportModel.fromJson(e))
          .toList(),
      monthlyBills: (json['monthlyBills'] as List)
          .map((e) => MonthlyBillingModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dormId': dormId,
      'dormName': dormName,
      'address': address,
      'image': image,
      'rooms': rooms.map((e) => e.toJson()).toList(),
      'repairReports': repairReports.map((e) => e.toJson()).toList(),
      'monthlyBills': monthlyBills.map((e) => e.toJson()).toList(),
    };
  }
}
