import 'package:flutter/material.dart';
import 'package:dormcare/services/auth_service.dart';

class UserProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  Map<String, dynamic>? _userData;
  bool _isLoading = false;

  // Getters
  Map<String, dynamic>? get userData => _userData;
  bool get isLoading => _isLoading;

  // ข้อมูลที่ใช้บ่อย
  String get uid => _userData?['uid'] ?? '';
  String get name => _userData?['name'] ?? '';
  String get email => _userData?['email'] ?? '';
  String get phone => _userData?['phone'] ?? '';
  String get role => _userData?['role'] ?? '';
  String get dormId => _userData?['dormId'] ?? '';
  String get roomNumber => _userData?['roomNumber'] ?? '';

  bool get isOwner => role == 'owner';
  bool get isTenant => role == 'tenant';
  bool get isLoggedIn => _userData != null;

  // Load user data หลัง login
  Future<void> loadUser() async {
    _isLoading = true;
    notifyListeners();

    try {
      _userData = await _authService.getCurrentUserData();
    } catch (_) {
      _userData = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  // Set user data โดยตรง (ใช้หลัง login สำเร็จ)
  void setUser(Map<String, dynamic> data) {
    _userData = data;
    notifyListeners();
  }

  // Clear user data (ใช้ตอน logout)
  void clearUser() {
    _userData = null;
    notifyListeners();
  }
}
