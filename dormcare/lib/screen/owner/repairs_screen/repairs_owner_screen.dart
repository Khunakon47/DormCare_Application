import 'package:dormcare/component/owner/custom_textbutton.dart';
import 'package:dormcare/component/owner/filter_sort.dart';
import 'package:dormcare/component/tenant/greeting_container.dart';
import 'package:dormcare/component/owner/room_bottomsheet_filter.dart';
import 'package:dormcare/component/owner/room_bottomsheet_sort.dart';
import 'package:dormcare/component/owner/search_box.dart';
import 'package:dormcare/component/owner/tag.dart';
import 'package:dormcare/constants/dataset.dart';
import 'package:dormcare/model/owner/room_data_model.dart';
import 'package:flutter/material.dart';

class RepairsOwnerScreen extends StatelessWidget {
  const RepairsOwnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<RoomDataModel> maintenance = [
      RoomDataModel(),
      RoomDataModel(),
      RoomDataModel(),
      RoomDataModel(),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          GreetingContainer(
            title: "Mainatenance",
            subtitle: "Manage all rooms and tenants",
            bgColor: ownerTheme.bgGradientColors,
          ),
          SizedBox(height: 15),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SearchBox(),
              const SizedBox(width: 8),
              FilterSort(
                iconColor: Colors.blue,
                icon: Icon(Icons.filter_alt_outlined),
                bgColor: Colors.white,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(child: RoomBottomsheetFilter());
                    },
                  );
                },
              ),

              const SizedBox(width: 8),

              FilterSort(
                icon: Icon(Icons.swap_vert,),
                iconColor: Colors.purple,
                bgColor: Colors.white,
                onPressed: () => {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(child: RoomBottomsheetSort());
                      },
                    ),
                  },
              ),
            ],
          ),

          SizedBox(height: 15),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final repair = maintenance[index];
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      offset: const Offset(0, 1),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(12),
                      child: AspectRatio(
                        aspectRatio: 2 / 1,
                        child: Image.asset(
                          "assets/images/Flower.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          repair.repairTitle,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Tag(type: StatusType.repair, value: repair.repairStatus, text: repair.repairStatus),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Room - ${repair.roomNumber}",
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 0.63),
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline_rounded,
                          color: Colors.black,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Text(
                          repair.userName,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.date_range, color: Colors.black, size: 20),
                        SizedBox(width: 10),
                        Text(
                          repair.postedDate,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          color: Colors.black,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Text(
                          repair.phoneNum,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomTextbutton(
                            fgColor: Colors.purple,
                            bgColor: [Colors.purple],
                            outLined: true,
                            textOnBtn: 'View Detail',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ) 
                        ),

                        SizedBox(width: 10),

                        Expanded(
                          child: CustomTextbutton(
                            fgColor: Colors.white,
                            bgColor: [Colors.purple],
                            textOnBtn: 'Update Status',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ) 
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, _) => const SizedBox(height: 10),
            itemCount: maintenance.length,
          ),
        ],
      ),
    );
  }
}
