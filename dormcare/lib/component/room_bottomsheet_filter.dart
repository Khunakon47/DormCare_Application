import 'package:flutter/material.dart';

class RoomBottomsheetFilter extends StatefulWidget {
  final Map<String, dynamic>? initialFilters;
  final Function(Map<String, dynamic>)? onApplyFilters;

  const RoomBottomsheetFilter({
    super.key,
    this.initialFilters,
    this.onApplyFilters,
  });

  @override
  State<RoomBottomsheetFilter> createState() => _RoomBottomsheetFilterState();
}

class _RoomBottomsheetFilterState extends State<RoomBottomsheetFilter> {
  // Filter state
  String? selectedFloor;
  String? selectedRoomStatus;
  String? selectedPaymentStatus;
  String? selectedRoomType;
  String? selectedMaintenanceStatus;

  @override
  void initState() {
    super.initState();
    // Initialize with existing filters if provided
    if (widget.initialFilters != null) {
      selectedFloor = widget.initialFilters!['floor'];
      selectedRoomStatus = widget.initialFilters!['roomStatus'];
      selectedPaymentStatus = widget.initialFilters!['paymentStatus'];
      selectedRoomType = widget.initialFilters!['roomType'];
      selectedMaintenanceStatus = widget.initialFilters!['maintenanceStatus'];
    }
  }

  void _resetFilters() {
    setState(() {
      selectedFloor = null;
      selectedRoomStatus = null;
      selectedPaymentStatus = null;
      selectedRoomType = null;
      selectedMaintenanceStatus = null;
    });
  }

  void _applyFilters() {
    final filters = {
      'floor': selectedFloor,
      'roomStatus': selectedRoomStatus,
      'paymentStatus': selectedPaymentStatus,
      'roomType': selectedRoomType,
      'maintenanceStatus': selectedMaintenanceStatus,
    };
    widget.onApplyFilters?.call(filters);
    Navigator.pop(context, filters);
  }

  int get _activeFilterCount {
    int count = 0;
    if (selectedFloor != null) count++;
    if (selectedRoomStatus != null) count++;
    if (selectedPaymentStatus != null) count++;
    if (selectedRoomType != null) count++;
    if (selectedMaintenanceStatus != null) count++;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          _buildHeader(),

          // Filter content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFilterSection(
                    title: 'Floor',
                    options: ['All', 'Floor 1', 'Floor 2', 'Floor 3'],
                    selectedValue: selectedFloor,
                    onSelect: (value) => setState(() => selectedFloor = value),
                  ),
                  const SizedBox(height: 24),
                  _buildFilterSection(
                    title: 'Room Status',
                    options: ['All', 'Occupied', 'Vacant'],
                    selectedValue: selectedRoomStatus,
                    onSelect: (value) =>
                        setState(() => selectedRoomStatus = value),
                  ),
                  const SizedBox(height: 24),
                  _buildFilterSection(
                    title: 'Payment Status',
                    options: ['All', 'Paid', 'Unpaid'],
                    selectedValue: selectedPaymentStatus,
                    onSelect: (value) =>
                        setState(() => selectedPaymentStatus = value),
                  ),
                  const SizedBox(height: 24),
                  _buildFilterSection(
                    title: 'Room Type',
                    options: ['All', 'Single', 'Double', 'Studio'],
                    selectedValue: selectedRoomType,
                    onSelect: (value) => setState(() => selectedRoomType = value),
                  ),
                  const SizedBox(height: 24),
                  _buildFilterSection(
                    title: 'Maintenance Status',
                    options: [
                      'No Issue',
                      'Pending',
                      'Acknowledged',
                      'Purchasing Material',
                      'In Progress',
                      'Completed',
                      'Canceled',
                    ],
                    selectedValue: selectedMaintenanceStatus,
                    onSelect: (value) =>
                        setState(() => selectedMaintenanceStatus = value),
                  ),
                  const SizedBox(height: 80), // Space for bottom buttons
                ],
              ),
            ),
          ),

          // Bottom action buttons
          _buildBottomActions(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text(
                'Filter',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              if (_activeFilterCount > 0) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$_activeFilterCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.close, size: 24, color: Colors.grey[700]),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection({
    required String title,
    required List<String> options,
    required String? selectedValue,
    required Function(String?) onSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final isSelected = selectedValue == option;
            final isAll = option == 'All';

            return _FilterChip(
              label: option,
              isSelected: isSelected,
              onTap: () {
                if (isAll) {
                  onSelect(null); // Clear selection
                } else {
                  onSelect(option);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _resetFilters,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: Colors.grey[300]!, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.purple,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Apply',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.purple : Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}