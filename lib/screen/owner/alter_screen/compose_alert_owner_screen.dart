import 'package:flutter/material.dart';
import 'package:dormcare/model/owner/alert_owner_model.dart';
import 'package:dormcare/theme/app_theme.dart';

class ComposeAlertOwnerScreen extends StatefulWidget {
  const ComposeAlertOwnerScreen({super.key});

  @override
  State<ComposeAlertOwnerScreen> createState() =>
      _ComposeAlertOwnerScreenState();
}

class _ComposeAlertOwnerScreenState extends State<ComposeAlertOwnerScreen> {
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();

  AlertOwnerCategory _selectedCategory = AlertOwnerCategory.general;
  String _selectedTarget = 'all';

  // Mock room list
  final List<String> _rooms = ['101', '102', '203', '204', '305', '401'];

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Send Alert',
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
            _buildLabel('Category'),
            const SizedBox(height: 8),
            _buildCategoryPicker(),
            const SizedBox(height: 16),
            _buildLabel('Send to'),
            const SizedBox(height: 8),
            _buildTargetPicker(),
            const SizedBox(height: 16),
            _buildLabel('Title'),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _titleController,
              hintText: 'e.g. Water supply suspended',
            ),
            const SizedBox(height: 16),
            _buildLabel('Message'),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _messageController,
              hintText: 'Write your message here...',
              maxLines: 5,
            ),
            const SizedBox(height: 32),
            _buildSendButton(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryPicker() {
    final categories = [
      (
        category: AlertOwnerCategory.repairRequest,
        label: 'Repair Request',
        icon: Icons.build_outlined,
      ),
      (
        category: AlertOwnerCategory.billReminder,
        label: 'Bill Reminder',
        icon: Icons.receipt_long_outlined,
      ),
      (
        category: AlertOwnerCategory.general,
        label: 'General',
        icon: Icons.notifications_none_outlined,
      ),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((item) {
        final isSelected = _selectedCategory == item.category;
        final color = switch (item.category) {
          AlertOwnerCategory.repairRequest => AppColors.ownerPrimary,
          AlertOwnerCategory.billReminder => AppColors.info,
          AlertOwnerCategory.general => AppColors.success,
        };
        return GestureDetector(
          onTap: () => setState(() => _selectedCategory = item.category),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            decoration: BoxDecoration(
              color: isSelected ? color : AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected ? color : Colors.grey.shade200,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: color.withValues(alpha: 0.25),
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
                  color: isSelected ? AppColors.white : Colors.grey.shade500,
                ),
                const SizedBox(width: 6),
                Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? AppColors.white : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTargetPicker() {
    return Column(
      children: [
        // All rooms option
        GestureDetector(
          onTap: () => setState(() => _selectedTarget = 'all'),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: _selectedTarget == 'all'
                  ? AppColors.ownerPrimary.withValues(alpha: 0.06)
                  : AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _selectedTarget == 'all'
                    ? AppColors.ownerPrimary
                    : Colors.grey.shade200,
                width: _selectedTarget == 'all' ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: _selectedTarget == 'all'
                        ? AppColors.ownerPrimary.withValues(alpha: 0.1)
                        : Colors.grey.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.apartment_outlined,
                    size: 18,
                    color: _selectedTarget == 'all'
                        ? AppColors.ownerPrimary
                        : Colors.grey.shade400,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'All Rooms',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: _selectedTarget == 'all'
                              ? AppColors.ownerPrimary
                              : AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'Send to every tenant',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
                if (_selectedTarget == 'all')
                  const Icon(
                    Icons.check_circle,
                    size: 20,
                    color: AppColors.ownerPrimary,
                  )
                else
                  Icon(
                    Icons.radio_button_unchecked,
                    size: 20,
                    color: Colors.grey.shade300,
                  ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Specific room
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _selectedTarget != 'all'
                  ? AppColors.ownerPrimary
                  : Colors.grey.shade200,
              width: _selectedTarget != 'all' ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: _selectedTarget != 'all'
                          ? AppColors.ownerPrimary.withValues(alpha: 0.1)
                          : Colors.grey.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.meeting_room_outlined,
                      size: 18,
                      color: _selectedTarget != 'all'
                          ? AppColors.ownerPrimary
                          : Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Specific Room',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _selectedTarget != 'all'
                            ? AppColors.ownerPrimary
                            : AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _rooms.map((room) {
                  final isSelected = _selectedTarget == room;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedTarget = room),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.ownerPrimary
                            : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.ownerPrimary
                              : Colors.grey.shade200,
                        ),
                      ),
                      child: Text(
                        'Room $room',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? AppColors.white
                              : Colors.grey.shade600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSendButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.ownerPrimary,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          'Send Alert',
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
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
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
          borderSide: const BorderSide(color: AppColors.ownerPrimary, width: 1.5),
        ),
      ),
    );
  }
}
