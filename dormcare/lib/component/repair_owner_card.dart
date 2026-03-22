import 'package:dormcare/model/repair_model.dart';
import 'package:flutter/material.dart';

class RepairOwnerCard extends StatelessWidget {
  final RepairModel data;
  final VoidCallback onTap;

  const RepairOwnerCard({super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopRow(),
                  const SizedBox(height: 8),
                  _buildTenantInfo(),
                  const SizedBox(height: 6),
                  _buildDescription(),
                  const SizedBox(height: 10),
                  Divider(color: Colors.grey.shade100, height: 1),
                  const SizedBox(height: 10),
                  _buildFooter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: data.imageUrl != null
          ? AspectRatio(
              aspectRatio: 16 / 7,
              child: Image.network(
                data.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildImagePlaceholder(),
              ),
            )
          : _buildImagePlaceholder(),
    );
  }

  Widget _buildImagePlaceholder() {
    return AspectRatio(
      aspectRatio: 16 / 7,
      child: Container(
        color: Colors.grey.shade50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_outlined, color: Colors.grey.shade300, size: 22),
            const SizedBox(width: 8),
            Text(
              'No image attached',
              style: TextStyle(color: Colors.grey.shade300, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFFA34CF3).withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.meeting_room_outlined,
                size: 12,
                color: Color(0xFFA34CF3),
              ),
              const SizedBox(width: 4),
              Text(
                'Room ${data.roomNumber}',
                style: const TextStyle(
                  color: Color(0xFFA34CF3),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            data.title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0D1B2A),
              letterSpacing: -0.2,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
          decoration: BoxDecoration(
            color: data.statusBgColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(data.statusIcon, size: 11, color: data.statusColor),
              const SizedBox(width: 4),
              Text(
                data.statusText,
                style: TextStyle(
                  color: data.statusColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTenantInfo() {
    return Row(
      children: [
        Icon(Icons.person_outline, size: 13, color: Colors.grey.shade400),
        const SizedBox(width: 4),
        Text(
          data.tenantName,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 12),
        Icon(Icons.phone_outlined, size: 13, color: Colors.grey.shade400),
        const SizedBox(width: 4),
        Text(
          data.phoneNumber,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      data.description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 13, color: Colors.grey.shade500, height: 1.5),
    );
  }

  Widget _buildFooter() {
    return Row(
      children: [
        Icon(Icons.access_time_outlined, size: 12, color: Colors.grey.shade400),
        const SizedBox(width: 4),
        Text(
          '${data.reportedTime}  ·  ${data.reportedDate}',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade400,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        const Text(
          'View details',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFFA34CF3),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 2),
        const Icon(Icons.arrow_forward_ios, size: 10, color: Color(0xFFA34CF3)),
      ],
    );
  }
}
