import 'package:dormcare/component/alert_tenant_card.dart';
import 'package:dormcare/model/tenant/alert_tenant_model.dart';
import 'package:dormcare/theme/app_theme.dart';
import 'package:dormcare/utils/constants.dart';
import 'package:flutter/material.dart';
import 'alter_detail_tenant_screen.dart';

class AlertTenantScreen extends StatefulWidget {
  const AlertTenantScreen({super.key});

  @override
  State<AlertTenantScreen> createState() => _AlertTenantScreenState();
}

class _AlertTenantScreenState extends State<AlertTenantScreen> {
  final _now = DateTime.now();

  late final List<AlertTenantModel> _allAlerts;
  List<AlertTenantModel> _displayedAlerts = [];

  AlertCategory? _selectedCategory; // null = All

  @override
  void initState() {
    super.initState();
    _allAlerts = [
      AlertTenantModel(
        id: '1',
        title: 'Water Cut Announcement',
        description:
            'Water supply will be suspended for maintenance on 15 Feb from 10:00 AM to 2:00 PM.',
        createdAt: DateTime(_now.year, _now.month, _now.day, 9, 45),
        category: AlertCategory.emergency,
        isRead: false,
      ),
      AlertTenantModel(
        id: '2',
        title: 'Parcel Arrived',
        description: 'You have a package waiting at the front desk. (Box #A12)',
        createdAt: DateTime(_now.year, _now.month, _now.day, 14, 30),
        category: AlertCategory.parcel,
        isRead: false,
      ),
      AlertTenantModel(
        id: '3',
        title: 'Electricity Bill Due',
        description:
            'Your electricity bill for January is ready. Please pay before the 25th.',
        createdAt: DateTime(_now.year, _now.month, _now.day - 10, 8, 0),
        category: AlertCategory.bill,
        isRead: true,
      ),
      AlertTenantModel(
        id: '4',
        title: 'Gym Cleaning Schedule',
        description:
            'The gym will be closed for deep cleaning every Monday morning.',
        createdAt: DateTime(_now.year, _now.month, _now.day - 15, 10, 0),
        category: AlertCategory.general,
        isRead: true,
      ),
    ];
    _applyFilters();
  }

  void _applyFilters() {
    setState(() {
      _displayedAlerts = _allAlerts.where((a) {
        return _selectedCategory == null || a.category == _selectedCategory;
      }).toList();
    });
  }

  void _markAsRead(String id) {
    final idx = _allAlerts.indexWhere((a) => a.id == id);
    if (idx != -1 && !_allAlerts[idx].isRead) {
      _allAlerts[idx].isRead = true;
      _applyFilters();
    }
  }

  void _markAllAsRead() {
    for (final a in _allAlerts) {
      a.isRead = true;
    }
    _applyFilters();
  }

  bool get _hasUnread => _allAlerts.any((a) => !a.isRead);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            _buildSearchAndActions(),
            const SizedBox(height: 10),
            _buildCategoryTabs(),
            const SizedBox(height: 8),
            _buildListHeader(),
            const SizedBox(height: 4),
            Expanded(
              child: _displayedAlerts.isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(
                        AppConstants.paddingLg,
                        4,
                        AppConstants.paddingLg,
                        16,
                      ),
                      itemCount: _displayedAlerts.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 4),
                      itemBuilder: (context, index) {
                        final alert = _displayedAlerts[index];
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
        ),
      ),
    );
  }

  Widget _buildSearchAndActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingLg),
      child: Row(
        children: [
          // Search bar
          Expanded(
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.tenantPrimary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, size: 18, color: Colors.grey.shade400),
                  const SizedBox(width: 8),
                  Text(
                    'Search repairs...',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Filter button
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: Colors.white,
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
          // Sort button
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: Colors.white,
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
            onTap: () {
              setState(() => _selectedCategory = tab.value);
              _applyFilters();
            },
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
                    color: isSelected ? Colors.white : AppColors.textHint,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    tab.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: isSelected ? Colors.white : AppColors.textHint,
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

  Widget _buildListHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${_displayedAlerts.length} notifications',
            style: const TextStyle(
              color: AppColors.textHint,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (_hasUnread)
            GestureDetector(
              onTap: _markAllAsRead,
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
              color: AppColors.textHint,
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
            style: TextStyle(color: AppColors.textHint, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
