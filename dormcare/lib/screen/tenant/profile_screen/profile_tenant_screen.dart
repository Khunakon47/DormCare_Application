import 'package:flutter/material.dart';

class ProfileTenantScreen extends StatelessWidget {
  const ProfileTenantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: Column(
          children: [
            _buildProfileCard(),
            const SizedBox(height: 16),
            _buildRoomInfoCard(),
            const SizedBox(height: 16),
            _buildMenuSection(),
            const SizedBox(height: 16),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Avatar
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF367BF3).withValues(alpha: 0.1),
              border: Border.all(
                color: const Color(0xFF367BF3).withValues(alpha: 0.2),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.person_outline,
              size: 44,
              color: Color(0xFF367BF3),
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'JoBy Khuna',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0D1B2A),
              letterSpacing: -0.3,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            'Tenant',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomInfoCard() {
    final infos = [
      (icon: Icons.meeting_room_outlined, label: 'Room', value: '301'),
      (icon: Icons.apartment_outlined, label: 'Dorm', value: 'Dorm 27'),
      (icon: Icons.phone_outlined, label: 'Phone', value: '081-234-5678'),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
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
                      Icon(item.icon, size: 18, color: const Color(0xFF367BF3)),
                      const SizedBox(height: 6),
                      Text(
                        item.value,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0D1B2A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Container(width: 1, height: 36, color: Colors.grey.shade100),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMenuSection() {
    final items = [
      (
        icon: Icons.edit_outlined,
        label: 'Edit Profile',
        color: const Color(0xFF367BF3),
      ),
      (
        icon: Icons.receipt_outlined,
        label: 'Payment History',
        color: const Color(0xFF367BF3),
      ),
      (
        icon: Icons.settings_outlined,
        label: 'Settings',
        color: const Color(0xFF367BF3),
      ),
      (
        icon: Icons.help_outline_rounded,
        label: 'Help & Support',
        color: const Color(0xFF367BF3),
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
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
            color: Colors.grey.shade100,
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
                  color: item.color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(item.icon, size: 18, color: item.color),
              ),
              title: Text(
                item.label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0D1B2A),
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: Colors.grey.shade300,
              ),
              onTap: () {
                ScaffoldMessenger.of(context).clearSnackBars();
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
        onPressed: () =>
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
        icon: const Icon(
          Icons.logout_rounded,
          size: 18,
          color: Color(0xFFEF5350),
        ),
        label: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFFEF5350),
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFFFFEBEE),
          side: const BorderSide(color: Color(0xFFEF9A9A)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
