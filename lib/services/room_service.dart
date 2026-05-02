import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dormcare/model/owner/room_model.dart';

class RoomService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _col = 'rooms';

  // READ — ดึงห้องทั้งหมดของ dorm (owner)
  Stream<List<RoomModel>> getRoomsByDorm(String dormId) {
    return _db
        .collection(_col)
        .where('dormId', isEqualTo: dormId)
        .orderBy('roomNumber')
        .snapshots()
        .map((snap) => snap.docs.map(_fromDoc).toList());
  }

  // READ — ดึงห้องของ tenant คนเดียว
  Future<RoomModel?> getRoomByTenant(String tenantId) async {
    final snap = await _db
        .collection(_col)
        .where('tenantId', isEqualTo: tenantId)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) return null;
    return _fromDoc(snap.docs.first);
  }

  // HELPER — แปลง Firestore doc → RoomModel
  RoomModel _fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RoomModel(
      roomId: data['roomId'] as String? ?? doc.id,
      imageUrl: data['imageUrl'] as String? ?? '',
      roomNumber: data['roomNumber'] as String? ?? '',
      roomFloor: data['roomFloor'] as String? ?? '',
      roomType: data['roomType'] as String? ?? '',
      price: (data['price'] as num).toDouble(),
      isOccupied: data['isOccupied'] as bool? ?? false,
      tenantId: data['tenantId'] as String?,
      tenantName: data['tenantName'] as String?,
      tenantPhone: data['tenantPhone'] as String?,
      tenantEmail: data['tenantEmail'] as String?,
      tenantMoveinDate: data['tenantMoveinDate'] != null
          ? (data['tenantMoveinDate'] as Timestamp).toDate()
          : null,
      tenantContractEndDate: data['tenantContractEndDate'] != null
          ? (data['tenantContractEndDate'] as Timestamp).toDate()
          : null,
    );
  }
}
