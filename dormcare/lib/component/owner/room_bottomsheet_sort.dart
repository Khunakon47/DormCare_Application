import 'package:flutter/material.dart';

class RoomBottomsheetSort extends StatefulWidget {
  final Map<String, dynamic>? initialFilters;
  final Function(Map<String, dynamic>)? onApplySort;

  const RoomBottomsheetSort({
    super.key,
    this.initialFilters,
    this.onApplySort,
  });

  @override
  State<RoomBottomsheetSort> createState() => _RoomBottomsheetSortState();
}

class _RoomBottomsheetSortState extends State<RoomBottomsheetSort> {
  String? selectedOptionStatus;

  void _resetSort() {
    setState(() {
      selectedOptionStatus = null;
    });

    // Optional: notify parent immediately
    widget.onApplySort?.call({});
    Navigator.pop(context);
  }

  void _applyFilters() {
    final filters = {
      'sort': selectedOptionStatus,
    };

    widget.onApplySort?.call(filters);
    Navigator.pop(context);
  }


  @override
  void initState() {
    super.initState();
    selectedOptionStatus = widget.initialFilters?['sort'];
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
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          _buildHeader(),

          Expanded(
            child: SingleChildScrollView(
              child: _buildRadioButtons(
                options: const [
                  "Room Number (Ascending)",
                  "Room Number (Descending)",
                  "New Tenant",
                  "Old Tenant",
                  "Highest Rent",
                  "Lowest Rent",
                ],
                selectedValue: selectedOptionStatus,
                onSelect: (value) {
                  setState(() {
                    selectedOptionStatus = value;
                  });
                },
              ),
            ),
          ),

          _buildBottomActions()

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
          const Text(
            'Sort',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
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

  Widget _buildRadioButtons({
    required List<String> options,
    required String? selectedValue,
    required ValueChanged<String?> onSelect,
  }) {
    return Column(
      children: options.map((option) {
        return RadioMenuButton<String>(
          value: option,
          groupValue: selectedValue,
          onChanged: onSelect,
          child: Text(option),
        );
      }).toList(),
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
                onPressed: _resetSort,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: Colors.grey[300]!, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Cancel',
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
