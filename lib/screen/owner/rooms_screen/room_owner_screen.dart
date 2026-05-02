import 'package:flutter/material.dart';
import 'room_detail_owner_screen.dart';
import 'package:dormcare/model/owner/room_model.dart';
import 'package:dormcare/component/room_card.dart';
import 'package:dormcare/theme/app_theme.dart';

class RoomOwnerScreen extends StatefulWidget {
  const RoomOwnerScreen({super.key});

  @override
  State<RoomOwnerScreen> createState() => _RoomOwnerScreenState();
}

class _RoomOwnerScreenState extends State<RoomOwnerScreen> {
  final List<RoomModel> _allRooms = [
    RoomModel(
      roomId: 'r001',
      imageUrl: 'https://picsum.photos/500/300?random=20',
      roomNumber: 'A101',
      roomFloor: '1',
      roomType: 'Single',
      price: 3500,
      isOccupied: true,
      tenantName: 'Somchai Prasert',
      tenantPhone: '089-123-8574',
      tenantEmail: 'somchai@gmail.com',
      tenantMoveinDate: DateTime(2024, 9, 1),
      tenantContractEndDate: DateTime(2025, 5, 31),
    ),
    RoomModel(
      roomId: 'r002',
      imageUrl: '',
      roomNumber: 'A102',
      roomFloor: '1',
      roomType: 'Studio',
      price: 3500,
      isOccupied: false,
      tenantName: null,
      tenantPhone: null,
      tenantEmail: null,
      tenantMoveinDate: null,
      tenantContractEndDate: null,
    ),
    RoomModel(
      roomId: 'r003',
      imageUrl: 'https://picsum.photos/500/300?random=21',
      roomNumber: 'B201',
      roomFloor: '2',
      roomType: 'Single',
      price: 4200,
      isOccupied: true,
      tenantName: 'Mika Tanaka',
      tenantPhone: '088-777-6666',
      tenantEmail: 'mika@gmail.com',
      tenantMoveinDate: DateTime(2026, 2, 5),
      tenantContractEndDate: DateTime(2026, 5, 5),
    ),
    RoomModel(
      roomId: 'r004',
      imageUrl: '',
      roomNumber: 'B202',
      roomFloor: '2',
      roomType: 'Deluxe',
      price: 5000,
      isOccupied: false,
      tenantName: null,
      tenantPhone: null,
      tenantEmail: null,
      tenantMoveinDate: null,
      tenantContractEndDate: null,
    ),
  ];

  List<RoomModel> get _filteredRooms => _allRooms;

  int get _occupiedCount => _allRooms.where((r) => r.isOccupied).length;
  int get _vacantCount => _allRooms.where((r) => !r.isOccupied).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('This feature is currently under development'),
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            ),
          );
        },
        backgroundColor: AppColors.ownerPrimary,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            _buildSummaryRow(),
            const SizedBox(height: 12),
            _buildSearchAndFilter(),
            const SizedBox(height: 10),
            _buildListHeader(),
            const SizedBox(height: 6),
            Expanded(
              child: _filteredRooms.isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
                      itemCount: _filteredRooms.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) => RoomCard(
                        room: _filteredRooms[index],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                RoomDetailScreen(room: _filteredRooms[index]),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow() {
    final total = _allRooms.length;
    final occupied = _occupiedCount;
    final vacant = _vacantCount;
    // circumference = 2 * pi * 28 ≈ 175.9 // เส้นรอบวง
    final occupiedArc = total == 0 ? 0.0 : (occupied / total) * 175.9;
    final vacantArc = total == 0 ? 0.0 : (vacant / total) * 175.9;
    final occupiedOffset = 0.0;
    final vacantOffset = -occupiedArc;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Donut chart
            SizedBox(
              width: 80,
              height: 80,
              child: CustomPaint(
                painter: _DonutPainter(
                  total: total,
                  occupiedArc: occupiedArc,
                  vacantArc: vacantArc,
                  occupiedOffset: occupiedOffset,
                  vacantOffset: vacantOffset,
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$total',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          height: 1,
                        ),
                      ),
                      Text(
                        'rooms',
                        style: TextStyle(
                          fontSize: 9,
                          color: AppColors.textTertiary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 20),

            // Legend
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLegendRow(
                    color: AppColors.ownerPrimary,
                    label: 'Occupied',
                    count: occupied,
                    total: total,
                  ),
                  const SizedBox(height: 10),
                  _buildLegendRow(
                    color: AppColors.success,
                    label: 'Vacant',
                    count: vacant,
                    total: total,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendRow({
    required Color color,
    required String label,
    required int count,
    required int total,
  }) {
    final pct = total == 0 ? 0 : ((count / total) * 100).round();
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          '$count',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '$pct%',
          style: TextStyle(fontSize: 11, color: AppColors.textTertiary),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.ownerPrimary.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, size: 18, color: AppColors.textTertiary),
                  const SizedBox(width: 8),
                  Text(
                    'Search by room or tenant...',
                    style: TextStyle(color: AppColors.textTertiary, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.ownerPrimary.withValues(alpha: 0.3)),
            ),
            child: const Icon(
              Icons.filter_alt_outlined,
              size: 20,
              color: AppColors.ownerPrimary,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.ownerPrimary.withValues(alpha: 0.3)),
            ),
            child: const Icon(Icons.sort, size: 20, color: AppColors.ownerPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildListHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'All Rooms',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '${_filteredRooms.length} rooms',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.divider,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.meeting_room_outlined,
              size: 32,
              color: AppColors.textDisabled,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No rooms found',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try adjusting your filters',
            style: TextStyle(color: AppColors.textTertiary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final int total;
  final double occupiedArc;
  final double vacantArc;
  final double occupiedOffset;
  final double vacantOffset;

  _DonutPainter({
    required this.total,
    required this.occupiedArc,
    required this.vacantArc,
    required this.occupiedOffset,
    required this.vacantOffset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final radius = (size.width / 2) - 8;
    const strokeWidth = 10.0;
    const startAngle = -1.5707963; // -π/2 (top)
    const fullCircle = 6.2831853; // 2π

    final bgPaint = Paint()
      ..color =AppColors.divider
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    canvas.drawCircle(Offset(cx, cy), radius, bgPaint);

    if (total == 0) return;

    void drawArc(Color color, double arcLength, double offset) {
      if (arcLength <= 0) return;
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;
      final sweep = (arcLength / 175.9) * fullCircle;
      final start = startAngle + (offset / 175.9) * fullCircle;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(cx, cy), radius: radius),
        start,
        sweep,
        false,
        paint,
      );
    }

    drawArc(AppColors.ownerPrimary, occupiedArc, occupiedOffset);
    drawArc(AppColors.success, vacantArc, vacantOffset);
  }

  @override
  bool shouldRepaint(_DonutPainter old) =>
      old.total != total ||
      old.occupiedArc != occupiedArc ||
      old.vacantArc != vacantArc;
}
