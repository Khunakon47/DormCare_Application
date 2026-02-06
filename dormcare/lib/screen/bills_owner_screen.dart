import 'package:dormcare/screen/bills_view.dart';
import 'package:dormcare/model/room_data_model.dart';
import 'package:dormcare/model/tenant_model.dart';
import 'package:flutter/material.dart';

class BillsOwnerScreen extends StatelessWidget {
  const BillsOwnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<RoomDataModel> roomBills = [
      RoomDataModel(),
      RoomDataModel(),
      RoomDataModel(),
      RoomDataModel(),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _headerCard(),
          const SizedBox(height: 15),
          _postBillButton(),
          const SizedBox(height: 15),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: _buildRevenueCard(roomBills: roomBills),
          ),
        ],
      ),
    );
  }

  // ================= HEADER =================
  Widget _headerCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      width: double.infinity,
      decoration: _gradientBox(),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Room Bills",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Edit individual room bills and payment status",
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // ================= BUTTON =================
  Widget _postBillButton() {
    return Container(
      decoration: _gradientBox(),
      child: TextButton(
        onPressed: () {},
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.white, size: 28),
            SizedBox(width: 8),
            Text(
              "Post New Monthly Bills",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= LIST =================
  Widget _buildRevenueCard({required List<RoomDataModel> roomBills}) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: roomBills.length,
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemBuilder: (context, index) {
        final bill = roomBills[index];

        final double collected = bill.totalUser == 0
            ? 0
            : bill.totalUserPaid / bill.totalUser;

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                offset: const Offset(0, 0),
                blurRadius: 10,
                spreadRadius: 0.2,
              ),
            ],
          ),
          child: Column(
            children: [
              // ===== MONTH HEADER =====
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFF112546),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bill.postedMY,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Posted on ${bill.postedDate}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Due: ${bill.dueDate}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ===== PAID / UNPAID =====
              Row(
                children: [
                  _statBox(
                    title: "Paid",
                    value: "${bill.totalUserPaid}/${bill.totalUser}",
                    amount: "${bill.rentFee} THB",
                    color: Colors.green,
                  ),
                  const SizedBox(width: 10),
                  _statBox(
                    title: "Unpaid",
                    value: "${bill.totalUserUnpaid}/${bill.totalUser}",
                    amount: "${bill.rentFee} THB",
                    color: Colors.red,
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // ===== PROGRESS =====
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Revenue",
                          style: TextStyle(fontSize: 10),
                        ),
                        Text(
                          "${(bill.rentFee * bill.totalUserPaid).toInt()} THB",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: LinearProgressIndicator(
                        value: collected,
                        minHeight: 8,
                        backgroundColor: Colors.green.withValues(
                          alpha: 0.25,
                        ),
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "${(collected * 100).toStringAsFixed(0)}% Collected",
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ===== VIEW BUTTON =====
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BillsView(
                          tenantModel: [
                            TenantModel(),
                            TenantModel(),
                            TenantModel(),
                          ],
                          postedData: roomBills[index],
                        ),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: bill.viewBtnColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "View Details",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: bill.viewBtnTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ================= HELPERS =================
  BoxDecoration _gradientBox() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      gradient: const LinearGradient(
        colors: [Color(0xFFAE36F3), Color(0xFF8B27E9)],
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.3),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }

  Widget _statBox({
    required String title,
    required String value,
    required String amount,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 10, color: color)),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(amount, style: TextStyle(fontSize: 10, color: color)),
          ],
        ),
      ),
    );
  }
}
