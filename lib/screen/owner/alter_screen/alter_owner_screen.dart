import 'package:dormcare/model/owner/alert_owner_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'alter_detail_owner_screen.dart';
import 'compose_alert_owner_screen.dart';
import 'package:dormcare/theme/app_theme.dart';
import 'package:dormcare/component/alert_owner_card.dart';
import 'package:dormcare/providers/user_provider.dart';
import 'package:dormcare/services/notification_service.dart';

class AlertOwnerScreen extends StatefulWidget {
  const AlertOwnerScreen({super.key});

  @override
  State<AlertOwnerScreen> createState() => _AlertOwnerScreenState();
}

class _AlertOwnerScreenState extends State<AlertOwnerScreen> {
  final _notifService = NotificationService();

  Future<void> _markAsRead(String id) async {
    await _notifService.markAsRead(id);
  }

  Future<void> _markAllAsRead(String userId) async {
    await _notifService.markAllAsRead(userId);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Alerts',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(color: Colors.grey.shade300, height: 1),
        ),
      ),
      body: StreamBuilder<List<AlertOwnerModel>>(
        stream: _notifService.getOwnerNotifications(user.uid),
        builder: (context, snapshot) {
          final alerts = snapshot.data ?? [];
          final isLoading = snapshot.connectionState == ConnectionState.waiting;
          final hasUnread = alerts.any((a) => !a.isRead);

          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              _buildSearchAndActions(),
              const SizedBox(height: 10),
              _buildListHeader(alerts.length, hasUnread, user.uid),
              const SizedBox(height: 6),
              Expanded(
                child: alerts.isEmpty
                    ? _buildEmptyState()
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                        itemCount: alerts.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final alert = alerts[index];
                          return AlertOwnerCard(
                            data: alert,
                            onTap: () {
                              _markAsRead(alert.id);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      AlertDetailOwnerScreen(data: alert),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ComposeAlertOwnerScreen()),
        ),
        backgroundColor: AppColors.ownerPrimary,
        elevation: 2,
        icon: const Icon(Icons.send_outlined, color: AppColors.white, size: 18),
        label: const Text(
          'Send Alert',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchAndActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, size: 18, color: Colors.grey.shade400),
                  const SizedBox(width: 8),
                  Text(
                    'Search alerts...',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: const Center(
              child: Icon(
                Icons.filter_alt_outlined,
                size: 20,
                color: AppColors.ownerPrimary,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: const Center(
              child: Icon(Icons.sort, size: 20, color: AppColors.ownerPrimary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListHeader(int count, bool hasUnread, String userId) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$count notifications',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (hasUnread)
            GestureDetector(
              onTap: () => _markAllAsRead(userId),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.done_all, size: 13, color: AppColors.ownerPrimary),
                  SizedBox(width: 4),
                  Text(
                    'Mark all as read',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.ownerPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.divider,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_off_outlined,
              size: 32,
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No notifications',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "You're all caught up!",
            style: TextStyle(color: AppColors.textTertiary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
