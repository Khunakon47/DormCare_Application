import 'package:dormcare/component/owner/custom_textbutton.dart';
import 'package:dormcare/component/owner/imagegallery_button.dart';
import 'package:dormcare/component/owner/room_detail_container.dart';
import 'package:dormcare/component/owner/room_editdetail_container.dart';
import 'package:dormcare/component/owner/tag.dart';
import 'package:dormcare/constants/dataset.dart';
import 'package:dormcare/model/owner/room_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RoomEditinfo extends StatelessWidget {
  final RoomModel room;

  const RoomEditinfo({super.key, required this.room});
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
          "Edit Room ${room.roomNumber}",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),

      /// ===== bottom buttons =====
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
                textOnBtn: "Save Info",
                bgColor: [Colors.purple],
                fgColor: Colors.white,
                fontWeight: FontWeight.w800,
                icon: Icon(Icons.save),
                iconColor: Colors.white,
              ),
            ),
          ],
        ),
      ),

      /// ===== body =====
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              /// image
              ImagegalleryButton(
                bgColor: [Colors.black.withValues(alpha: 0.75)],
                imagePath: room.imageUrl,
                heroTag: ['left_arrow', 'right_arrow'],
              ),

              SizedBox(height: 10),

              /// status tags
              Row(
                children: [
                  Tag(
                    type: StatusType.roomStatus,
                    value: occupied ? "occupied" : "empty",
                    text: occupied ? "Occupied" : "Available",
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

              /// tenant info
              RoomDetailContainer(
                boxShadowOn: false,
                icon: const Icon(Icons.person),
                title: "Tenant Information",
                bgColor: Colors.blueAccent.withValues(alpha: 0.25),
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

              /// room info
              RoomEditdetailContainer(
                boxShadowOn: false,
                bgColor: Colors.purpleAccent.withValues(alpha: 0.25),
                icon: Icon(Icons.house_outlined),
                iconColor: Colors.purple,
                title: "Room Details",
                details: {
                  'Room Number:': room.roomNumber,
                  'Floor:': room.roomFloor,
                  'Monthly Rent:': "${room.price} THB",
                  'Status:': occupied ? "Occupied" : "Available",
                },
              ),

              SizedBox(height: 10),

              /// bill edit
              if (latestBill != null)
                RoomEditdetailContainer(
                  fgColor: Colors.green,
                  boxShadowOn: false,
                  bgColor: Colors.greenAccent.withValues(alpha: 0.25),
                  icon: Icon(Icons.receipt_long),
                  iconColor: Colors.green,
                  title: "Latest Bill",
                  details: {
                    'Rent:': "${latestBill.rent} THB",
                    'Water:': "${latestBill.water} THB",
                    'Electric:': "${latestBill.electric} THB",
                    'Other:': "${latestBill.other} THB",
                  },
                  status: {
                    'Payment': Row(
                      children: [
                        CustomTextbutton(
                          textOnBtn: "Paid",
                          bgColor: [Colors.green],
                        ),
                        SizedBox(width: 10),
                        CustomTextbutton(
                          textOnBtn: "Unpaid",
                          fgColor: Colors.black,
                          outLined: true,
                        ),
                      ],
                    ),
                  },
                ),

              SizedBox(height: 10),

              /// repairs
              RoomEditdetailContainer(
                fgColor: Colors.orange,
                boxShadowOn: false,
                bgColor: Colors.orangeAccent.withValues(alpha: 0.25),
                icon: Icon(Icons.build),
                iconColor: Colors.orange,
                title: "Maintenance History",
                inListView: roomRepairs,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
