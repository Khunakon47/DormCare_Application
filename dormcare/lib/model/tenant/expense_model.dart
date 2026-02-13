enum ExpenseStatus { paid, unpaid }

class ExpenseModel {
  final String id;
  final String month; // e.g. "December"
  final String year; // e.g. "2024"
  final int roomRent;
  final int waterUnits;
  final int electricityUnits;
  final int waterRate;
  final int electricityRate;

  final String billDate; // e.g. "Bill Date: 22 Jan 2025"
  final String dueDate; // e.g. "Due Date: 5 Jan 2025"

  final ExpenseStatus status;
  final String paidDate; // e.g. "Paid on Nov 1"

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
    this.waterRate = 18, // ค่า default
    this.electricityRate = 8, // ค่า default
  });

  // Getter คำนวณยอดเงินอัตโนมัติ
  int get waterBill => waterUnits * waterRate;
  int get electricityBill => electricityUnits * electricityRate;
  int get totalAmount => roomRent + waterBill + electricityBill;

  // Helper เช็คสถานะ
  bool get isPaid => status == ExpenseStatus.paid;
}
