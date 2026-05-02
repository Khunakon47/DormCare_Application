import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dormcare/component/repair_tenant_card.dart';
import 'package:dormcare/theme/app_theme.dart';
import 'package:dormcare/model/repair_model.dart';
import 'package:dormcare/providers/user_provider.dart';
import 'package:dormcare/services/repair_service.dart';
import 'repair_detail_tenant_screen.dart';
import 'report_tenant_screen.dart';

class RepairTenantScreen extends StatefulWidget {
  const RepairTenantScreen({super.key});

  @override
  State<RepairTenantScreen> createState() => _RepairTenantScreenState();
}

class _RepairTenantScreenState extends State<RepairTenantScreen> {
  final _repairService = RepairService();
  int _selectedStatusIndex = 0;

  List<RepairModel> _filter(List<RepairModel> repairs) {
    if (_selectedStatusIndex == 0) return repairs;
    final statuses = [
      null,
      RepairStatus.pending,
      RepairStatus.inProgress,
      RepairStatus.completed,
      RepairStatus.cancelled,
    ];
    return repairs
        .where((r) => r.status == statuses[_selectedStatusIndex])
        .toList();
  }

  Future<void> _openReport() async {
    final messenger = ScaffoldMessenger.of(context);
    final success = await Navigator.push<bool>(
      context,
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
                color: AppColors.white,
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();

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
            Expanded(
              child: StreamBuilder<List<RepairModel>>(
                stream: _repairService.getRepairsByTenant(user.uid),
                builder: (context, snapshot) {
                  // Loading
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Error
                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: AppColors.error,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Failed to load repairs',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    );
                  }

                  final allRepairs = snapshot.data ?? [];
                  final filtered = _filter(allRepairs);

                  return Column(
                    children: [
                      // List header
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'My Repair Requests',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${filtered.length} ${_selectedStatusIndex == 0 ? 'requests' : 'results'}',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Expanded(
                        child: filtered.isEmpty
                            ? _buildEmptyState()
                            : ListView.separated(
                                padding: const EdgeInsets.fromLTRB(
                                  16,
                                  4,
                                  16,
                                  16,
                                ),
                                itemCount: filtered.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, index) =>
                                    RepairTenantCard(
                                      data: filtered[index],
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              RepairDetailTenantScreen(
                                                data: filtered[index],
                                              ),
                                        ),
                                      ),
                                    ),
                              ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openReport,
        backgroundColor: AppColors.tenantPrimary,
        elevation: 2,
        icon: const Icon(Icons.add, color: AppColors.white, size: 20),
        label: const Text(
          'Report Issue',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

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
                    'Search repairs...',
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
                color: isSelected ? colors[index] : AppColors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? colors[index] : AppColors.border,
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
                  color: isSelected ? AppColors.white : AppColors.textSecondary,
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.border,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.build_outlined,
              size: 32,
              color: AppColors.textDisabled,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No requests found',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Tap + Report Issue to submit a new request',
            style: TextStyle(color: AppColors.textTertiary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
