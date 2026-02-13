import 'package:dormcare/model/tenant/alert_model.dart';
import 'package:flutter/material.dart';

class AlertFilterSheet extends StatefulWidget {
  final AlertCategory? initialCategory;
  final bool? initialReadStatus; // null=All, true=Read, false=Unread
  final Function(AlertCategory? category, bool? isRead) onApply;

  const AlertFilterSheet({
    super.key,
    this.initialCategory,
    this.initialReadStatus,
    required this.onApply,
  });

  @override
  State<AlertFilterSheet> createState() => _AlertFilterSheetState();
}

class _AlertFilterSheetState extends State<AlertFilterSheet> {
  AlertCategory? _selectedCategory;
  bool? _selectedReadStatus;

  final Color _primaryColor = const Color(0xFF367BF3);
  final Color _lightBlue = const Color(0xFFEDF4FF);

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
    _selectedReadStatus = widget.initialReadStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Filters",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Body (Scrollable)
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section 1: Category
                    _buildSectionTitle("Category"),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _buildFilterChip(
                          label: "All",
                          isSelected: _selectedCategory == null,
                          onTap: () => setState(() => _selectedCategory = null),
                        ),
                        ...AlertCategory.values.map((cat) {
                          return _buildFilterChip(
                            label:
                                cat.name[0].toUpperCase() +
                                cat.name.substring(1),
                            isSelected: _selectedCategory == cat,
                            onTap: () =>
                                setState(() => _selectedCategory = cat),
                          );
                        }),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Section 2: Read Status
                    _buildSectionTitle("Read Status"),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _buildFilterChip(
                          label: "All",
                          isSelected: _selectedReadStatus == null,
                          onTap: () =>
                              setState(() => _selectedReadStatus = null),
                        ),
                        _buildFilterChip(
                          label: "Unread",
                          isSelected: _selectedReadStatus == false,
                          onTap: () =>
                              setState(() => _selectedReadStatus = false),
                        ),
                        _buildFilterChip(
                          label: "Read",
                          isSelected: _selectedReadStatus == true,
                          onTap: () =>
                              setState(() => _selectedReadStatus = true),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Actions
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _selectedCategory = null; // ล้างค่าหมวดหมู่
                        _selectedReadStatus = null; // ล้างค่าสถานะอ่าน
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Reset",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onApply(_selectedCategory, _selectedReadStatus);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Apply",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? _lightBlue
              : Colors.white,
          border: Border.all(
            color: isSelected ? _primaryColor : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? _primaryColor : Colors.black87,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
