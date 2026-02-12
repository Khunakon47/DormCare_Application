import 'package:flutter/material.dart';

class ProfileOwnerScreen extends StatelessWidget {
  const ProfileOwnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> profileItems = [
      "Edit Profile",
      "Payment History",
      "Settings",
      "Help & Support",
    ];

    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(40),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.5),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFFA14CF3),
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Dorm Owner",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ListView.separated(
              shrinkWrap: true,

              itemCount: profileItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(profileItems[index]),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(color: Colors.grey.withValues(alpha: 0.3));
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
