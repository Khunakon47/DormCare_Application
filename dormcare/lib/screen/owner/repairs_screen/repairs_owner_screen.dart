import 'package:flutter/material.dart';
import 'package:dormcare/model/owner/repair_owner_model.dart';
import 'repair_detail_owner_screen.dart';

class RepairsOwnerScreen extends StatefulWidget {
  const RepairsOwnerScreen({super.key});

  @override
  State<RepairsOwnerScreen> createState() => _RepairsOwnerScreenState();
}

class _RepairsOwnerScreenState extends State<RepairsOwnerScreen> {
  int _selectedStatusIndex = 0;
  int _selectedFloorIndex = 0; // 0 = All, 1–5 = Floor 1–5

  // Mock data
  final List<RepairOwnerModel> _allRepairs = [
    RepairOwnerModel(
      id: '1',
      title: 'TV Broken',
      description:
          'The TV in the living room is not turning on. Need replacement.',
      roomNumber: '101',
      tenantName: 'Somchai K.',
      phoneNumber: '081-234-5678',
      imageUrl: 'https://picsum.photos/500/300?random=10',
      reportedAt: DateTime(2024, 12, 10, 9, 30),
      status: RepairOwnerStatus.pending,
    ),
    RepairOwnerModel(
      id: '2',
      title: 'Leaking Faucet',
      description: 'The kitchen faucet is leaking constantly.',
      roomNumber: '203',
      tenantName: 'Nattaya P.',
      phoneNumber: '082-345-6789',
      imageUrl: 'https://picsum.photos/500/300?random=11',
      reportedAt: DateTime(2024, 12, 12, 14, 45),
      status: RepairOwnerStatus.inProgress,
    ),
    RepairOwnerModel(
      id: '3',
      title: 'Air Conditioner',
      description: 'Not cooling properly, making loud noise.',
      roomNumber: '305',
      tenantName: 'Wichai T.',
      phoneNumber: '083-456-7890',
      imageUrl: 'https://picsum.photos/500/300?random=13',
      reportedAt: DateTime(2024, 12, 15, 11, 20),
      status: RepairOwnerStatus.completed,
    ),
    RepairOwnerModel(
      id: '4',
      title: 'Broken Door Lock',
      description: 'Door lock is jammed and cannot be opened from outside.',
      roomNumber: '102',
      tenantName: 'Malee S.',
      phoneNumber: '084-567-8901',
      imageUrl: 'https://picsum.photos/500/300?random=12',
      reportedAt: DateTime(2024, 12, 18, 16, 10),
      status: RepairOwnerStatus.cancelled,
    ),
    RepairOwnerModel(
      id: '5',
      title: 'Broken Window',
      description: 'Window latch is broken, cannot lock properly.',
      roomNumber: '401',
      tenantName: 'Prayut C.',
      phoneNumber: '085-678-9012',
      imageUrl: 'https://picsum.photos/500/300?random=14',
      reportedAt: DateTime(2024, 12, 20, 10, 0),
      status: RepairOwnerStatus.pending,
    ),
  ];

