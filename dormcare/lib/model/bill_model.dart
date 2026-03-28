class BillModel {
  final String billId;
  final String roomNumber;
  final DateTime postedDate;
  final DateTime dueDate;
  final double rent;
  final double waterRate; // ราคาต่อหน่วย (THB/unit)
  final double waterUnit; // หน่วยที่ใช้
  final double electricRate; // ราคาต่อหน่วย (THB/unit)
  final double electricUnit; // หน่วยที่ใช้
  final double other;
  final bool isPaid;

  BillModel({
    required this.billId,
    required this.roomNumber,
    required this.postedDate,
    required this.dueDate,
    required this.rent,
    required this.waterRate,
    required this.waterUnit,
    required this.electricRate,
    required this.electricUnit,
    required this.other,
    required this.isPaid,
  });

  // Computed
  double get waterAmount => waterRate * waterUnit;
  double get electricAmount => electricRate * electricUnit;
  double get total => rent + waterAmount + electricAmount + other;

  factory BillModel.fromJson(Map<String, dynamic> json) {
    return BillModel(
      billId: json['billId'],
      roomNumber: json['roomNumber'],
      postedDate: DateTime.parse(json['postedDate']),
      dueDate: DateTime.parse(json['dueDate']),
      rent: (json['rent'] as num).toDouble(),
      waterRate: (json['waterRate'] as num).toDouble(),
      waterUnit: (json['waterUnit'] as num).toDouble(),
      electricRate: (json['electricRate'] as num).toDouble(),
      electricUnit: (json['electricUnit'] as num).toDouble(),
      other: (json['other'] as num).toDouble(),
      isPaid: json['isPaid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'billId': billId,
      'roomNumber': roomNumber,
      'postedDate': postedDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'rent': rent,
      'waterRate': waterRate,
      'waterUnit': waterUnit,
      'electricRate': electricRate,
      'electricUnit': electricUnit,
      'other': other,
      'isPaid': isPaid,
    };
  }

  BillModel copyWith({
    bool? isPaid,
    double? waterUnit,
    double? electricUnit,
    double? other,
  }) {
    return BillModel(
      billId: billId,
      roomNumber: roomNumber,
      postedDate: postedDate,
      dueDate: dueDate,
      rent: rent,
      waterRate: waterRate,
      waterUnit: waterUnit ?? this.waterUnit,
      electricRate: electricRate,
      electricUnit: electricUnit ?? this.electricUnit,
      other: other ?? this.other,
      isPaid: isPaid ?? this.isPaid,
    );
  }
}
