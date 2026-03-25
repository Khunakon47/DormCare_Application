import 'package:dormcare/model/owner/bill_model.dart';
import 'package:dormcare/model/owner/room_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:dormcare/theme/app_theme.dart';

class BillDetailScreen extends StatefulWidget {
  final BillModel bill;
  final RoomModel? room;

  const BillDetailScreen({super.key, required this.bill, required this.room});

  @override
  State<BillDetailScreen> createState() => _BillDetailScreenState();
}

class _BillDetailScreenState extends State<BillDetailScreen>
    with SingleTickerProviderStateMixin {
  // ─── Form state ───────────────────────────────────────────────────────────
  late TextEditingController _waterCtrl;
  late TextEditingController _electricCtrl;
  late TextEditingController _otherCtrl;
  late bool _isPaid;
  bool _hasChanges = false;
  bool _saving = false;

  // ─── Pulse animation for total preview ────────────────────────────────────
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    final b = widget.bill;
    _waterCtrl = TextEditingController(
      text: b.waterUnit == 0 ? '' : b.waterUnit.toInt().toString(),
    );
    _electricCtrl = TextEditingController(
      text: b.electricUnit == 0 ? '' : b.electricUnit.toInt().toString(),
    );
    _otherCtrl = TextEditingController(
      text: b.other == 0 ? '' : b.other.toInt().toString(),
    );
    _isPaid = b.isPaid;

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _pulseAnim = Tween<double>(
      begin: 1.0,
      end: 1.04,
    ).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeOut));

    for (final c in [_waterCtrl, _electricCtrl, _otherCtrl]) {
      c.addListener(_onFieldChanged);
    }
  }

  @override
  void dispose() {
    _waterCtrl.dispose();
    _electricCtrl.dispose();
    _otherCtrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    setState(() => _hasChanges = true);
    _pulseCtrl.forward(from: 0);
  }

  // ─── Computed ────────────────────────────────────────────────────────────

  double get _waterUnits => double.tryParse(_waterCtrl.text) ?? 0;
  double get _electricUnits => double.tryParse(_electricCtrl.text) ?? 0;
  double get _otherAmt => double.tryParse(_otherCtrl.text) ?? 0;
  double get _waterAmt => _waterUnits * widget.bill.water;
  double get _electricAmt => _electricUnits * widget.bill.electric;
  double get _previewTotal =>
      widget.bill.rent + _waterAmt + _electricAmt + _otherAmt;
  bool get _isFormValid => _waterUnits > 0 && _electricUnits > 0;

  // ─── Actions ──────────────────────────────────────────────────────────────

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    setState(() => _saving = true);
    await Future.delayed(const Duration(milliseconds: 300));
    final updated = BillModel(
      billId: widget.bill.billId,
      roomNumber: widget.bill.roomNumber,
      postedDate: widget.bill.postedDate,
      dueDate: widget.bill.dueDate,
      rent: widget.bill.rent,
      water: widget.bill.water,
      waterUnit: _waterUnits,
      electric: widget.bill.electric,
      electricUnit: _electricUnits,
      other: _otherAmt,
      isPaid: _isPaid,
    );
    if (mounted) Navigator.pop(context, updated);
  }

  void _toggleStatus() => setState(() {
    _isPaid = !_isPaid;
    _hasChanges = true;
  });

  Future<bool> _confirmPop() async {
    if (!_hasChanges) return true;
    return await _showUnsavedDialog() ?? false;
  }

  Future<bool?> _showUnsavedDialog() => showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColors.warningSoft,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              size: 24,
              color: AppColors.warning,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Unsaved Changes',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'You have unsaved changes.\nLeave without saving?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text(
            'Stay',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(ctx, true),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.warning,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'Leave',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    ),
  );

  // ─── Build ───────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        if (await _confirmPop() && context.mounted) Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 48),
          child: Column(
            children: [
              _buildHeroCard(),
              const SizedBox(height: 16),
              _buildStatusSection(),
              const SizedBox(height: 16),
              _buildMeterSection(),
              const SizedBox(height: 16),
              _buildTotalPreview(),
              const SizedBox(height: 24),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  // ─── AppBar ───────────────────────────────────────────────────────────────

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: AppColors.textPrimary,
        ),
        onPressed: () async {
          final shouldPop = await _confirmPop();

          if (!mounted) return;

          if (shouldPop) {
            Navigator.pop(context);
          }
        },
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Room ${widget.bill.roomNumber}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              if (widget.room?.tenantName != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.ownerSoft,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    widget.room!.tenantName!,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ownerPrimary,
                    ),
                  ),
                ),
              ],
            ],
          ),
          Text(
            DateFormat('MMMM yyyy').format(widget.bill.postedDate),
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textTertiary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      actions: [
        if (_hasChanges)
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.warningSoft,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    color: AppColors.warning.withValues(alpha: 0.4),
                  ),
                ),
                child: const Text(
                  'Unsaved',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.warning,
                  ),
                ),
              ),
            ),
          ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: Colors.grey.shade100, height: 1),
      ),
    );
  }

  // ─── Hero card ────────────────────────────────────────────────────────────

  Widget _buildHeroCard() {
    final monthLabel = DateFormat('MMMM yyyy').format(widget.bill.postedDate);
    final dueLabel = DateFormat('d MMM yyyy').format(widget.bill.dueDate);
    final isComplete = _isFormValid;
    final gradColors = _isPaid
        ? [AppColors.successDark, const Color(0xFF2E7D32)]
        : [AppColors.ownerPrimary, AppColors.ownerDark];
    final shadowColor =
        (_isPaid ? AppColors.successDark : AppColors.ownerPrimary).withValues(
          alpha: 0.3,
        );

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -28,
            right: -18,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),
          Positioned(
            bottom: -32,
            left: 40,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.04),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Month + status
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            monthLabel,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.4,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.schedule_outlined,
                                size: 11,
                                color: Colors.white.withValues(alpha: 0.65),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Due $dueLabel',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.25),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _isPaid
                                ? Icons.check_circle_outline
                                : Icons.pending_outlined,
                            size: 11,
                            color: _isPaid
                                ? const Color(0xFFA5F3FC)
                                : const Color(0xFFFDE68A),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _isPaid ? 'Paid' : 'Unpaid',
                            style: TextStyle(
                              color: _isPaid
                                  ? const Color(0xFFA5F3FC)
                                  : const Color(0xFFFDE68A),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // Total number — pulses when fields change
                ScaleTransition(
                  scale: _pulseAnim,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        isComplete
                            ? NumberFormat(
                                '#,##0',
                              ).format(_previewTotal.toInt())
                            : '—',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -2,
                          height: 1,
                        ),
                      ),
                      if (isComplete)
                        const Padding(
                          padding: EdgeInsets.only(left: 6, bottom: 5),
                          child: Text(
                            'THB',
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.15),
                ),
                const SizedBox(height: 14),

                // Mini pills
                Row(
                  children: [
                    _buildHeroPill(
                      Icons.home_outlined,
                      const Color(0xFFBFDBFE),
                      'Rent',
                      widget.bill.rent.toInt().toString(),
                    ),
                    const SizedBox(width: 8),
                    _buildHeroPill(
                      Icons.water_drop_outlined,
                      const Color(0xFFA5F3FC),
                      'Water',
                      isComplete ? _waterAmt.toInt().toString() : '?',
                    ),
                    const SizedBox(width: 8),
                    _buildHeroPill(
                      Icons.bolt_outlined,
                      const Color(0xFFFDE68A),
                      'Elec',
                      isComplete ? _electricAmt.toInt().toString() : '?',
                    ),
                    if (_otherAmt > 0) ...[
                      const SizedBox(width: 8),
                      _buildHeroPill(
                        Icons.add_circle_outline,
                        const Color(0xFFE9D5FF),
                        'Other',
                        _otherAmt.toInt().toString(),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroPill(
    IconData icon,
    Color color,
    String label,
    String value,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(11),
          border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 5),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Status section ───────────────────────────────────────────────────────

  Widget _buildStatusSection() {
    return _SectionCard(
      title: 'Payment Status',
      icon: Icons.payments_outlined,
      child: Row(
        children: [
          Expanded(
            child: _buildStatusOption(
              icon: Icons.check_circle_outline,
              label: 'Paid',
              isActive: _isPaid,
              activeColor: AppColors.success,
              activeBg: AppColors.successSoft,
              onTap: _isPaid ? null : _toggleStatus,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildStatusOption(
              icon: Icons.undo_rounded,
              label: 'Mark Unpaid',
              isActive: !_isPaid,
              activeColor: AppColors.error,
              activeBg: const Color(0xFFFFEBEE),
              onTap: !_isPaid ? null : _toggleStatus,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusOption({
    required IconData icon,
    required String label,
    required bool isActive,
    required Color activeColor,
    required Color activeBg,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isActive ? activeBg : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive
                ? activeColor.withValues(alpha: 0.4)
                : AppColors.border,
            width: isActive ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 22,
              color: isActive ? activeColor : AppColors.textTertiary,
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: isActive ? activeColor : AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Meter section ────────────────────────────────────────────────────────

  Widget _buildMeterSection() {
    final b = widget.bill;
    final needsMeter = b.waterUnit == 0 || b.electricUnit == 0;

    return _SectionCard(
      title: needsMeter ? 'Enter Meter Readings' : 'Edit Meter Readings',
      icon: needsMeter ? Icons.edit_note_rounded : Icons.tune_rounded,
      badge: needsMeter ? 'Required' : null,
      badgeColor: AppColors.warning,
      child: Column(
        children: [
          // Rent — read only
          _buildReadonlyRow(
            icon: Icons.home_outlined,
            iconColor: const Color(0xFF367BF3),
            label: 'Room Rent',
            value: '${b.rent.toInt()} THB',
            sub: 'Fixed monthly charge',
          ),
          const SizedBox(height: 10),
          // Water
          _buildMeterRow(
            icon: Icons.water_drop_outlined,
            iconColor: const Color(0xFF00BCD4),
            label: 'Water Units',
            rateLabel: 'Rate: ${b.water.toInt()} THB/unit',
            ctrl: _waterCtrl,
            previewValue: _waterAmt.toInt(),
            hint: 'Enter units',
          ),
          const SizedBox(height: 10),
          // Electricity
          _buildMeterRow(
            icon: Icons.bolt_outlined,
            iconColor: const Color(0xFFFFA726),
            label: 'Electricity Units',
            rateLabel: 'Rate: ${b.electric.toInt()} THB/unit',
            ctrl: _electricCtrl,
            previewValue: _electricAmt.toInt(),
            hint: 'Enter units',
          ),
          const SizedBox(height: 10),
          // Other (optional)
          _buildMeterRow(
            icon: Icons.add_circle_outline,
            iconColor: Colors.grey.shade400,
            label: 'Other Charges',
            rateLabel: 'Optional — e.g. maintenance, parking',
            ctrl: _otherCtrl,
            previewValue: _otherAmt.toInt(),
            hint: '0',
            isOptional: true,
          ),
        ],
      ),
    );
  }

  Widget _buildReadonlyRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required String sub,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 11, 14, 11),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF374151),
                  ),
                ),
                Text(
                  sub,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeterRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String rateLabel,
    required TextEditingController ctrl,
    required int previewValue,
    required String hint,
    bool isOptional = false,
  }) {
    final hasValue = ctrl.text.isNotEmpty;
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hasValue ? iconColor.withValues(alpha: 0.3) : AppColors.border,
          width: hasValue ? 1.3 : 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 15, color: iconColor),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          label,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF374151),
                          ),
                        ),
                        if (isOptional) ...[
                          const SizedBox(width: 6),
                          const Text(
                            'Optional',
                            style: TextStyle(
                              fontSize: 9,
                              color: AppColors.textTertiary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      rateLabel,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: SizedBox(
                  height: 44,
                  child: TextField(
                    controller: ctrl,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade300,
                        fontWeight: FontWeight.w500,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF9FAFB),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 11,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: iconColor.withValues(alpha: 0.6),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: iconColor.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '=',
                        style: TextStyle(
                          fontSize: 14,
                          color: iconColor.withValues(alpha: 0.5),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          '$previewValue THB',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: iconColor,
                            letterSpacing: -0.3,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Total preview ────────────────────────────────────────────────────────

  Widget _buildTotalPreview() {
    final isComplete = _isFormValid;
    final accentColor = _isPaid
        ? AppColors.successDark
        : AppColors.ownerPrimary;
    final bgStart = _isPaid ? const Color(0xFFECFDF5) : AppColors.ownerSoft;
    final bgEnd = _isPaid ? AppColors.successSoft : const Color(0xFFDDD6FE);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bgStart, bgEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accentColor.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.summarize_outlined, size: 18, color: accentColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bill Total',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: accentColor.withValues(alpha: 0.75),
                  ),
                ),
                if (!isComplete)
                  const Text(
                    'Fill in meter readings above',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textTertiary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
          ScaleTransition(
            scale: _pulseAnim,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  isComplete
                      ? NumberFormat('#,##0').format(_previewTotal.toInt())
                      : '—',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: accentColor,
                    letterSpacing: -1,
                    height: 1,
                  ),
                ),
                if (isComplete)
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 3),
                    child: Text(
                      'THB',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: accentColor.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Save button ──────────────────────────────────────────────────────────

  Widget _buildSaveButton() {
    final canSave = _isFormValid && _hasChanges && !_saving;
    final accentColor = _isPaid
        ? AppColors.successDark
        : AppColors.ownerPrimary;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: canSave ? _save : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: canSave ? accentColor : AppColors.border,
          disabledBackgroundColor: AppColors.border,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: _saving
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.save_outlined,
                    size: 18,
                    color: canSave ? Colors.white : AppColors.textTertiary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    canSave ? 'Save Changes' : 'No changes to save',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: canSave ? Colors.white : AppColors.textTertiary,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

// ─── Section card ─────────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final String? badge;
  final Color badgeColor;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
    this.badge,
    this.badgeColor = const Color(0xFFFFA726),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xFFA34CF3).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 15, color: const Color(0xFFA34CF3)),
                ),
                const SizedBox(width: 9),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0D1B2A),
                  ),
                ),
                if (badge != null) ...[
                  const SizedBox(width: 7),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: badgeColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      badge!,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: badgeColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(height: 1, color: Colors.grey.shade100),
          Padding(padding: const EdgeInsets.all(14), child: child),
        ],
      ),
    );
  }
}
