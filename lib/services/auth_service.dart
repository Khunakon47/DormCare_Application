import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ── Current user ──
  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // LOGIN
  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final uid = credential.user!.uid;

      final doc = await _db.collection('users').doc(uid).get();
      if (!doc.exists) throw Exception('User data not found in database');

      return {'uid': uid, ...doc.data()!};
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  // LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }

  // GET USER DATA
  Future<Map<String, dynamic>?> getCurrentUserData() async {
    final uid = currentUser?.uid;
    if (uid == null) return null;

    final doc = await _db.collection('users').doc(uid).get();
    if (!doc.exists) return null;

    return {'uid': uid, ...doc.data()!};
  }

  // CREATE TENANT ACCOUNT
  Future<void> createTenantAccount({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String dormId,
    required String roomNumber,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    final uid = credential.user!.uid;

    await _db.collection('users').doc(uid).set({
      'uid': uid,
      'name': name.trim(),
      'email': email.trim(),
      'phone': phone.trim(),
      'role': 'tenant',
      'dormId': dormId,
      'roomNumber': roomNumber,
      'fcmToken': null,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // UPDATE FCM TOKEN
  Future<void> updateFcmToken(String token) async {
    final uid = currentUser?.uid;
    if (uid == null) return;
    await _db.collection('users').doc(uid).update({'fcmToken': token});
  }

  // ERROR HANDLER
  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      // Firebase SDK ใหม่ใช้ code นี้แทน wrong-password + user-not-found
      case 'invalid-credential':
        return 'Incorrect email or password';
      // เผื่อ SDK เก่ายังส่งมา
      case 'user-not-found':
        return 'No account found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'invalid-email':
        return 'Invalid email format';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later';
      case 'network-request-failed':
        return 'No internet connection. Please check your network';
      default:
        // แสดง error code จริงด้วยเพื่อ debug
        return 'Login failed (${e.code})';
    }
  }
}
