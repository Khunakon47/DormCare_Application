import 'package:dormcare/component/alert_card.dart';
import 'package:dormcare/component/alert_filter_sheet.dart';
import 'package:dormcare/component/alert_sort_sheet.dart';
import 'package:dormcare/model/tenant/alert_model.dart';
import 'package:flutter/material.dart';
import 'alter_detail_tenant_screen.dart';

class AlertTenantScreen extends StatefulWidget {
  const AlertTenantScreen({super.key});

  @override
  State<AlertTenantScreen> createState() => _AlertTenantScreenState();
}

class _AlertTenantScreenState extends State<AlertTenantScreen> {
  final _now = DateTime.now();

  late final List<AlertModel> _allAlerts;

  List<AlertModel> _displayedAlerts = [];
  AlertCategory? _selectedCategory;
  bool? _selectedReadStatus;
  AlertSortOption _currentSort = AlertSortOption.newest;

  @override
  void initState() {
    super.initState();
    _allAlerts = [
      AlertModel(
        id: '1',
        title: 'Water Cut Announcement',
        description:
            'Water supply will be suspended for maintenance on 15 Feb from 10:00 AM to 2:00 PM.',
        createdAt: DateTime(_now.year, _now.month, _now.day, 9, 45),
        category: AlertCategory.emergency,
        isRead: false,
      ),
      AlertModel(
        id: '2',
        title: 'Parcel Arrived',
        description: 'You have a package waiting at the front desk. (Box #A12)',
        createdAt: DateTime(_now.year, _now.month, _now.day, 14, 30),
        category: AlertCategory.parcel,
        isRead: false,
      ),
      AlertModel(
        id: '3',
        title: 'Electricity Bill Due',
        description:
            'Your electricity bill for January is ready. Please pay before the 25th.',
        createdAt: DateTime(_now.year, _now.month, _now.day - 10, 8, 0),
        category: AlertCategory.bill,
        isRead: true,
      ),
      AlertModel(
        id: '4',
        title: 'Gym Cleaning Schedule',
        description:
            'The gym will be closed for deep cleaning every Monday morning.',
        createdAt: DateTime(_now.year, _now.month, _now.day - 15, 10, 0),
        category: AlertCategory.general,
        isRead: true,
      ),
    ];
    _processData();
  }

  void _processData() {
    setState(() {
      var result = _allAlerts.where((alert) {
        final matchCategory =
            _selectedCategory == null || alert.category == _selectedCategory;
        final matchRead =
            _selectedReadStatus == null || alert.isRead == _selectedReadStatus;
        return matchCategory && matchRead;
      }).toList();

      if (_currentSort == AlertSortOption.unreadFirst) {
        result.sort((a, b) {
          if (a.isRead == b.isRead) return 0;
          return a.isRead ? 1 : -1;
        });
      } else if (_currentSort == AlertSortOption.oldest) {
        result = result.reversed.toList();
      }

      _displayedAlerts = result;
    });
  }

  void _markAsRead(String id) {
    final index = _allAlerts.indexWhere((e) => e.id == id);
    if (index != -1 && !_allAlerts[index].isRead) {
      _allAlerts[index].isRead = true;
      _processData();
    }
  }

  void _markAllAsRead() {
    for (final alert in _allAlerts) {
      alert.isRead = true;
    }
    _processData();
  }

  int get _activeFilterCount {
    int count = 0;
    if (_selectedCategory != null) count++;
    if (_selectedReadStatus != null) count++;
    return count;
  }

  bool get _hasUnread => _allAlerts.any((a) => !a.isRead);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            _buildSearchAndActions(),
            const SizedBox(height: 10),
            _buildListHeader(),
            const SizedBox(height: 6),
            Expanded(
              child: _displayedAlerts.isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                      itemCount: _displayedAlerts.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 4),
                      itemBuilder: (context, index) {
                        final alert = _displayedAlerts[index];
                        return AlertCard(
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
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

          // Filter button
          GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              showDragHandle: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) => AlertFilterSheet(
                initialCategory: _selectedCategory,
                initialReadStatus: _selectedReadStatus,
                onApply: (category, isRead) {
                  _selectedCategory = category;
                  _selectedReadStatus = isRead;
                  _processData();
                },
              ),
            ),
            child: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Center(
                child: _activeFilterCount > 0
                    ? Text(
                        '$_activeFilterCount',
                        style: const TextStyle(
                          color: Color(0xFF367BF3),
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    : const Icon(
                        Icons.filter_alt_outlined,
                        size: 20,
                        color: Color(0xFF367BF3),
                      ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Sort button
          GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              showDragHandle: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) => AlertSortSheet(
                currentSort: _currentSort,
                onApply: (sortOption) {
                  _currentSort = sortOption;
                  _processData();
                },
              ),
            ),
            child: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const Icon(
                Icons.swap_vert,
                size: 20,
                color: Color(0xFF367BF3),
              ),
            ),
          ),
        ],
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
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (_hasUnread)
            GestureDetector(
              onTap: _markAllAsRead,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.done_all,
                    size: 13,
                    color: Color(0xFF367BF3),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Mark all as read',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF367BF3),
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
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_off_outlined,
              size: 32,
              color: Colors.grey.shade300,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No notifications found',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "You're all caught up!",
            style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
