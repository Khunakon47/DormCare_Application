import 'package:dormcare/model/owner/alert_owner_model.dart';
import 'package:flutter/material.dart';
import 'alter_detail_owner_screen.dart';
import 'compose_alert_owner_screen.dart';

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
      backgroundColor: const Color(0xFFF7F8FA),
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
                return _AlertOwnerCard(
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
        backgroundColor: const Color(0xFFA34CF3),
        elevation: 2,
        icon: const Icon(Icons.send_outlined, color: Colors.white, size: 18),
        label: const Text(
          'Send Alert',
          style: TextStyle(
            color: Colors.white,
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

          GestureDetector(
            onTap: () {}, // UI only
            child: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const Center(
                child: Icon(
                  Icons.filter_alt_outlined,
                  size: 20,
                  color: Color(0xFFA34CF3),
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const Center(
                child: Icon(Icons.sort, size: 20, color: Color(0xFFA34CF3)),
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
                  Icon(Icons.done_all, size: 13, color: Color(0xFFA34CF3)),
                  SizedBox(width: 4),
                  Text(
                    'Mark all as read',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFA34CF3),
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

// เดี๋ยวย้ายไปไว้ใน components ทีหลัง
class _AlertOwnerCard extends StatelessWidget {
  final AlertOwnerModel data;
  final VoidCallback onTap;

  const _AlertOwnerCard({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: data.isRead
                ? Colors.grey.shade100
                : data.categoryColor.withValues(alpha: 0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: data.categoryBgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  data.categoryIcon,
                  size: 20,
                  color: data.categoryColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            data.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: data.isRead
                                  ? FontWeight.w600
                                  : FontWeight.w700,
                              color: const Color(0xFF0D1B2A),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          data.displayDate,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                    if (data.roomNumber != null) ...[
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFFA34CF3,
                          ).withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.meeting_room_outlined,
                              size: 11,
                              color: Color(0xFFA34CF3),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Room ${data.roomNumber}${data.tenantName != null ? '  ·  ${data.tenantName}' : ''}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFFA34CF3),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 5),
                    Text(
                      data.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              if (!data.isRead) ...[
                const SizedBox(width: 8),
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: const BoxDecoration(
                    color: Color(0xFFA34CF3),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
