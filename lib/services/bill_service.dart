import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dormcare/model/bill_model.dart';

class BillService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _col = 'bills';

  // CREATE — owner ออกบิล
  Future<String> postBill({
    required String dormId,
    required String roomNumber,
    String? tenantId,
    required DateTime postedDate,
    required DateTime dueDate,
    required double rent,
    required double waterRate,
    required double waterUnit,
    required double electricRate,
    required double electricUnit,
    double other = 0,
  }) async {
    final docRef = _db.collection(_col).doc();

    await docRef.set({
      'billId': docRef.id,
      'dormId': dormId,
      'roomNumber': roomNumber,
      'tenantId': tenantId,
      'postedDate': Timestamp.fromDate(postedDate),
      'dueDate': Timestamp.fromDate(dueDate),
      'rent': rent,
      'waterRate': waterRate,
      'waterUnit': waterUnit,
      'electricRate': electricRate,
      'electricUnit': electricUnit,
      'other': other,
      'isPaid': false,
    });

    return docRef.id;
  }

  // READ — ดึงบิลทั้งหมดของ dorm (owner)
  Stream<List<BillModel>> getBillsByDorm(String dormId) {
    return _db
        .collection(_col)
        .where('dormId', isEqualTo: dormId)
        .orderBy('postedDate', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(_fromDoc).toList());
  }

  // READ — ดึงบิลของ tenant (ต้องมี index: tenantId ASC + postedDate DESC)
  Stream<List<BillModel>> getBillsByTenant(String tenantId) {
    return _db
        .collection(_col)
        .where('tenantId', isEqualTo: tenantId)
        .orderBy('postedDate', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(_fromDoc).toList());
  }

  // UPDATE — owner อัปเดตสถานะการจ่าย + meter
  Future<void> updateBill(BillModel updated) async {
    await _db.collection(_col).doc(updated.billId).update({
      'waterUnit': updated.waterUnit,
      'electricUnit': updated.electricUnit,
      'other': updated.other,
      'isPaid': updated.isPaid,
    });
  }

  // HELPER — แปลง Firestore doc → BillModel
  BillModel _fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BillModel(
      billId: doc.id,
      dormId: data['dormId'] as String? ?? '',
      roomNumber: data['roomNumber'] as String? ?? '',
      tenantId: data['tenantId'] as String?,
      postedDate: (data['postedDate'] as Timestamp).toDate(),
      dueDate: (data['dueDate'] as Timestamp).toDate(),
      rent: (data['rent'] as num).toDouble(),
      waterRate: (data['waterRate'] as num).toDouble(),
      waterUnit: (data['waterUnit'] as num).toDouble(),
      electricRate: (data['electricRate'] as num).toDouble(),
      electricUnit: (data['electricUnit'] as num).toDouble(),
      other: (data['other'] as num).toDouble(),
      isPaid: data['isPaid'] as bool? ?? false,
    );
  }
}
