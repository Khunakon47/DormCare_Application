import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dormcare/model/repair_model.dart';
import 'package:dormcare/services/notification_service.dart';

class RepairService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final NotificationService _notifService = NotificationService();
  final String _col = 'repairs';

  // CREATE — tenant รายงานปัญหา
  Future<String> submitRepair({
    required String dormId,
    required String roomNumber,
    required String tenantId,
    required String tenantName,
    required String phoneNumber,
    required String title,
    required String description,
    required RepairCategory category,
    String? imageUrl,
  }) async {
    final docRef = _db.collection(_col).doc();

    await docRef.set({
      'id': docRef.id,
      'dormId': dormId,
      'roomNumber': roomNumber,
      'tenantId': tenantId,
      'tenantName': tenantName,
      'phoneNumber': phoneNumber,
      'title': title,
      'description': description,
      'category': category.name,
      'status': RepairStatus.pending.name,
      'imageUrl': imageUrl,
      'reportedAt': FieldValue.serverTimestamp(),
    });

    return docRef.id;
  }

  // READ — ดึง repairs ของ dorm (owner)
  Stream<List<RepairModel>> getRepairsByDorm(String dormId) {
    return _db
        .collection(_col)
        .where('dormId', isEqualTo: dormId)
        .orderBy('reportedAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(_fromDoc).toList());
  }

  // READ — ดึง repairs ของ tenant
  Stream<List<RepairModel>> getRepairsByTenant(String tenantId) {
    return _db
        .collection(_col)
        .where('tenantId', isEqualTo: tenantId)
        .orderBy('reportedAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(_fromDoc).toList());
  }

  // UPDATE STATUS — owner อัปเดตสถานะ + แจ้ง tenant
  Future<void> updateStatus(String repairId, RepairStatus status) async {
    // 1. อัปเดตใน Firestore
    await _db.collection(_col).doc(repairId).update({'status': status.name});

    // 2. ดึงข้อมูล repair เพื่อส่ง notification
    final doc = await _db.collection(_col).doc(repairId).get();
    if (!doc.exists) return;

    final data = doc.data() as Map<String, dynamic>;
    final tenantId = data['tenantId'] as String?;
    final dormId = data['dormId'] as String?;
    final title = data['title'] as String? ?? 'Repair Request';

    // 3. แจ้ง tenant (ถ้ามี tenantId)
    if (tenantId != null && dormId != null) {
      await _notifService.notifyTenantRepairUpdated(
        tenantId: tenantId,
        dormId: dormId,
        roomNumber: data['roomNumber'] as String? ?? '',
        repairTitle: title,
        newStatus: status.name,
      );
    }
  }

  // HELPER — แปลง Firestore doc → RepairModel
  RepairModel _fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RepairModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      roomNumber: data['roomNumber'] ?? '',
      tenantName: data['tenantName'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      reportedAt:
          (data['reportedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      imageUrl: data['imageUrl'] as String?,
      status: RepairStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => RepairStatus.pending,
      ),
      category: RepairCategory.values.firstWhere(
        (e) => e.name == data['category'],
        orElse: () => RepairCategory.other,
      ),
      tenantId: data['tenantId'] as String?,
      dormId: data['dormId'] as String?,
    );
  }
}
