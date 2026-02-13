import 'package:flutter/material.dart';
import 'screen/owner/main_owner_screen.dart';
import 'constants/dataset.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ownerTheme.primary,
          brightness: Brightness.light,
        ),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ownerTheme.primary,
          brightness: Brightness.dark,
        ),
      ),

      themeMode: ThemeMode.system,

      home: const MainOwnerScreen(),
    ),
  );
}