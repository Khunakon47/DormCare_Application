import 'package:flutter/material.dart';
import 'screen/main_tenant_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF367BF3),
          brightness: Brightness.light,
        ),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF367BF3),
          brightness: Brightness.dark,
        ),
      ),

      themeMode: ThemeMode.system,

      home: const MainTenantScreen(),
    ),
  );
}
