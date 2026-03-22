import 'package:dormcare/model/owner/room_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PostBillFormScreen extends StatefulWidget {
  final int year;
  final int month;
  final RoomModel room;

  const PostBillFormScreen({
    super.key,
    required this.year,
    required this.month,
    required this.room,
  });

  @override
  State<PostBillFormScreen> createState() => _PostBillFormScreenState();
}

class _PostBillFormScreenState extends State<PostBillFormScreen> {
  // Controllers
  final _waterCtrl = TextEditingController();
  final _waterUnitCtrl = TextEditingController(text: '18');
  final _elecCtrl = TextEditingController();
  final _elecUnitCtrl = TextEditingController(text: '8');
  final _otherCtrl = TextEditingController(text: '0');

  @override
  void dispose() {
    _waterCtrl.dispose();
    _waterUnitCtrl.dispose();
    _elecCtrl.dispose();
    _elecUnitCtrl.dispose();
    _otherCtrl.dispose();
    super.dispose();
  }

  // Computed totals
  double get _waterTotal => (_parse(_waterCtrl) * _parse(_waterUnitCtrl));
  double get _elecTotal => (_parse(_elecCtrl) * _parse(_elecUnitCtrl));
  double get _otherTotal => _parse(_otherCtrl);
  double get _grandTotal =>
      widget.room.price + _waterTotal + _elecTotal + _otherTotal;

  double _parse(TextEditingController c) => double.tryParse(c.text) ?? 0;

  // ─── Build ───────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final monthLabel = DateFormat(
      'MMMM yyyy',
    ).format(DateTime(widget.year, widget.month));

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text(
          'Post Bill',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(color: Colors.grey.shade300, height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Room + month info card
            _buildInfoCard(monthLabel),
            const SizedBox(height: 16),

            // Room rent (read-only)
            _buildSectionLabel('Room Rent'),
            const SizedBox(height: 8),
            _buildReadOnlyField(
              icon: Icons.home_outlined,
              iconColor: const Color(0xFF367BF3),
              label: 'Monthly rent',
              value: '${widget.room.price.toInt()} THB',
            ),
            const SizedBox(height: 16),

            // Water
            _buildSectionLabel('Water Bill'),
            const SizedBox(height: 8),
            _buildUnitField(
              icon: Icons.water_drop_outlined,
              iconColor: const Color(0xFF00BCD4),
              unitsCtrl: _waterCtrl,
              unitRateCtrl: _waterUnitCtrl,
              unitsHint: 'Units used',
              rateHint: 'THB / unit',
            ),
            const SizedBox(height: 16),

            // Electricity
            _buildSectionLabel('Electricity Bill'),
            const SizedBox(height: 8),
            _buildUnitField(
              icon: Icons.bolt_outlined,
              iconColor: const Color(0xFFFFA726),
              unitsCtrl: _elecCtrl,
              unitRateCtrl: _elecUnitCtrl,
              unitsHint: 'Units used',
              rateHint: 'THB / unit',
            ),
            const SizedBox(height: 16),

            // Other
            _buildSectionLabel('Other Charges'),
            const SizedBox(height: 8),
            _buildSimpleField(
              icon: Icons.add_circle_outline,
              iconColor: Colors.grey.shade400,
              ctrl: _otherCtrl,
              hint: 'Amount (THB)',
            ),
            const SizedBox(height: 20),

            // Total summary card
            _buildTotalCard(),
            const SizedBox(height: 24),

            // Submit
            _buildSubmitButton(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // ─── Private Helpers ─────────────────────────────────────────────────────

  Widget _buildInfoCard(String monthLabel) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F0FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFD4A6F8).withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFA34CF3).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.meeting_room_outlined,
              size: 20,
              color: Color(0xFFA34CF3),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Room ${widget.room.roomNumber}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF6B21C8),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${widget.room.tenantName ?? '-'}  ·  $monthLabel',
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xFFA34CF3).withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Color(0xFF0D1B2A),
      ),
    );
  }

  Widget _buildReadOnlyField({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
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
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0D1B2A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitField({
    required IconData icon,
    required Color iconColor,
    required TextEditingController unitsCtrl,
    required TextEditingController unitRateCtrl,
    required String unitsHint,
    required String rateHint,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
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
              const SizedBox(width: 12),
              Expanded(
                child: _inputField(ctrl: unitsCtrl, hint: unitsHint),
              ),
              const SizedBox(width: 8),
              const Text(
                '×',
                style: TextStyle(fontSize: 16, color: Color(0xFF9AA5B4)),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 90,
                child: _inputField(ctrl: unitRateCtrl, hint: rateHint),
              ),
            ],
          ),
          // Computed subtotal
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: AnimatedBuilder(
                animation: Listenable.merge([unitsCtrl, unitRateCtrl]),
                builder: (context, index) {
                  final sub = _parse(unitsCtrl) * _parse(unitRateCtrl);
                  return Text(
                    '= ${sub.toInt()} THB',
                    style: TextStyle(
                      fontSize: 12,
                      color: iconColor,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleField({
    required IconData icon,
    required Color iconColor,
    required TextEditingController ctrl,
    required String hint,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
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
          const SizedBox(width: 12),
          Expanded(
            child: _inputField(ctrl: ctrl, hint: hint),
          ),
        ],
      ),
    );
  }

  Widget _inputField({
    required TextEditingController ctrl,
    required String hint,
  }) {
    return TextField(
      controller: ctrl,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
      onChanged: (_) => setState(() {}),
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF0D1B2A),
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
        border: InputBorder.none,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
      ),
    );
  }

  Widget _buildTotalCard() {
    final rows = [
      ('Room Rent', widget.room.price, const Color(0xFF367BF3)),
      ('Water', _waterTotal, const Color(0xFF00BCD4)),
      ('Electricity', _elecTotal, const Color(0xFFFFA726)),
      if (_otherTotal > 0) ('Other', _otherTotal, Colors.grey.shade400),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
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
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: const Text(
              'Summary',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0D1B2A),
              ),
            ),
          ),
          ...rows.map(
            (r) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: r.$3,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      r.$1,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  Text(
                    '${r.$2.toInt()} THB',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0D1B2A),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 0.5,
            indent: 16,
            endIndent: 16,
            color: Colors.grey.shade100,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0D1B2A),
                  ),
                ),
                const Spacer(),
                Text(
                  '${_grandTotal.toInt()}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0D1B2A),
                    letterSpacing: -0.5,
                    height: 1,
                  ),
                ),
                const SizedBox(width: 4),
                const Padding(
                  padding: EdgeInsets.only(bottom: 1),
                  child: Text(
                    'THB',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF9AA5B4),
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

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFA34CF3),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        onPressed: () {
          Navigator.pop(context, true);
        },
        child: const Text(
          'Post Bill',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
