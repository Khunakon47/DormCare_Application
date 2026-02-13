import 'package:dormcare/component/owner/custom_textbutton.dart';
import 'package:dormcare/component/owner/imagegallery_button.dart';
import 'package:dormcare/component/owner/room_detail_container.dart';
import 'package:dormcare/component/owner/tag.dart';
import 'package:dormcare/constants/dataset.dart';
import 'package:dormcare/model/owner/room_model.dart';
import 'package:dormcare/screen/owner/rooms_screen/room_editinfo_owner_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RoomViewdetail extends StatelessWidget {
  final RoomModel room;

  const RoomViewdetail({super.key, required this.room});

  String safe(dynamic v) => v?.toString() ?? "-";
  String formatDate(DateTime? d){
    if (d == null) return "-";
    return DateFormat('dd MMM yyyy').format(d);
  }

  @override
  Widget build(BuildContext context) {
    final bool occupied = room.isOccupied;

    final roomBills =
        monthlyBills.where((b) => b.roomNumber == room.roomNumber).toList();
    final latestBill = roomBills.isNotEmpty ? roomBills.last : null;

    final roomRepairs =
        repairReports.where((r) => r.roomNumber == room.roomNumber).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Room ${room.roomNumber}",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),

      /// ===== BOTTOM BUTTONS =====
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 28),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: CustomTextbutton(
                textOnBtn: "Close",
                onPressed: () => Navigator.pop(context),
                outLined: true,
                fgColor: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: CustomTextbutton(
                textOnBtn: "Edit Info",
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RoomEditinfo(room: room,)),
                ),
                bgColor: [Colors.purple],
                fgColor: Colors.white,
                icon: Icon(Icons.edit_note),
                iconColor: Colors.white,
              ),
            ),
          ],
        ),
      ),

      /// ===== BODY =====
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              ImagegalleryButton(
                bgColor: [Colors.black.withValues(alpha: 0.75)],
                imagePath: room.imageUrl,
                heroTag: ['l_arrow', 'r_arrow'],
              ),

              SizedBox(height: 10),

              /// ===== STATUS TAGS =====
              Row(
                children: [
                  Tag(
                    type: StatusType.roomStatus,
                    value: occupied ? "occupied" : "empty",
                    text: occupied ? "Occupied" : "Vaccant",
                  ),
                  SizedBox(width: 10),
                  Tag(
                    type: StatusType.room,
                    value: room.roomType,
                    text: room.roomType,
                  ),
                  SizedBox(width: 10),
                  if (latestBill != null)
                    Tag(
                      type: StatusType.payment,
                      value: latestBill.isPaid,
                      text: latestBill.isPaid ? "Paid" : "Unpaid",
                    ),
                ],
              ),

              SizedBox(height: 10),

              /// ===== TENANT INFO =====
              RoomDetailContainer(
                boxShadowOn: false,
                bgColor: Colors.blueAccent.withValues(alpha: 0.25),
                icon: Icon(Icons.person_outline),
                iconColor: Colors.blueAccent,
                title: "Tenant Information",
                details: {
                  'Name:': safe(room.tenantName),
                  'Phone:': safe(room.tenantPhone),

                  if (occupied) ...{
                    'Email:': safe(room.tenantEmail),
                    'Move-in Date': formatDate(room.tenantMoveinDate),
                    'Contract end Date': formatDate(room.tenantContractEndDate),
                  }
                },
              ),

              SizedBox(height: 10),

              /// ===== ROOM DETAILS =====
              RoomDetailContainer(
                boxShadowOn: false,
                bgColor: Colors.purpleAccent.withValues(alpha: 0.25),
                icon: Icon(Icons.house_outlined),
                iconColor: Colors.purple,
                title: "Room Details",
                details: {
                  'Room Number:': room.roomNumber,
                  'Floor:': room.roomFloor,
                  'Monthly Rent:': "${room.price} THB",
                },
                status: {
                  'Room': Tag(
                    type: StatusType.roomStatus,
                    value: room.isOccupied? "Occupied" : "Available",
                    text: room.isOccupied ? "Occupied" : "Available",
                  )
                },
              ),

              SizedBox(height: 10),

              /// ===== BILL =====
              if (latestBill != null)
                RoomDetailContainer(
                  boxShadowOn: false,
                  iconColor: Colors.green,
                  icon: Icon(Icons.receipt_long),
                  bgColor: Colors.greenAccent.withValues(alpha: 0.25),
                  fgColor: Colors.green,
                  navBtn: true,
                  title: "Latest Bill",
                  details: {
                      'Rent:': "${latestBill.rent} THB",
                      'Water:': "${latestBill.water} THB",
                      'Electric:': "${latestBill.electric} THB",
                      'Other:': "${latestBill.other} THB",
                      'Total:':
                          "${latestBill.rent + latestBill.water + latestBill.electric + latestBill.other} THB",
                    },
                    status: {
                      'Payment': Tag(
                        type: StatusType.payment,
                        value: latestBill.isPaid,
                        text: latestBill.isPaid ? "Paid" : "Unpaid",
                      )
                    },
                ),

              SizedBox(height: 10),

              /// ===== REPAIRS =====
              RoomDetailContainer(
                boxShadowOn: false,
                fgColor: Colors.orange,
                bgColor: Colors.orangeAccent.withValues(alpha: 0.25),
                icon: Icon(Icons.build),
                iconColor: Colors.orange,
                title: "Maintenance Reports",
                inListView: roomRepairs,
                navBtn: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
