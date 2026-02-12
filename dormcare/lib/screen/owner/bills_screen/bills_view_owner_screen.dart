import 'package:dormcare/component/room_bottomsheet_filter.dart';
import 'package:dormcare/component/room_bottomsheet_sort.dart';
import 'package:dormcare/model/room_data_model.dart';
import 'package:dormcare/model/tenant_model.dart';
import 'package:dormcare/screen/owner/bills_screen/bills_edit_owner_screen.dart';
import 'package:flutter/material.dart';

class BillsView extends StatelessWidget {
  final List<TenantModel> tenantModel;
  final RoomDataModel postedData;

  const BillsView({
    super.key,
    required this.tenantModel,
    required this.postedData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Back", textAlign: TextAlign.left,),
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _headerCard(),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Wrap the search container with Expanded
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 12,
                      top: 5,
                      right: 5,
                      bottom: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 10),
                        Expanded(  // Also wrap TextField with Expanded
                          child: TextField(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              border: InputBorder.none, 
                              hintText: "Search by room or tenante...",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 8), // Add spacing between widgets

                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(context: context, 
                        builder: (context){
                          return SizedBox(
                            child: RoomBottomsheetFilter(),
                          );
                        }
                      );
                    },
                    icon: Icon(
                      Icons.filter_alt_outlined,
                      color: Colors.blue,
                      size: 32,
                    ),
                  ),
                ),

                const SizedBox(width: 8), // Add spacing between widgets

                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: ()=>{
                      showModalBottomSheet(context: context, 
                        builder: (context){
                          return SizedBox(
                            child: RoomBottomsheetSort(),
                          );
                        }
                      )
                    }, 
                    icon: Icon(
                      Icons.swap_vert,
                      size: 32,
                      color: Colors.purple,
                    )
                  )
                ),
              ],
            ),
            SizedBox(height: 15,),
            _buildRoomBills(tenantModel: tenantModel)

          ],
        ),
      ),
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

  // ================= HEADER =================
  Widget _headerCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      width: double.infinity,
      decoration: _gradientBox(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            postedData.postedMY,
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

  Widget _billRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildRoomBills({
    required List<TenantModel> tenantModel,
  }) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tenantModel.length,
      separatorBuilder: (_, _) => const SizedBox(height: 15),
      itemBuilder: (context, index) {
        final tenant = tenantModel[index];

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ===== ROOM INFO (placeholder) =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Text(
                      "Room A-101",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: tenant.statusPaid? Colors.greenAccent.withValues(alpha: 0.25): Colors.redAccent.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        tenant.statusPaid? "Paid": "Unpaid",
                        style: TextStyle(color: tenant.statusPaid? Colors.green: Colors.red,fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ],),
                  Text(
                    '${tenant.rentFee + tenant.waterBill + tenant.electricBill} THB',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),

              const SizedBox(height: 5),

              Text(
                tenant.username,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14, 
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 10),

              // ===== BILL DETAILS =====
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _billRow(
                      "Room Rent",
                      "${tenant.rentFee.toInt()} THB",
                    ),
                    _billRow(
                      "Water (${tenant.waterUnit} units)",
                      "${tenant.waterBill.toInt()} THB",
                    ),
                    _billRow(
                      "Electric (${tenant.electricUnit} units)",
                      "${tenant.electricBill.toInt()} THB",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // ===== ACTION BUTTONS =====
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Toggle Status",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BillsEditOwner(
                            tenant: tenant,
                          )
                        )),
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit_note, size: 22, color: Colors.white,),
                          SizedBox(width: 8),
                          Text(
                            "Edit Info",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
      },
    );
  }


}