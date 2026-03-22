import 'package:flutter/material.dart';
import 'package:dormcare/component/repair_tenant_card.dart';
import 'package:dormcare/theme/app_theme.dart';
import 'package:dormcare/model/repair_model.dart';
import 'repair_detail_tenant_screen.dart';
import 'report_tenant_screen.dart';

class RepairTenantScreen extends StatefulWidget {
  const RepairTenantScreen({super.key});

  @override
  State<RepairTenantScreen> createState() => _RepairTenantScreenState();
}

class _RepairTenantScreenState extends State<RepairTenantScreen> {
  int _selectedStatusIndex = 0;

  // Sample data for repairs list
  final List<RepairModel> _allRepairs = [
    RepairModel(
      id: '1',
      title: 'TV Broken',
      description:
          'The TV in the living room is not turning on. Please fix it as soon as possible.',
      roomNumber: '301',
      tenantName: 'JoBy Khuna',
      phoneNumber: '081-234-5678',
      reportedAt: DateTime(2024, 12, 10, 9, 30),
      imageUrl: 'https://picsum.photos/500/300?random=1',
      status: RepairStatus.completed,
      category: RepairCategory.appliance,
    ),
    RepairModel(
      id: '2',
      title: 'Leaking Faucet',
      description:
          'The kitchen faucet is leaking and causing water to pool around the sink area.',
      roomNumber: '301',
      tenantName: 'JoBy Khuna',
      phoneNumber: '081-234-5678',
      reportedAt: DateTime(2024, 12, 12, 14, 45),
      status: RepairStatus.inProgress,
      category: RepairCategory.plumbing,
    ),
    RepairModel(
      id: '3',
      title: 'Air Conditioner',
      description: 'The air conditioner in my bedroom is not cooling properly.',
      roomNumber: '301',
      tenantName: 'JoBy Khuna',
      phoneNumber: '081-234-5678',
      reportedAt: DateTime(2024, 12, 15, 11, 20),
      status: RepairStatus.pending,
      category: RepairCategory.appliance,
    ),
    RepairModel(
      id: '4',
      title: 'Broken Door Lock',
      description:
          'The lock on my bedroom door is broken and does not secure properly.',
      roomNumber: '301',
      tenantName: 'JoBy Khuna',
      phoneNumber: '081-234-5678',
      reportedAt: DateTime(2024, 12, 18, 16, 10),
      status: RepairStatus.cancelled,
      category: RepairCategory.other,
    ),
  ];

  // Filter repairs based on selected status tab
  List<RepairModel> get _filteredRepairs {
    if (_selectedStatusIndex == 0) return _allRepairs;
    final statuses = [
      null,
      RepairStatus.pending,
      RepairStatus.inProgress,
      RepairStatus.completed,
      RepairStatus.cancelled,
    ];
    return _allRepairs
        .where((r) => r.status == statuses[_selectedStatusIndex])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            _buildSearchAndSort(),
            const SizedBox(height: 10),
            _buildFilterTabs(),
            const SizedBox(height: 8),
            _buildListHeader(),
            const SizedBox(height: 6),
            Expanded(
              child: _filteredRepairs.isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                      itemCount: _filteredRepairs.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) => RepairTenantCard(
                        data: _filteredRepairs[index],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RepairDetailTenantScreen(
                              data: _filteredRepairs[index],
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final navigator = Navigator.of(context);
          final messenger = ScaffoldMessenger.of(context);

          final success = await navigator.push<bool>(
            MaterialPageRoute(builder: (_) => const ReportTenantScreen()),
          );

          if (!mounted) return;

          if (success == true) {
            messenger.showSnackBar(
              SnackBar(
                content: const Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text('Report submitted successfully'),
                  ],
                ),
                backgroundColor: AppColors.success,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                duration: const Duration(seconds: 3),
              ),
            );
          } else if (success == false) {
            messenger.showSnackBar(
              SnackBar(
                content: const Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.white, size: 20),
                    SizedBox(width: 10),
                    Text('Failed to submit. Please try again.'),
                  ],
                ),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        backgroundColor: AppColors.tenantPrimary,
        elevation: 2,
        icon: const Icon(Icons.add, color: Colors.white, size: 20),
        label: const Text(
          'Report Issue',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Search and sort method
  Widget _buildSearchAndSort() {
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
                    'Search repairs...',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.sort, size: 18, color: AppColors.tenantPrimary),
                const SizedBox(width: 6),
                Text(
                  'Sort',
                  style: TextStyle(
                    color: AppColors.tenantPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Filter tabs method
  Widget _buildFilterTabs() {
    final labels = ['All', 'Pending', 'In Progress', 'Completed', 'Cancelled'];
    final colors = [
      AppColors.tenantPrimary,
      AppColors.warning,
      AppColors.info,
      AppColors.success,
      AppColors.error,
    ];

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: labels.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = _selectedStatusIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedStatusIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: isSelected ? colors[index] : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? colors[index] : Colors.grey.shade200,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: colors[index].withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: Text(
                labels[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey.shade500,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // List header method
  Widget _buildListHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'My Repair Requests',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '${_filteredRepairs.length} ${_selectedStatusIndex == 0 ? 'requests' : 'results'}',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Empty state method
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
              Icons.build_outlined,
              size: 32,
              color: Colors.grey.shade300,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No requests found',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Tap + Report Issue to submit a new request',
            style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
