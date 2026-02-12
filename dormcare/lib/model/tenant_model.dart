// we don't use this file anymore
// use expense_model.dart instead

class TenantModel {
  final String username;
  final String roomNumber;
  final bool statusPaid;
  final double rentFee;
  final double waterBill;
  final double electricBill;
  final double waterUnit;
  final double electricUnit;

  const TenantModel({
    this.username = "John Doe",
    this.roomNumber = "333",
    this.statusPaid = false,
    this.electricBill = 450,
    this.rentFee = 2500,
    this.waterBill = 180,
    this.electricUnit = 150,
    this.waterUnit = 18,
  });
}

// we don't use this file anymore
// use expense_model.dart instead