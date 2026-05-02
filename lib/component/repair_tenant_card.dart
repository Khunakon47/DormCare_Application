import 'package:flutter/material.dart';
import 'package:dormcare/model/repair_model.dart';
import 'package:dormcare/theme/app_theme.dart';

class RepairTenantCard extends StatelessWidget {
  final RepairModel data;
  final VoidCallback onTap;

  const RepairTenantCard({super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withValues(alpha: 0.04),
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [_buildTitle(), _buildStatusBadge()],
                  ),
                  const SizedBox(height: 8),
                  _buildDescription(),
                  const SizedBox(height: 8),
                  _buildInfoRow(),
                  const SizedBox(height: 12),
                  Divider(color: AppColors.border, height: 1),
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
                errorBuilder: (context, error, stackTrace) => _buildImagePlaceholder(),
              ),
            )
          : _buildImagePlaceholder(),
    );
  }

  Widget _buildImagePlaceholder() {
    return AspectRatio(
      aspectRatio: 16 / 7,
      child: Container(
        color: AppColors.divider,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_outlined, color: AppColors.textTertiary, size: 22),
            const SizedBox(width: 8),
            Text(
              'No image attached',
              style: TextStyle(color: AppColors.textTertiary, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Row(
      children: [
        // Status badge
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

  Widget _buildTitle() {
    return Text(
      data.title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.2,
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      data.description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 13,
        color: AppColors.textSecondary,
        height: 1.5,
      ),
    );
  }

  Widget _buildInfoRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category row
        Row(
          children: [
            Icon(
              Icons.category_outlined,
              size: 16,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 5),
            Text(
              data.categoryText,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        // Time row
        Row(
          children: [
            Icon(
              Icons.access_time_outlined,
              size: 16,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 5),
            Text(
              data.reportedTime,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        // Date row
        Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 16,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 5),
            Text(
              data.reportedDate,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'View details',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.tenantPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 2),
          const Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: AppColors.tenantPrimary,
          ),
        ],
      ),
    );
  }
}
