import 'package:flutter/material.dart';
import 'package:dormcare/model/repair_model.dart';
import 'package:dormcare/services/repair_service.dart';
import 'package:dormcare/theme/app_theme.dart';

class RepairDetailOwnerScreen extends StatefulWidget {
  final RepairModel data;
  final VoidCallback onStatusUpdated;

  const RepairDetailOwnerScreen({
    super.key,
    required this.data,
    required this.onStatusUpdated,
  });

  @override
  State<RepairDetailOwnerScreen> createState() =>
      _RepairDetailOwnerScreenState();
}

class _RepairDetailOwnerScreenState extends State<RepairDetailOwnerScreen> {
  final _repairService = RepairService();
  late RepairStatus _selectedStatus;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.data.status;
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    try {
      await _repairService.updateStatus(widget.data.id, _selectedStatus);

      if (!mounted) return;
      widget.data.status = _selectedStatus;
      widget.onStatusUpdated();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(
                Icons.check_circle_outline,
                color: AppColors.white,
                size: 20,
              ),
              SizedBox(width: 10),
              Text('Status updated successfully'),
            ],
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: AppColors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(child: Text('Failed to update: ${e.toString()}')),
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
          'Repair Detail',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(color: AppColors.textDisabled, height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 16),
                  _buildTenantCard(),
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  const SizedBox(height: 16),
                  _buildSection(
                    title: 'Description',
                    child: Text(
                      widget.data.description.isEmpty
                          ? '—'
                          : widget.data.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        height: 1.7,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildSection(
                    title: 'Update Status',
                    child: _buildStatusOptions(),
                  ),
                  const SizedBox(height: 32),
                  _buildSaveButton(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return widget.data.imageUrl != null
        ? AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              widget.data.imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _buildImagePlaceholder(),
            ),
          )
        : _buildImagePlaceholder();
  }

  Widget _buildImagePlaceholder() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: AppColors.divider,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported_outlined,
              color: AppColors.textDisabled,
              size: 40,
            ),
            const SizedBox(height: 8),
            Text(
              'No image attached',
              style: TextStyle(color: AppColors.textTertiary, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.ownerPrimary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.meeting_room_outlined,
                      size: 13,
                      color: AppColors.ownerPrimary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Room ${widget.data.roomNumber}',
                      style: const TextStyle(
                        color: AppColors.ownerPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.data.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: widget.data.statusBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.data.statusIcon,
                size: 13,
                color: widget.data.statusColor,
              ),
              const SizedBox(width: 5),
              Text(
                widget.data.statusText,
                style: TextStyle(
                  color: widget.data.statusColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTenantCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildInfoTile(
              icon: Icons.person_outline,
              label: 'Tenant',
              value: widget.data.tenantName,
            ),
          ),
          Container(width: 1, height: 40, color: AppColors.divider),
          Expanded(
            child: _buildInfoTile(
              icon: Icons.phone_outlined,
              label: 'Phone',
              value: widget.data.phoneNumber,
            ),
          ),
          Container(width: 1, height: 40, color: AppColors.divider),
          Expanded(
            child: _buildInfoTile(
              icon: Icons.calendar_today_outlined,
              label: 'Reported',
              value: widget.data.reportedDate,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, size: 16, color: AppColors.textTertiary),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: AppColors.textTertiary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  Widget _buildStatusOptions() {
    final options = [
      (
        status: RepairStatus.pending,
        label: 'Pending',
        subtitle: 'Waiting to be assigned',
        icon: Icons.schedule,
      ),
      (
        status: RepairStatus.inProgress,
        label: 'In Progress',
        subtitle: 'Staff has been assigned',
        icon: Icons.autorenew,
      ),
      (
        status: RepairStatus.completed,
        label: 'Completed',
        subtitle: 'Issue has been resolved',
        icon: Icons.check_circle_outline,
      ),
      (
        status: RepairStatus.cancelled,
        label: 'Cancelled',
        subtitle: 'Request was cancelled',
        icon: Icons.cancel_outlined,
      ),
    ];

    return Column(
      children: options.map((option) {
        final isSelected = _selectedStatus == option.status;
        final color = _statusColor(option.status);
        return GestureDetector(
          onTap: _isSaving
              ? null
              : () => setState(() => _selectedStatus = option.status),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isSelected
                  ? color.withValues(alpha: 0.06)
                  : AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? color : AppColors.border,
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? color.withValues(alpha: 0.12)
                        : AppColors.background,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    option.icon,
                    size: 18,
                    color: isSelected ? color : AppColors.textTertiary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option.label,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: isSelected ? color : AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        option.subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(Icons.check_circle, size: 20, color: color)
                else
                  Icon(
                    Icons.radio_button_unchecked,
                    size: 20,
                    color: AppColors.textDisabled,
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSaveButton() {
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
        onPressed: _isSaving ? null : _save,
        child: _isSaving
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.white,
                ),
              )
            : const Text(
                'Save Changes',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  Color _statusColor(RepairStatus status) {
    switch (status) {
      case RepairStatus.pending:
        return AppColors.warning;
      case RepairStatus.inProgress:
        return AppColors.info;
      case RepairStatus.completed:
        return AppColors.success;
      case RepairStatus.cancelled:
        return AppColors.error;
    }
  }
}
