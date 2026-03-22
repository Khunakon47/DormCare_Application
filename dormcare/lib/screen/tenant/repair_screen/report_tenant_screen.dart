import 'package:flutter/material.dart';
import 'package:dormcare/model/repair_model.dart';

class ReportTenantScreen extends StatefulWidget {
  const ReportTenantScreen({super.key});

  @override
  State<ReportTenantScreen> createState() => _ReportTenantScreenState();
}

class _ReportTenantScreenState extends State<ReportTenantScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  RepairCategory? _selectedCategory;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text(
          'Report Issue',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(color: Colors.grey.shade300, height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            _buildImagePicker(),
            const SizedBox(height: 20),
            _buildLabel('Issue Title'),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _titleController,
              hintText: 'e.g. Leaking faucet, Broken AC',
            ),
            const SizedBox(height: 16),
            _buildLabel('Category'),
            const SizedBox(height: 8),
            _buildCategoryPicker(),
            const SizedBox(height: 16),
            _buildLabel('Description'),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _descController,
              hintText: 'Describe the problem in detail...',
              maxLines: 5,
            ),
            const SizedBox(height: 32),
            _buildSubmitButton(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // ─── Private Helpers ─────────────────────────────────────────────────────

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFF367BF3).withValues(alpha: 0.35),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFF367BF3).withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add_photo_alternate_outlined,
                size: 26,
                color: const Color(0xFF367BF3).withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Tap to attach a photo',
              style: TextStyle(
                color: Color(0xFF367BF3),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'JPG, PNG up to 10MB',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryPicker() {
    final categories = [
      (
        category: RepairCategory.electrical,
        icon: Icons.bolt_outlined,
        label: 'Electrical',
      ),
      (
        category: RepairCategory.plumbing,
        icon: Icons.water_drop_outlined,
        label: 'Plumbing',
      ),
      (
        category: RepairCategory.furniture,
        icon: Icons.chair_outlined,
        label: 'Furniture',
      ),
      (
        category: RepairCategory.appliance,
        icon: Icons.kitchen_outlined,
        label: 'Appliance',
      ),
      (
        category: RepairCategory.other,
        icon: Icons.build_outlined,
        label: 'Other',
      ),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((item) {
        final isSelected = _selectedCategory == item.category;
        return GestureDetector(
          onTap: () => setState(() => _selectedCategory = item.category),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF367BF3) : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF367BF3)
                    : Colors.grey.shade200,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: const Color(0xFF367BF3).withValues(alpha: 0.25),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : [],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  item.icon,
                  size: 15,
                  color: isSelected ? Colors.white : Colors.grey.shade500,
                ),
                const SizedBox(width: 6),
                Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF367BF3),
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        onPressed: () {
          Navigator.pop(context, true);
        },
        child: const Text(
          'Submit Report',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: Color(0xFF0D1B2A),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 14, color: Color(0xFF0D1B2A)),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF367BF3), width: 1.5),
        ),
      ),
    );
  }
}
