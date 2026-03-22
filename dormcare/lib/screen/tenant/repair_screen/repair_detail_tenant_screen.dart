import 'package:dormcare/component/timeline_tile.dart';
import 'package:flutter/material.dart';
import 'package:dormcare/model/repair_model.dart';

class RepairDetailTenantScreen extends StatelessWidget {
  final RepairModel data;

  const RepairDetailTenantScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
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
                  const SizedBox(height: 12),
                  const Divider(height: 1),
                  const SizedBox(height: 12),
                  _buildSection(
                    title: 'Description',
                    child: Text(
                      data.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                        height: 1.7,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(),
                  const SizedBox(height: 20),
                  _buildSection(
                    title: 'Status Timeline',
                    child: _buildTimeline(),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Image section builder
  Widget _buildImage() {
    return data.imageUrl != null
        ? AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              data.imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _buildImagePlaceholder(),
            ),
          )
        : _buildImagePlaceholder();
  }

  // Placeholder for when no image is available
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

  // Header section builder
  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            data.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0D1B2A),
              letterSpacing: -0.5,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: data.statusBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(data.statusIcon, size: 13, color: data.statusColor),
              const SizedBox(width: 5),
              Text(
                data.statusText,
                style: TextStyle(
                  color: data.statusColor,
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

  // Info row builder
  Widget _buildInfoRow() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          SizedBox(width: 4),
          Expanded(
            child: _buildInfoTile(
              icon: Icons.category_outlined,
              label: 'Category',
              value: data.categoryText,
            ),
          ),
          SizedBox(width: 8),
          Container(width: 1, height: 40, color: Colors.grey.shade100),
          Expanded(
            child: _buildInfoTile(
              icon: Icons.access_time_outlined,
              label: 'Time',
              value: data.reportedTime,
            ),
          ),
          Container(width: 1, height: 40, color: Colors.grey.shade100),
          SizedBox(width: 8),
          Expanded(
            child: _buildInfoTile(
              icon: Icons.calendar_today_outlined,
              label: 'Date',
              value: data.reportedDate,
            ),
          ),
          SizedBox(width: 8),
          Container(width: 1, height: 40, color: Colors.grey.shade100),
          SizedBox(width: 8),
          Expanded(
            child: _buildInfoTile(
              icon: Icons.info_outline,
              label: 'Status',
              value: data.statusText,
            ),
          ),
          SizedBox(width: 4),
        ],
      ),
    );
  }

  // Individual info tile builder
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
            color: Color(0xFF0D1B2A),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // Section builder with title and content
  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0D1B2A),
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  // Timeline builder based on repair status
  Widget _buildTimeline() {
    if (data.status == RepairStatus.cancelled) {
      return TimelineTile(
        label: 'Cancelled',
        subtitle: 'Request was cancelled',
        color: const Color(0xFFEF5350),
        isDone: true,
        isLast: true,
      );
    }

    final steps = [
      (RepairStatus.pending, 'Pending', 'Request submitted'),
      (RepairStatus.inProgress, 'In Progress', 'Staff assigned'),
      (RepairStatus.completed, 'Completed', 'Issue resolved'),
    ];

    final currentIndex = steps.indexWhere((s) => s.$1 == data.status);

    return Column(
      children: List.generate(steps.length, (i) {
        final isDone = i <= currentIndex;
        final isLast = i == steps.length - 1;
        final color = isDone ? data.statusColor : Colors.grey.shade300;

        return TimelineTile(
          label: steps[i].$2,
          subtitle: steps[i].$3,
          color: color,
          isDone: isDone,
          isLast: isLast,
        );
      }),
    );
  }
}