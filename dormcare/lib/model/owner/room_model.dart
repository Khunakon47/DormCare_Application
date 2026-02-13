

class RoomModel {
  final String roomId;
  final String imageUrl;
  final String roomNumber;
  final String roomFloor;
  final String roomType;
  final double price;
  final bool isOccupied;
  final String? tenantName;
  final String? tenantPhone;
  final String? tenantEmail;
  final DateTime? tenantMoveinDate;
  final DateTime? tenantContractEndDate;

  RoomModel({
    required this.roomId,
    required this.imageUrl,
    required this.roomNumber,
    required this.roomFloor,
    required this.roomType,
    required this.price,
    required this.isOccupied,
    this.tenantName,
    this.tenantPhone,
    this.tenantEmail,
    this.tenantContractEndDate,
    this.tenantMoveinDate,

  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      roomId: json['roomId'],
      imageUrl: json['imageUrl'],
      roomNumber: json['roomNumber'],
      roomFloor: json['roomFloor'],
      roomType: json['roomType'],
      price: json['price'],
      isOccupied: json['isOccupied'],
      tenantName: json['tenantName'] ?? "",
      tenantPhone: json['tenantPhone'] ?? "",
      tenantEmail: json['tenantEmail'] ?? "",
      tenantMoveinDate: json['tenantMoveinDate'] != null && json['tenantMoveinDate'] != ""
        ? DateTime.parse(json['tenantMoveinDate'])
        : null,
      tenantContractEndDate: json['tenantContractEndDate'] != null && json['tenantContractEndDate'] != ""
          ? DateTime.parse(json['tenantContractEndDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'imageUrl': imageUrl,
      'roomNumber': roomNumber,
      'roomFloor': roomFloor,
      'roomType': roomType,
      'price': price,
      'isOccupied': isOccupied,
      'tenantName': tenantName,
      'tenantPhone': tenantPhone,
      'tenantEmail': tenantEmail,
      'tenantMoveinDate': tenantMoveinDate?.toIso8601String(),
      'tenantContractEndDate': tenantContractEndDate?.toIso8601String(),
    };
  }
}
