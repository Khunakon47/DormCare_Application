import 'package:flutter/material.dart';

class ProfileOwnerScreen extends StatelessWidget {
  const ProfileOwnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  offset: const Offset(0, 2),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ]
            ),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.purple,
                  backgroundImage: AssetImage("assets/images/Flower.png"),
                  radius: 45,
                ),
                SizedBox(height: 10,),
                Text("username", style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),),
                SizedBox(height: 5,),
                Text("Room Number", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12),),
              ],
            ),
          ),

          SizedBox(height: 15,),

          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.phone, color: Colors.black,),
                  title: Text("phone", style: const TextStyle(fontWeight: FontWeight.normal)),
                  trailing: Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 26,),
                  onTap: () => {},
                ),
                Divider(color: Colors.grey,),
                ListTile(
                  leading: const Icon(Icons.phone, color: Colors.black,),
                  title: Text("phone", style: const TextStyle(fontWeight: FontWeight.normal)),
                  trailing: Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 26,),
                  onTap: () => {},
                ),
                Divider(color: Colors.grey,),
                ListTile(
                  leading: const Icon(Icons.phone, color: Colors.black,),
                  title: Text("phone", style: const TextStyle(fontWeight: FontWeight.normal)),
                  trailing: Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 26,),
                  onTap: () => {},
                ),
                Divider(color: Colors.grey,),
                ListTile(
                  leading: const Icon(Icons.phone, color: Colors.black,),
                  title: Text("phone", style: const TextStyle(fontWeight: FontWeight.normal)),
                  trailing: Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 26,),
                  onTap: () => {},
                ),
              ],
            ),
          )
          

        ],
      ),
    );
  }
}