import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dormcare/providers/user_provider.dart';
import 'package:dormcare/services/auth_service.dart';
import 'package:dormcare/theme/app_theme.dart';

class ProfileTenantScreen extends StatelessWidget {
  const ProfileTenantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: Column(
          children: [
            _buildProfileCard(user),
            const SizedBox(height: 16),
            _buildRoomInfoCard(user),
            const SizedBox(height: 16),
            _buildMenuSection(context),
            const SizedBox(height: 16),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(UserProvider user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.tenantPrimary.withValues(alpha: 0.1),
              border: Border.all(
                color: AppColors.tenantPrimary.withValues(alpha: 0.2),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.person_outline,
              size: 44,
              color: AppColors.tenantPrimary,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            user.name.isEmpty ? 'Loading...' : user.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tenant',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textTertiary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomInfoCard(UserProvider user) {
    final infos = [
      (
        icon: Icons.meeting_room_outlined,
        label: 'Room',
        value: user.roomNumber.isEmpty ? '—' : user.roomNumber,
      ),
      (
        icon: Icons.apartment_outlined,
        label: 'Dorm',
        value: user.dormId.isEmpty ? '—' : user.dormId,
      ),
      (
        icon: Icons.phone_outlined,
        label: 'Phone',
        value: user.phone.isEmpty ? '—' : user.phone,
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: infos.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == infos.length - 1;
          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Icon(item.icon, size: 18, color: AppColors.tenantPrimary),
                      const SizedBox(height: 6),
                      Text(
                        item.value,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.textTertiary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Container(width: 1, height: 36, color: AppColors.border),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    final items = [
      (icon: Icons.edit_outlined, label: 'Edit Profile'),
      (icon: Icons.receipt_outlined, label: 'Payment History'),
      (icon: Icons.settings_outlined, label: 'Settings'),
      (icon: Icons.help_outline_rounded, label: 'Help & Support'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (context, index) => Divider(
            height: 1,
            thickness: 0.5,
            indent: 56,
            color: AppColors.border,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 2,
              ),
              leading: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.tenantPrimary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  item.icon,
                  size: 18,
                  color: AppColors.tenantPrimary,
                ),
              ),
              title: Text(
                item.label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: AppColors.textDisabled,
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'This feature is currently under development',
                    ),
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: () async {
          try {
            await AuthService().logout();
            if (!context.mounted) return;
            context.read<UserProvider>().clearUser();
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          } catch (e) {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to logout: ${e.toString()}'),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          }
        },
        icon: const Icon(
          Icons.logout_rounded,
          size: 18,
          color: AppColors.error,
        ),
        label: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.error,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.errorSoft,
          side: const BorderSide(color: AppColors.errorBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
