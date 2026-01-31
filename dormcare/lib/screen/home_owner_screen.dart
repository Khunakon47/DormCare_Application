import 'package:flutter/material.dart';

class HomeOwnerScreen extends StatelessWidget {
  const HomeOwnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Don't return Scaffold widget because in the main screen alread exist.
    return Center(
      child: Text("Test first Dada"),
    );
  }
}