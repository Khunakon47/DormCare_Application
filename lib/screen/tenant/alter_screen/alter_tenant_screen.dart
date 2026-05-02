import 'package:dormcare/component/alert_tenant_card.dart';
import 'package:dormcare/model/tenant/alert_tenant_model.dart';
import 'package:dormcare/theme/app_theme.dart';
import 'package:dormcare/utils/constants.dart';
import 'package:dormcare/providers/user_provider.dart';
import 'package:dormcare/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'alter_detail_tenant_screen.dart';

class AlertTenantScreen extends StatefulWidget {
  const AlertTenantScreen({super.key});

  @override
  State<AlertTenantScreen> createState() => _AlertTenantScreenState();
}

class _AlertTenantScreenState extends State<AlertTenantScreen> {
  final _notifService = NotificationService();
  AlertCategory? _selectedCategory;

  Future<void> _markAsRead(String id) async {
    await _notifService.markAsRead(id);
  }

  Future<void> _markAllAsRead(String userId) async {
    await _notifService.markAllAsRead(userId);
  }

  List<AlertTenantModel> _applyFilter(List<AlertTenantModel> alerts) {
    if (_selectedCategory == null) return alerts;
    return alerts.where((a) => a.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: StreamBuilder<List<AlertTenantModel>>(
          stream: _notifService.getTenantNotifications(user.uid),
          builder: (context, snapshot) {
            final allAlerts = snapshot.data ?? [];
            final displayed = _applyFilter(allAlerts);
            final isLoading =
                snapshot.connectionState == ConnectionState.waiting;
            final hasUnread = allAlerts.any((a) => !a.isRead);

            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                _buildSearchAndActions(),
                const SizedBox(height: 10),
                _buildCategoryTabs(),
                const SizedBox(height: 8),
                _buildListHeader(displayed.length, hasUnread, user.uid),
                const SizedBox(height: 4),
                Expanded(
                  child: displayed.isEmpty
                      ? _buildEmptyState()
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(
                            AppConstants.paddingLg,
                            4,
                            AppConstants.paddingLg,
                            16,
                          ),
                          itemCount: displayed.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 4),
                          itemBuilder: (context, index) {
                            final alert = displayed[index];
                            return AlertTenantCard(
                              data: alert,
                              onTap: () {
                                _markAsRead(alert.id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        AlertDetailTenantScreen(data: alert),
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
      ),
    );
  }

  Widget _buildSearchAndActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingLg),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.tenantPrimary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, size: 18, color: AppColors.textTertiary),
                  const SizedBox(width: 8),
                  Text(
                    'Search alerts...',
                    style: TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 13,
                    ),
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
              border: Border.all(
                color: AppColors.tenantPrimary.withValues(alpha: 0.3),
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.filter_alt_outlined,
                size: 20,
                color: AppColors.tenantPrimary,
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
              border: Border.all(
                color: AppColors.tenantPrimary.withValues(alpha: 0.3),
              ),
            ),
            child: const Icon(
              Icons.sort,
              size: 20,
              color: AppColors.tenantPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    final tabs = [
      (label: 'All', value: null, icon: Icons.notifications_outlined),
      (
        label: 'Emergency',
        value: AlertCategory.emergency,
        icon: Icons.warning_amber_outlined,
      ),
      (label: 'Bill', value: AlertCategory.bill, icon: Icons.receipt_outlined),
      (
        label: 'Parcel',
        value: AlertCategory.parcel,
        icon: Icons.inventory_2_outlined,
      ),
      (
        label: 'General',
        value: AlertCategory.general,
        icon: Icons.info_outline,
      ),
    ];

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingLg),
        itemCount: tabs.length,
        separatorBuilder: (context, index) =>
            const SizedBox(width: AppConstants.paddingSm),
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final isSelected = _selectedCategory == tab.value;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = tab.value),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.tenantPrimary : AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppColors.tenantPrimary
                      : AppColors.border,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.tenantPrimary.withValues(alpha: 0.3),
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
                    tab.icon,
                    size: 13,
                    color: isSelected
                        ? AppColors.white
                        : AppColors.textTertiary,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    tab.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: isSelected
                          ? AppColors.white
                          : AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
            style: const TextStyle(
              color: AppColors.textTertiary,
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
                  Icon(
                    Icons.done_all,
                    size: 13,
                    color: AppColors.tenantPrimary,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Mark all as read',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.tenantPrimary,
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
          const Text(
            'No notifications found',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "You're all caught up!",
            style: TextStyle(color: AppColors.textTertiary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
