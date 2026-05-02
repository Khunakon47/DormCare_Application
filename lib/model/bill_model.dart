class BillModel {
  final String billId;
  final String dormId;
  final String roomNumber;
  final String? tenantId;
  final DateTime postedDate;
  final DateTime dueDate;
  final double rent;
  final double waterRate;
  final double waterUnit;
  final double electricRate;
  final double electricUnit;
  final double other;
  final bool isPaid;

  BillModel({
    required this.billId,
    required this.dormId,
    required this.roomNumber,
    this.tenantId,
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
      billId: json['billId'] ?? '',
      dormId: json['dormId'] ?? '',
      roomNumber: json['roomNumber'] ?? '',
      tenantId: json['tenantId'] as String?,
      postedDate: DateTime.parse(json['postedDate']),
      dueDate: DateTime.parse(json['dueDate']),
      rent: (json['rent'] as num).toDouble(),
      waterRate: (json['waterRate'] as num).toDouble(),
      waterUnit: (json['waterUnit'] as num).toDouble(),
      electricRate: (json['electricRate'] as num).toDouble(),
      electricUnit: (json['electricUnit'] as num).toDouble(),
      other: (json['other'] as num).toDouble(),
      isPaid: json['isPaid'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'billId': billId,
      'dormId': dormId,
      'roomNumber': roomNumber,
      'tenantId': tenantId,
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
      dormId: dormId,
      roomNumber: roomNumber,
      tenantId: tenantId,
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