  List<RepairOwnerModel> get _filteredRepairs {
    var result = _allRepairs;

    // Filter by floor — ดูจากตัวแรกของ roomNumber เช่น "203" → floor 2
    if (_selectedFloorIndex != 0) {
      result = result
          .where((r) => r.roomNumber.startsWith('$_selectedFloorIndex'))
          .toList();
    }

    // Filter by status
    if (_selectedStatusIndex != 0) {
      final statuses = [
        null,
        RepairOwnerStatus.pending,
        RepairOwnerStatus.inProgress,
        RepairOwnerStatus.completed,
        RepairOwnerStatus.cancelled,
      ];
      result = result
          .where((r) => r.status == statuses[_selectedStatusIndex])
          .toList();
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            _buildStatusSummaryBar(),
            const SizedBox(height: 12),
            _buildSearchAndSort(),
            const SizedBox(height: 10),
            _buildFilterTabs(),
            const SizedBox(height: 8),
            _buildFloorTabs(),
            const SizedBox(height: 8),
            _buildListHeader(),
            const SizedBox(height: 6),
            Expanded(
              child: _filteredRepairs.isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                      itemCount: _filteredRepairs.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) => _RepairOwnerCard(
                        data: _filteredRepairs[index],
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RepairDetailOwnerScreen(
                                data: _filteredRepairs[index],
                                onStatusUpdated: () => setState(() {}),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Private Helpers ─────────────────────────────────────────────────────

  Widget _buildStatusSummaryBar() {
    final total = _allRepairs.length;
    final pending = _allRepairs
        .where((r) => r.status == RepairOwnerStatus.pending)
        .length;
    final inProgress = _allRepairs
        .where((r) => r.status == RepairOwnerStatus.inProgress)
        .length;
    final completed = _allRepairs
        .where((r) => r.status == RepairOwnerStatus.completed)
        .length;
    final cancelled = _allRepairs
        .where((r) => r.status == RepairOwnerStatus.cancelled)
        .length;

    final segments = [
      (count: pending, color: const Color(0xFFFFA726), label: 'Pending'),
      (count: inProgress, color: const Color(0xFF42A5F5), label: 'In Progress'),
      (count: completed, color: const Color(0xFF66BB6A), label: 'Completed'),
      (count: cancelled, color: const Color(0xFFEF5350), label: 'Cancelled'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Overview',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0D1B2A),
                  ),
                ),
                const Spacer(),
                Text(
                  '$total requests total',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Segmented progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 30, // 🔥 เพิ่มความสูง
                child: Row(
                  children: total == 0
                      ? [
                          Expanded(
                            child: Container(color: Colors.grey.shade100),
                          ),
                        ]
                      : segments.where((s) => s.count > 0).map((s) {
                          final percent = ((s.count / total) * 100).round();

                          return Expanded(
                            flex: s.count,
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 2),
                              color: s.color,
                              child: percent >= 10 // 🔥 กัน text ล้น
                                ? Text(
                                    '$percent%',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                : null,
                            ),
                          );
                        }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Legend
            Wrap(
              spacing: 16,
              runSpacing: 6,
              children: segments
                  .map(
                    (s) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: s.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${s.count} ${s.label}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndSort() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, size: 18, color: Colors.grey.shade400),
                  const SizedBox(width: 8),
                  Text(
                    'Search by room or tenant...',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                const Icon(Icons.sort, size: 18, color: Color(0xFFA34CF3)),
                const SizedBox(width: 6),
                const Text(
                  'Sort',
                  style: TextStyle(
                    color: Color(0xFFA34CF3),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    final labels = ['All', 'Pending', 'In Progress', 'Completed', 'Cancelled'];
    final colors = [
      const Color(0xFFA34CF3),
      const Color(0xFFFFA726),
      const Color(0xFF42A5F5),
      const Color(0xFF66BB6A),
      const Color(0xFFEF5350),
    ];

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: labels.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = _selectedStatusIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedStatusIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: isSelected ? colors[index] : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? colors[index] : Colors.grey.shade200,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: colors[index].withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: Text(
                labels[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey.shade500,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFloorTabs() {
    final labels = [
      'All Floors',
      'Floor 1',
      'Floor 2',
      'Floor 3',
      'Floor 4',
      'Floor 5',
    ];

    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: labels.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = _selectedFloorIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedFloorIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFA34CF3) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFA34CF3)
                      : Colors.grey.shade200,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (index != 0) ...[
                    Icon(
                      Icons.layers_outlined,
                      size: 11,
                      color: isSelected ? Colors.white : Colors.grey.shade400,
                    ),
                    const SizedBox(width: 4),
                  ],
                  Text(
                    labels[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey.shade500,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
            'All Repair Requests',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '${_filteredRepairs.length} ${_selectedStatusIndex == 0 ? 'requests' : 'results'}',
            style: TextStyle(
              color: Colors.grey.shade500,
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
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.build_outlined,
              size: 32,
              color: Colors.grey.shade300,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No requests found',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'All repair requests will appear here',
            style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// ─── Repair Owner Card ────────────────────────────────────────────────────────

class _RepairOwnerCard extends StatelessWidget {
  final RepairOwnerModel data;
  final VoidCallback onTap;

  const _RepairOwnerCard({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopRow(),
                  const SizedBox(height: 8),
                  _buildTenantInfo(),
                  const SizedBox(height: 6),
                  _buildDescription(),
                  const SizedBox(height: 10),
                  Divider(color: Colors.grey.shade100, height: 1),
                  const SizedBox(height: 10),
                  _buildFooter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Card Helpers ─────────────────────────────────────────────────────────

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: data.imageUrl != null
          ? AspectRatio(
              aspectRatio: 16 / 7,
              child: Image.network(
                data.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _buildImagePlaceholder(),
              ),
            )
          : _buildImagePlaceholder(),
    );
  }

  Widget _buildImagePlaceholder() {
    return AspectRatio(
      aspectRatio: 16 / 7,
      child: Container(
        color: Colors.grey.shade50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_outlined, color: Colors.grey.shade300, size: 22),
            const SizedBox(width: 8),
            Text(
              'No image attached',
              style: TextStyle(color: Colors.grey.shade300, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFFA34CF3).withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.meeting_room_outlined,
                size: 12,
                color: Color(0xFFA34CF3),
              ),
              const SizedBox(width: 4),
              Text(
                'Room ${data.roomNumber}',
                style: const TextStyle(
                  color: Color(0xFFA34CF3),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            data.title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0D1B2A),
              letterSpacing: -0.2,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
          decoration: BoxDecoration(
            color: data.statusBgColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(data.statusIcon, size: 11, color: data.statusColor),
              const SizedBox(width: 4),
              Text(
                data.statusText,
                style: TextStyle(
                  color: data.statusColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTenantInfo() {
    return Row(
      children: [
        Icon(Icons.person_outline, size: 13, color: Colors.grey.shade400),
        const SizedBox(width: 4),
        Text(
          data.tenantName,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 12),
        Icon(Icons.phone_outlined, size: 13, color: Colors.grey.shade400),
        const SizedBox(width: 4),
        Text(
          data.phoneNumber,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      data.description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 13, color: Colors.grey.shade500, height: 1.5),
    );
  }

  Widget _buildFooter() {
    return Row(
      children: [
        Icon(Icons.access_time_outlined, size: 12, color: Colors.grey.shade400),
        const SizedBox(width: 4),
        Text(
          '${data.reportedTime}  ·  ${data.reportedDate}',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade400,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        const Text(
          'View details',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFFA34CF3),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 2),
        const Icon(Icons.arrow_forward_ios, size: 10, color: Color(0xFFA34CF3)),

        // ปุ่ม "View details" แบบกล่องที่มี background และ border
        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        //   decoration: BoxDecoration(
        //     color: const Color(0xFFA34CF3).withValues(alpha: 0.08),
        //     borderRadius: BorderRadius.circular(8),
        //     border: Border.all(
        //       color: const Color(0xFFA34CF3).withValues(alpha: 0.3),
        //     ),
        //   ),
        //   child: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: const [
        //       Text(
        //         'View details',
        //         style: TextStyle(
        //           fontSize: 12,
        //           color: Color(0xFFA34CF3),
        //           fontWeight: FontWeight.w600,
        //         ),
        //       ),
        //       SizedBox(width: 4),
        //       Icon(Icons.arrow_forward_ios, size: 10, color: Color(0xFFA34CF3)),
        //     ],
        //   ),
        // )
      ],
    );
  }
}
