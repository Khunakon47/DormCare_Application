// import 'package:dormcare/constants/dataset.dart';
import 'package:dormcare/model/owner/dorm_model.dart';

class OwnerModel {
  final String ownerId;
  final String name;
  final String email;
  final String phone;
  final String profileImage;
  final DormModel dorm;

  OwnerModel({
    required this.ownerId,
    required this.name,
    required this.email,
    required this.phone,
    required this.profileImage,
    required this.dorm,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      ownerId: json['ownerId'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      profileImage: json['profileImage'],
      // dorms: (json['dorms'] as List)
      //     .map((e) => DormModel.fromJson(e))
      //     .toList(),
      dorm: DormModel.fromJson(json['dorm']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ownerId': ownerId,
      'name': name,
      'email': email,
      'phone': phone,
      'profileImage': profileImage,
      // 'dorms': dorms.map((e) => e.toJson()).toList(),
      'dorm': dorm.toJson(),
    };
  }
}
