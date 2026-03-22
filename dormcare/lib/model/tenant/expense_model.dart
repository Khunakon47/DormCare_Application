import 'package:dormcare/utils/constants.dart';

enum ExpenseStatus { paid, unpaid }

class ExpenseModel {
  final String id;
  final String month;
  final String year;
  final int roomRent;
  final int waterUnits;
  final int electricityUnits;
  final int waterRate;
  final int electricityRate;
  final String billDate;
  final String dueDate;
  final ExpenseStatus status;
  final String paidDate;

  ExpenseModel({
    required this.id,
    required this.month,
    required this.year,
    required this.roomRent,
    required this.waterUnits,
    required this.electricityUnits,
    required this.billDate,
    required this.dueDate,
    required this.status,
    required this.paidDate,
    this.waterRate = AppConstants.defaultWaterRate,
    this.electricityRate = AppConstants.defaultElectricRate,
  });

  // Computed amounts
  int get waterBill => waterUnits * waterRate;
  int get electricityBill => electricityUnits * electricityRate;
  int get totalAmount => roomRent + waterBill + electricityBill;

  bool get isPaid => status == ExpenseStatus.paid;
}
