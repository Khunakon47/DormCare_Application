class BillModel {
  final String billId;
  final String roomNumber;
  final DateTime postedDate;
  final DateTime dueDate;
  final double rent;
  final double waterRate;
  final double electricRate;
  final double other;
  final bool isPaid;
  final double waterUnit;
  final double electricUnit;

  BillModel({
    required this.billId,
    required this.roomNumber,
    required this.postedDate,
    required this.dueDate,
    required this.rent,
    required this.waterRate,
    required this.electricRate,
    required this.other,
    required this.isPaid,
    required this.waterUnit,
    required this.electricUnit,
  });

  double get total => rent + waterRate + electricRate + other;

  factory BillModel.fromJson(Map<String, dynamic> json) {
    return BillModel(
      billId: json['billId'],
      roomNumber: json['roomNumber'],
      postedDate: DateTime.parse(json['postedDate']),
      dueDate: DateTime.parse(json['dueDate']),
      rent: (json['rent'] as num).toDouble(),
      waterRate: (json['water'] as num).toDouble(),
      electricRate: (json['electric'] as num).toDouble(),
      other: (json['other'] as num).toDouble(),
      isPaid: json['isPaid'],
      waterUnit: (json['waterUnit'] as num).toDouble(),
      electricUnit: (json['electricUnit'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'billId': billId,
      'roomNumber': roomNumber,
      'postedDate': postedDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'rent': rent,
      'water': waterRate,
      'electric': electricRate,
      'other': other,
      'isPaid': isPaid,
      'waterUnit': waterUnit,
      'electricUnit': electricUnit,
    };
  }
}
