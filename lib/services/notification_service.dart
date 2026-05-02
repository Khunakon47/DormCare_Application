import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dormcare/model/owner/alert_owner_model.dart';
import 'package:dormcare/model/tenant/alert_tenant_model.dart';

class NotificationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final String _col = 'notifications';

  // INIT
  Future<String?> init() async {
    await _messaging.requestPermission(alert: true, badge: true, sound: true);
    final token = await _messaging.getToken();
    return token;
  }

  // SEND — แจ้ง owner เมื่อ tenant report repair
  Future<void> notifyOwnerNewRepair({
    required String dormId,
    required String roomNumber,
    required String tenantName,
    required String repairTitle,
  }) async {
    final dormDoc = await _db.collection('dorms').doc(dormId).get();
    if (!dormDoc.exists) return;

    final ownerId = dormDoc.data()?['ownerId'] as String?;
    if (ownerId == null) return;

    await _db.collection(_col).add({
      'userId': ownerId,
      'dormId': dormId,
      'title': 'New Repair Request',
      'description': 'Room $roomNumber ($tenantName) reported: $repairTitle',
      'category': AlertOwnerCategory.repairRequest.name,
      'roomNumber': roomNumber,
      'tenantName': tenantName,
      'isRead': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // SEND — แจ้ง tenant เมื่อ owner อัปเดต repair status
  Future<void> notifyTenantRepairUpdated({
    required String tenantId,
    required String dormId,
    required String roomNumber,
    required String repairTitle,
    required String newStatus,
  }) async {
    // แปลง status เป็นข้อความที่อ่านง่าย
    final statusText = switch (newStatus) {
      'inProgress' => 'In Progress',
      'completed' => 'Completed',
      'cancelled' => 'Cancelled',
      _ => newStatus,
    };

    await _db.collection(_col).add({
      'userId': tenantId,
      'dormId': dormId,
      'title': 'Repair Status Updated',
      'description':
          'Your repair request "$repairTitle" has been updated to: $statusText',
      'category': AlertCategory.general.name,
      'isRead': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // SEND — แจ้ง tenant เรื่องบิล
  Future<void> notifyTenantBillReminder({
    required String tenantId,
    required String dormId,
    required String roomNumber,
    required String monthLabel,
    required String dueDate,
  }) async {
    await _db.collection(_col).add({
      'userId': tenantId,
      'dormId': dormId,
      'title': 'Bill Due Reminder',
      'description':
          'Your bill for $monthLabel is due on $dueDate. Please pay on time.',
      'category': AlertCategory.bill.name,
      'roomNumber': roomNumber,
      'isRead': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // READ — owner notifications
  Stream<List<AlertOwnerModel>> getOwnerNotifications(String userId) {
    return _db
        .collection(_col)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(_toOwnerAlert).toList());
  }

  // READ — tenant notifications
  Stream<List<AlertTenantModel>> getTenantNotifications(String userId) {
    return _db
        .collection(_col)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(_toTenantAlert).toList());
  }

  // UPDATE — mark as read
  Future<void> markAsRead(String notifId) async {
    await _db.collection(_col).doc(notifId).update({'isRead': true});
  }

  Future<void> markAllAsRead(String userId) async {
    final batch = _db.batch();
    final snap = await _db
        .collection(_col)
        .where('userId', isEqualTo: userId)
        .where('isRead', isEqualTo: false)
        .get();
    for (final doc in snap.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit();
  }

  // HELPERS
  AlertOwnerModel _toOwnerAlert(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AlertOwnerModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      category: AlertOwnerCategory.values.firstWhere(
        (e) => e.name == data['category'],
        orElse: () => AlertOwnerCategory.general,
      ),
      roomNumber: data['roomNumber'] as String?,
      tenantName: data['tenantName'] as String?,
      isRead: data['isRead'] as bool? ?? false,
    );
  }

  AlertTenantModel _toTenantAlert(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AlertTenantModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      category: AlertCategory.values.firstWhere(
        (e) => e.name == data['category'],
        orElse: () => AlertCategory.general,
      ),
      isRead: data['isRead'] as bool? ?? false,
    );
  }
}
