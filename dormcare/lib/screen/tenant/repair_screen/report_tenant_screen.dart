import 'package:flutter/material.dart';
import 'package:dormcare/model/repair_model.dart';
import 'package:dormcare/theme/app_theme.dart';

class ReportTenantScreen extends StatefulWidget {
  const ReportTenantScreen({super.key});

  @override
  State<ReportTenantScreen> createState() => _ReportTenantScreenState();
}

class _ReportTenantScreenState extends State<ReportTenantScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  RepairCategory? _selectedCategory;

  // TODO: เปลี่ยนเป็นข้อมูลจริงจาก auth/session หลัง backend พร้อม
  static const _mockRoomNumber = '301';
  static const _mockTenantName = 'JoBy Khuna';
  static const _mockPhone = '081-234-5678';

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  bool get _isValid =>
      _titleController.text.trim().isNotEmpty && _selectedCategory != null;

  void _submit() {
    if (!_isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in the title and select a category'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // สร้าง RepairModel จาก input แล้วส่งกลับ
    final newRepair = RepairModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // temp id
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
      roomNumber: _mockRoomNumber,
      tenantName: _mockTenantName,
      phoneNumber: _mockPhone,
      reportedAt: DateTime.now(),
      imageUrl: null, // TODO: เพิ่ม image picker จริง
      status: RepairStatus.pending,
      category: _selectedCategory!,
    );

    Navigator.pop(context, newRepair);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Report Issue',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(color: AppColors.textDisabled, height: 1.0),
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
            _buildLabel('Issue Title *'),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _titleController,
              hintText: 'e.g. Leaking faucet, Broken AC',
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            _buildLabel('Category *'),
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

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: () {
        // TODO: implement image picker
      },
      child: Container(
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.tenantPrimary.withValues(alpha: 0.35),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
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
                color: AppColors.tenantPrimary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add_photo_alternate_outlined,
                size: 26,
                color: AppColors.tenantPrimary.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Tap to attach a photo',
              style: TextStyle(
                color: AppColors.tenantPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'JPG, PNG up to 10MB',
              style: TextStyle(color: AppColors.textTertiary, fontSize: 12),
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
              color: isSelected ? AppColors.tenantPrimary : AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected ? AppColors.tenantPrimary : AppColors.border,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.tenantPrimary.withValues(alpha: 0.25),
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
                  color: isSelected ? AppColors.white : AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? AppColors.white
                        : AppColors.textSecondary,
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
          backgroundColor: _isValid
              ? AppColors.tenantPrimary
              : AppColors.border,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        onPressed: _isValid ? _submit : null,
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
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    ValueChanged<String>? onChanged,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      onChanged: onChanged,
      style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.textTertiary, fontSize: 14),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.tenantPrimary,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
