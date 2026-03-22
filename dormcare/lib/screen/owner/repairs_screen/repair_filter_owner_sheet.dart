import 'package:dormcare/model/owner/repair_owner_model.dart';
import 'package:flutter/material.dart';

class RepairFilterOwnerSheet extends StatefulWidget {
  final RepairOwnerStatus? initialStatus;
  final int initialFloor; // 0 = All floors
  final void Function(RepairOwnerStatus? status, int floor) onApply;

  const RepairFilterOwnerSheet({
    super.key,
    required this.initialStatus,
    required this.initialFloor,
    required this.onApply,
  });

  @override
  State<RepairFilterOwnerSheet> createState() => _RepairFilterOwnerSheetState();
}

class _RepairFilterOwnerSheetState extends State<RepairFilterOwnerSheet> {
  
  RepairOwnerStatus? _selectedStatus;
  int _selectedFloor = 0;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.initialStatus;
    _selectedFloor = widget.initialFloor;
  }

  bool get _hasActiveFilters {
    return _selectedStatus != null || _selectedFloor != 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Text(
                'Filter',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0D1B2A),
                ),
              ),
              const Spacer(),
              if (_hasActiveFilters)
                GestureDetector(
                  onTap: () => setState(() {
                    _selectedStatus = null;
                    _selectedFloor = 0;
                  }),
                  child: const Text(
                    'Clear all',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFFA34CF3),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 20),

          // Status section
          const Text(
            'Status',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0D1B2A),
            ),
          ),
          const SizedBox(height: 10),
          _buildStatusOptions(),

          const SizedBox(height: 20),

          // Floor section
          const Text(
            'Floor',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0D1B2A),
            ),
          ),
          const SizedBox(height: 10),
          _buildFloorOptions(),

          const SizedBox(height: 24),

          // Apply button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA34CF3),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              onPressed: () {
                widget.onApply(_selectedStatus, _selectedFloor);
                Navigator.pop(context);
              },
              child: Text(
                'Apply',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusOptions() {
    final status = [
      (status: null, label: 'All Statuses'),
      (status: RepairOwnerStatus.pending, label: 'Pending'),
      (status: RepairOwnerStatus.inProgress, label: 'In Progress'),
      (status: RepairOwnerStatus.completed, label: 'Completed'),
      (status: RepairOwnerStatus.cancelled, label: 'Cancelled'),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: status.map((item) {
        final isSelected = _selectedStatus == item.status;
        return GestureDetector(
          onTap: () => setState(() => _selectedStatus = item.status),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFA34CF3) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFFA34CF3)
                    : Colors.grey.shade200,
              ),
            ),
            child: Text(
              item.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.grey.shade600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFloorOptions() {
    final floors = [
      (floor: 0, label: 'All Floors'),
      (floor: 1, label: 'Floor 1'),
      (floor: 2, label: 'Floor 2'),
      (floor: 3, label: 'Floor 3'),
      (floor: 4, label: 'Floor 4'),
      (floor: 5, label: 'Floor 5'),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: floors.map((item) {
        final isSelected = _selectedFloor == item.floor;
        return GestureDetector(
          onTap: () => setState(() => _selectedFloor = item.floor),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFA34CF3) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFFA34CF3)
                    : Colors.grey.shade200,
              ),
            ),
            child: Text(
              item.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.grey.shade600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
