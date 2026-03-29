import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dormcare/model/repair_model.dart';
import 'package:dormcare/providers/user_provider.dart';
import 'package:dormcare/services/repair_service.dart';
import 'package:dormcare/services/notification_service.dart';
import 'package:dormcare/theme/app_theme.dart';

class ReportTenantScreen extends StatefulWidget {
  const ReportTenantScreen({super.key});

  @override
  State<ReportTenantScreen> createState() => _ReportTenantScreenState();
}

class _ReportTenantScreenState extends State<ReportTenantScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _repairService = RepairService();
  final _notifService = NotificationService();
  final _picker = ImagePicker();

  RepairCategory? _selectedCategory;
  File? _selectedImage;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  bool get _isValid =>
      _titleController.text.trim().isNotEmpty && _selectedCategory != null;

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxWidth: 1024,
    );
    if (picked != null) {
      setState(() => _selectedImage = File(picked.path));
    }
  }

  Future<void> _submit() async {
    if (!_isValid) return;
    final user = context.read<UserProvider>();
    setState(() => _isSubmitting = true);

    try {
      await _repairService.submitRepair(
        dormId: user.dormId,
        roomNumber: user.roomNumber,
        tenantId: user.uid,
        tenantName: user.name,
        phoneNumber: user.phone,
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
        category: _selectedCategory!,
        imageUrl: null,
      );

      await _notifService.notifyOwnerNewRepair(
        dormId: user.dormId,
        roomNumber: user.roomNumber,
        tenantName: user.name,
        repairTitle: _titleController.text.trim(),
      );

      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: AppColors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(child: Text('Failed to submit: ${e.toString()}')),
            ],
          ),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 4),
        ),
      );
    }
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
      onTap: _isSubmitting ? null : _pickImage,
      child: Container(
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _selectedImage != null
                ? AppColors.tenantPrimary
                : AppColors.tenantPrimary.withValues(alpha: 0.35),
            width: _selectedImage != null ? 2 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: _selectedImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.file(_selectedImage!, fit: BoxFit.cover),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.edit, size: 13, color: AppColors.white),
                            SizedBox(width: 4),
                            Text(
                              'Change',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
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
                    style: TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 12,
                    ),
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
          onTap: _isSubmitting
              ? null
              : () => setState(() => _selectedCategory = item.category),
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
    final canSubmit = _isValid && !_isSubmitting;
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: canSubmit
              ? AppColors.tenantPrimary
              : AppColors.border,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        onPressed: canSubmit ? _submit : null,
        child: _isSubmitting
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.white,
                ),
              )
            : const Text(
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
      enabled: !_isSubmitting,
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
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}
