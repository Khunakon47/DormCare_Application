import 'package:flutter/material.dart';
import 'package:dormcare/model/owner/repair_owner_model.dart';
import 'package:dormcare/theme/app_theme.dart';

class RepairDetailOwnerScreen extends StatefulWidget {
  final RepairOwnerModel data;
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
          child: Container(color: Colors.grey.shade300, height: 1.0),
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
                      widget.data.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
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
        color: Colors.grey.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported_outlined,
              color: Colors.grey.shade300,
              size: 40,
            ),
            const SizedBox(height: 8),
            Text(
              'No image attached',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
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
              // Room badge
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade100),
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
          Container(width: 1, height: 40, color: Colors.grey.shade100),
          Expanded(
            child: _buildInfoTile(
              icon: Icons.phone_outlined,
              label: 'Phone',
              value: widget.data.phoneNumber,
            ),
          ),
          Container(width: 1, height: 40, color: Colors.grey.shade100),
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
        Icon(icon, size: 16, color: Colors.grey.shade400),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade400,
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
        status: RepairOwnerStatus.pending,
        label: 'Pending',
        subtitle: 'Waiting to be assigned',
        icon: Icons.schedule,
      ),
      (
        status: RepairOwnerStatus.inProgress,
        label: 'In Progress',
        subtitle: 'Staff has been assigned',
        icon: Icons.autorenew,
      ),
      (
        status: RepairOwnerStatus.completed,
        label: 'Completed',
        subtitle: 'Issue has been resolved',
        icon: Icons.check_circle_outline,
      ),
      (
        status: RepairOwnerStatus.cancelled,
        label: 'Cancelled',
        subtitle: 'Request was cancelled',
        icon: Icons.cancel_outlined,
      ),
    ];

    return Column(
      children: options.map((option) {
        final isSelected = widget.data.status == option.status;
        final color = _statusColor(option.status);

        return GestureDetector(
          onTap: () => setState(() => widget.data.status = option.status),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isSelected ? color.withValues(alpha: 0.06) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? color : Colors.grey.shade200,
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
                        : Colors.grey.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    option.icon,
                    size: 18,
                    color: isSelected ? color : Colors.grey.shade400,
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
                          color: Colors.grey.shade400,
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
                    color: Colors.grey.shade300,
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
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        onPressed: () {
          widget.onStatusUpdated();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
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
        },
        child: const Text(
          'Save Changes',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Color _statusColor(RepairOwnerStatus status) {
    switch (status) {
      case RepairOwnerStatus.pending:
        return AppColors.warning;
      case RepairOwnerStatus.inProgress:
        return AppColors.info;
      case RepairOwnerStatus.completed:
        return AppColors.success;
      case RepairOwnerStatus.cancelled:
        return AppColors.error;
    }
  }
}
