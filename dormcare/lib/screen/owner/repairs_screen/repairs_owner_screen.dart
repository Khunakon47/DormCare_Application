import 'package:dormcare/component/greeting_container.dart';
import 'package:dormcare/component/room_bottomsheet_filter.dart';
import 'package:dormcare/component/room_bottomsheet_sort.dart';
import 'package:dormcare/model/room_data_model.dart';
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
            bgColor: [
              Colors.purple,
              Colors.blue,
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                      const Icon(Icons.search, color: Colors.grey),
                      const SizedBox(width: 10),
                      Expanded(
                        // Also wrap TextField with Expanded
                        child: TextField(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search by room...",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
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
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(child: RoomBottomsheetFilter());
                      },
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
                  onPressed: () => {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(child: RoomBottomsheetSort());
                      },
                    ),
                  },
                  icon: Icon(Icons.swap_vert, size: 32, color: Colors.purple),
                ),
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: repair.repairStatus == 'completed'
                                ? Colors.greenAccent.withValues(alpha: 0.25)
                                : repair.repairStatus == 'pending'
                                ? Colors.orangeAccent.withValues(alpha: 0.25)
                                : Colors.redAccent.withValues(alpha: 0.25),
                          ),
                          child: Text(
                            repair.repairStatus,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: repair.repairStatus == 'completed'
                                  ? Colors.green
                                  : repair.repairStatus == 'pending'
                                  ? Colors.orange
                                  : Colors.red,
                            ),
                          ),
                        ),
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
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: Colors.purple,
                                width: 1.2,
                              ),
                              foregroundColor: Colors.purple,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => {},
                            child: Text(
                              'View Detail',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 10),

                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide.none,
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.purple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => {},
                            child: Text(
                              'Updat Status',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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
