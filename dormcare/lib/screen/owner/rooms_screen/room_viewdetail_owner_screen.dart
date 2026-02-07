import 'package:dormcare/component/custom_textbutton.dart';
import 'package:dormcare/component/room_detail_container.dart';
import 'package:dormcare/component/tag.dart';
import 'package:dormcare/model/repair_tenant_model.dart';
import 'package:dormcare/model/room_data_model.dart';
import 'package:dormcare/model/room_detail_model.dart';
import 'package:dormcare/model/tenant_model.dart';
import 'package:dormcare/screen/owner/rooms_screen/room_editinfo_owner_screen.dart';
import 'package:flutter/material.dart';

class RoomViewdetail extends StatelessWidget{

  const RoomViewdetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final RoomDataModel roomData = RoomDataModel();
    final TenantModel tenantModel = TenantModel();
    
    final List<RepairTenant> maintenances = [
      const RepairTenant(
        title: "Room 301 - Air conditioner not cooling",
        date: 10,
        month: "Dec",
        year: 2024,
        statusIcon: Icon(Icons.check_circle_outline, color: Colors.green),
      ),

      const RepairTenant(
        title: "Room 300 - Light  bulb replacement (Bathroom)",
        date: 12,
        month: "Dec",
        year: 2024,
        statusIcon: Icon(Icons.access_time, color: Colors.orange),
      ),
    ];
    
    return Scaffold(

      appBar: AppBar(
        title: Text(
          "Room Number",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 16, right: 16, top: 16,
          bottom: 28,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Expanded(
              child: CustomTextbutton(
                textOnBtn: "Close",
                onPressed: ()=>Navigator.pop(context), 
                outLined: true,
                bgColor: [Colors.black],
                fgColor: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),

            SizedBox(width: 12,),

            Expanded(
              child: CustomTextbutton(
                textOnBtn: "Edit Info",
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RoomEditinfo(),
                  ),
                ),
                bgColor: [Colors.purple],
                fgColor: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 16,
                icon: Icon(Icons.edit_note),
                iconColor: Colors.white,
                iconSize: 26,
                spacing: 10,
              ),
            )

          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [

              SizedBox(
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: AspectRatio(
                        aspectRatio: 16/9,
                        child: Image.asset(
                          "assets/images/Flower.png",
                          fit: BoxFit.cover,
                        ),
                      )
                    ),

                    // Left button
                    Positioned(
                      left: 8,
                      child: FloatingActionButton(
                        backgroundColor: Colors.black.withValues(alpha: 0.75),
                        mini: true, 
                        heroTag: 'image_prev',
                        onPressed: () {},
                        child: const Icon(Icons.arrow_left, color: Colors.white, size: 40,),
                      ),
                    ),
                    // Right button
                    Positioned(
                      right: 8,
                      child: FloatingActionButton(
                        backgroundColor: Colors.black.withValues(alpha: 0.75),
                        mini: true, 
                        heroTag: 'image_next',
                        onPressed: () {},
                        child: const Icon(Icons.arrow_right, color: Colors.white, size: 34,),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10,),

              Row(
                children: [
                  Tag(type: StatusType.room, value: roomData.roomStats, text: roomData.roomStats),
                  SizedBox(width: 10,),
                  Tag(type: StatusType.room, value: roomData.roomType, text: roomData.roomType),
                  SizedBox(width: 10,),
                  Tag(type: StatusType.payment, value: tenantModel.statusPaid, text: tenantModel.statusPaid?"Paid":"Unpaid"),
                ],
              ),

              SizedBox(height: 10,),

              RoomDetailContainer(
                roomDetail: RoomDetailModel(
                  bgColor: Colors.blueAccent.withValues(alpha: 0.25), 
                  icon:Icon(Icons.person_outline), 
                  iconColor: Colors.blueAccent, 
                  title: "Tenant Information", 
                  details: {
                    'Full Name:': tenantModel.username,
                    'Phone Number:': tenantModel.phoneNumber,
                    'Email:': tenantModel.email,
                    'Move-in Date': tenantModel.moveinDate,
                    'Contract End': tenantModel.contractEnd,

                  }
                )
              ),

              SizedBox(height: 10,),

              RoomDetailContainer(
                roomDetail: RoomDetailModel(
                  bgColor: Colors.purpleAccent.withValues(alpha: 0.25), 
                  icon:Icon(Icons.house_outlined), 
                  iconColor: Colors.purple, 
                  title: "Room Details", 
                  details: {
                    'Room Number:': roomData.roomNumber.toString(),
                    'Floor:': roomData.roomFloor.toString(),
                    'Room Type:': roomData.roomType,
                    'Monthly Rent:': roomData.rentFee.toString(),
                    'Deposit:': roomData.deposit.toString(),
                  }
                )
              ),

              SizedBox(height: 10,),

              RoomDetailContainer(
                roomDetail: RoomDetailModel(
                  fgColor: Colors.green,
                  bgColor: Colors.greenAccent.withValues(alpha: 0.25), 
                  icon:Icon(Icons.house_outlined), 
                  iconColor: Colors.green, 
                  title: "Latest Bills (${roomData.postedMY})", 
                  details: {
                    'Rent Fee:': "${roomData.rentFee} THB",
                    'Water (${tenantModel.waterUnit}):': "${tenantModel.waterBill} THB",
                    'Electric Bill (${tenantModel.electricUnit}):': "${tenantModel.electricBill} THB",
                    'Total:': "${roomData.rentFee + tenantModel.waterBill + tenantModel.electricBill} THB",
                  },
                  status: {
                    'Status': Tag(type: StatusType.payment, value: tenantModel.statusPaid, text: tenantModel.statusPaid?"Paid":"Unpaid"),
                  }
                ),
                navBtn: true,
              ),

              SizedBox(height: 10,),

              RoomDetailContainer(
                roomDetail: RoomDetailModel(
                  fgColor: Colors.orange,
                  bgColor: Colors.orangeAccent.withValues(alpha: 0.25), 
                  icon:Icon(Icons.house_outlined), 
                  iconColor: Colors.orange, 
                  title: "Latest Maintences", 
                ),
                inListView: maintenances,
                navBtn: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

}