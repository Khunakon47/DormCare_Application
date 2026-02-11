import 'package:dormcare/component/greeting_container.dart';
import 'package:dormcare/component/repair_card.dart';
import 'package:dormcare/model/repair_model.dart';
import 'package:flutter/material.dart';

class RepairTenantScreen extends StatefulWidget {
  const RepairTenantScreen({super.key});

  @override
  State<RepairTenantScreen> createState() => _RepairTenantScreenState();
}

class _RepairTenantScreenState extends State<RepairTenantScreen> {
  // Mock Data (ข้อมูลจำลอง)
  final List<RepairModel> _allRepairs = [
    RepairModel(
      id: '1',
      title: 'TV Broken',
      description: 'Screen is cracked and not turning on. Need replacement. just test to make it longer',
      date: 'Dec 10, 2024',
      imageUrl: 'https://picsum.photos/500/300?random=1',
      status: RepairStatus.completed,
    ),
    RepairModel(
      id: '2',
      title: 'Leaking Faucet',
      description: 'Water is dripping constantly in the bathroom sink.',
      date: 'Dec 12, 2024',
      imageUrl: 'https://picsum.photos/500/300?random=2',
      status: RepairStatus.inProgress,
    ),
    RepairModel(
      id: '3',
      title: 'Air Conditioner',
      description: 'Not cooling properly, making loud noise.',
      date: 'Jan 5, 2025',
      imageUrl: 'https://picsum.photos/500/300?random=3',
      status: RepairStatus.pending,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        color: const Color(0xFFF5F7FA),
        child: Column(
          children: [
            GreetingContainer(
              bgColor: [const Color(0xFF367BF3), const Color(0xFF2761E9)],
              title: "Welcome, JoBy",
              icon: Icon(Icons.waving_hand),
              subtitle: "Room 301 - Dorm 27",
            ),

            SizedBox(height: 16),

            Row(
              children: [
                // Search bar
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
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
                          color: Colors.grey
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: TextField(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search by room...",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // keyboardType: TextInputType.text, TextInputType.number, TextInputType.emailAddress
                            // default is .text
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 8), 

                // Filter button
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.filter_alt_outlined,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                ),

                const SizedBox(width: 8), 

                // Sort button
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () => {},
                    icon: Icon(Icons.swap_vert, size: 30, color: Colors.purple),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            Expanded(
              child: _allRepairs.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.build_circle_outlined,
                            size: 80,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "No repair history",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _allRepairs.length,
                      itemBuilder: (context, index) {
                        return RepairCard(
                          data: _allRepairs[index],
                          onTap: () {

                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: "Report new issue",
        backgroundColor: Color(0xFF367BF3),
        shape: const CircleBorder(),
        elevation: 8,
        highlightElevation: 12,
        child: Icon(Icons.add, color: Colors.white, size: 32),
      ),
    );
  }
}
