import 'package:dormcare/model/repair_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'repair_detail_owner_screen.dart';
import 'repair_filter_owner_sheet.dart';
import 'package:dormcare/theme/app_theme.dart';
import 'package:dormcare/component/repair_owner_card.dart';
import 'package:dormcare/providers/user_provider.dart';
import 'package:dormcare/services/repair_service.dart';

class RepairsOwnerScreen extends StatefulWidget {
  const RepairsOwnerScreen({super.key});

  @override
  State<RepairsOwnerScreen> createState() => _RepairsOwnerScreenState();
}

class _RepairsOwnerScreenState extends State<RepairsOwnerScreen> {
  final _repairService = RepairService();
  RepairStatus? _selectedStatus;
  int _selectedFloor = 0;

  List<RepairModel> _applyFilters(List<RepairModel> repairs) {
    var result = repairs;
    if (_selectedFloor != 0) {
      result = result
          .where((r) => r.roomNumber.startsWith('$_selectedFloor'))
          .toList();
    }
    if (_selectedStatus != null) {
      result = result.where((r) => r.status == _selectedStatus).toList();
    }
    return result;
  }

  int get _activeFilterCount {
    int count = 0;
    if (_selectedStatus != null) count++;
    if (_selectedFloor != 0) count++;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: StreamBuilder<List<RepairModel>>(
          stream: _repairService.getRepairsByDorm(user.dormId),
          builder: (context, snapshot) {
            final allRepairs = snapshot.data ?? [];
            final filtered = _applyFilters(allRepairs);
            final isLoading =
                snapshot.connectionState == ConnectionState.waiting;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                if (isLoading)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else
                  _buildStatusSummaryBar(allRepairs),
                const SizedBox(height: 12),
                _buildSearchAndActions(),
                const SizedBox(height: 10),
                _buildListHeader(filtered.length),
                const SizedBox(height: 6),
                Expanded(
                  child: filtered.isEmpty && !isLoading
                      ? _buildEmptyState()
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                          itemCount: filtered.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) => RepairOwnerCard(
                            data: filtered[index],
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => RepairDetailOwnerScreen(
                                    data: filtered[index],
                                    onStatusUpdated: () => setState(() {}),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatusSummaryBar(List<RepairModel> repairs) {
    final total = repairs.length;
    final pending = repairs
        .where((r) => r.status == RepairStatus.pending)
        .length;
    final inProgress = repairs
        .where((r) => r.status == RepairStatus.inProgress)
        .length;
    final completed = repairs
        .where((r) => r.status == RepairStatus.completed)
        .length;
    final cancelled = repairs
        .where((r) => r.status == RepairStatus.cancelled)
        .length;

    final segments = [
      (count: pending, color: AppColors.warning, label: 'Pending'),
      (count: inProgress, color: AppColors.info, label: 'In Progress'),
      (count: completed, color: AppColors.success, label: 'Completed'),
      (count: cancelled, color: AppColors.error, label: 'Cancelled'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.ownerPrimary.withValues(alpha: 0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Overview',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                Text(
                  '$total requests total',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textTertiary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 30,
                child: Row(
                  children: total == 0
                      ? [Expanded(child: Container(color: AppColors.divider))]
                      : segments.where((s) => s.count > 0).map((s) {
                          final pct = ((s.count / total) * 100).round();
                          return Expanded(
                            flex: s.count,
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 2),
                              color: s.color,
                              child: pct >= 10
                                  ? Text(
                                      '$pct%',
                                      style: const TextStyle(
                                        color: AppColors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  : null,
                            ),
                          );
                        }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 6,
              children: segments
                  .map(
                    (s) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: s.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${s.count} ${s.label}',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
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
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.ownerPrimary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, size: 18, color: AppColors.textTertiary),
                  const SizedBox(width: 8),
                  Text(
                    'Search by room or tenant...',
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
          GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              showDragHandle: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) => RepairFilterOwnerSheet(
                initialStatus: _selectedStatus,
                initialFloor: _selectedFloor,
                onApply: (status, floor) => setState(() {
                  _selectedStatus = status;
                  _selectedFloor = floor;
                }),
              ),
            ),
            child: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.ownerPrimary.withValues(alpha: 0.3),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Center(
                    child: Icon(
                      Icons.filter_alt_outlined,
                      size: 20,
                      color: AppColors.ownerPrimary,
                    ),
                  ),
                  if (_activeFilterCount > 0)
                    Positioned(
                      right: 0,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        height: 16,
                        decoration: BoxDecoration(
                          color: AppColors.ownerPrimary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '$_activeFilterCount',
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
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
                color: AppColors.ownerPrimary.withValues(alpha: 0.3),
              ),
            ),
            child: const Center(
              child: Icon(Icons.sort, size: 20, color: AppColors.ownerPrimary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListHeader(int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'All Repair Requests',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '$count ${_activeFilterCount == 0 ? 'requests' : 'results'}',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
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
            'All repair requests will appear here',
            style: TextStyle(color: AppColors.textTertiary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
