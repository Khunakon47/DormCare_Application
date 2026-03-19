import 'package:flutter/material.dart';
import 'screen/owner/main_owner_screen.dart';
import 'screen/owner/login_screen/login_owner_screen.dart';
import 'screen/tenant/main_tenant_screen.dart';
import 'screen/tenant/login_screen/login_tenant_screen.dart';

void main() {
  runApp(const DormCareApp());
}

class DormCareApp extends StatelessWidget {
  const DormCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      
      initialRoute: '/',
      routes: {
        '/': (_) => const LoginTenantScreen(),
        '/tenant/home': (_) => const MainTenantScreen(),
        '/login/owner': (_) => const LoginOwnerScreen(),
        '/owner/home': (_) => const MainOwnerScreen(),
      },
    );
  }
}
