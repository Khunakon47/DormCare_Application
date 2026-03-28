import 'package:dormcare/model/owner/alert_owner_model.dart';
import 'package:flutter/material.dart';
import 'alter_detail_owner_screen.dart';
import 'compose_alert_owner_screen.dart';

import 'package:dormcare/theme/app_theme.dart';
import 'package:dormcare/component/alert_owner_card.dart';

class AlertOwnerScreen extends StatefulWidget {
  const AlertOwnerScreen({super.key});

  @override
  State<AlertOwnerScreen> createState() => _AlertOwnerScreenState();
}

class _AlertOwnerScreenState extends State<AlertOwnerScreen> {
  final _now = DateTime.now();

  late final List<AlertOwnerModel> _allAlerts = [
    AlertOwnerModel(
      id: '1',
      title: 'New Repair Request',
      description: 'Room 203 reported a leaking faucet in the kitchen sink.',
      createdAt: DateTime(_now.year, _now.month, _now.day, 9, 15),
      category: AlertOwnerCategory.repairRequest,
      roomNumber: '203',
      tenantName: 'Nattaya P.',
      isRead: false,
    ),
    AlertOwnerModel(
      id: '2',
      title: 'New Repair Request',
      description: 'Room 101 reported a broken TV screen.',
      createdAt: DateTime(_now.year, _now.month, _now.day, 11, 30),
      category: AlertOwnerCategory.repairRequest,
      roomNumber: '101',
      tenantName: 'Somchai K.',
      isRead: false,
    ),
    AlertOwnerModel(
      id: '3',
      title: 'Bill Reminder Sent',
      description:
          'Monthly bill reminder has been sent to all rooms for February 2025.',
      createdAt: DateTime(_now.year, _now.month, _now.day - 1, 8, 0),
      category: AlertOwnerCategory.billReminder,
      isRead: true,
    ),
    AlertOwnerModel(
      id: '4',
      title: 'Maintenance Announcement',
      description:
          'Common area cleaning has been scheduled for this Saturday 9:00 AM.',
      createdAt: DateTime(_now.year, _now.month, _now.day - 3, 14, 0),
      category: AlertOwnerCategory.general,
      isRead: true,
    ),
  ];
  
  List<AlertOwnerModel> get _displayedAlerts => _allAlerts;

  void _markAsRead(String id) {
    final index = _allAlerts.indexWhere((e) => e.id == id);
    if (index != -1 && !_allAlerts[index].isRead) {
      setState(() {
        _allAlerts[index].isRead = true;
      });
    }
  }

  void _markAllAsRead() {
    setState(() {
      for (final alert in _allAlerts) {
        alert.isRead = true;
      }
    });
  }

  bool get _hasUnread => _allAlerts.any((a) => !a.isRead);

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          _buildSearchAndActions(),
          const SizedBox(height: 10),
          _buildListHeader(),
          const SizedBox(height: 6),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              itemCount: _displayedAlerts.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final alert = _displayedAlerts[index];
                return AlertOwnerCard(
                  data: alert,
                  onTap: () {
                    _markAsRead(alert.id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AlertDetailOwnerScreen(data: alert),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
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

          GestureDetector(
            onTap: () {}, // UI only
            child: Container(
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
          ),

          const SizedBox(width: 8),

          GestureDetector(
            onTap: () {}, // UI only
            child: Container(
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
                children: const [
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
}