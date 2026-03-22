import 'package:flutter/material.dart';
import 'screen/owner/main_owner_screen.dart';
import 'screen/owner/login_screen/login_owner_screen.dart';
import 'screen/tenant/main_tenant_screen.dart';
import 'screen/tenant/login_screen/login_tenant_screen.dart';
import 'package:dormcare/theme/app_theme.dart';

void main() {
  runApp(const DormCareApp());
}

class DormCareApp extends StatelessWidget {
  const DormCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      // เมื่อทำ Firebase auth แล้วค่อยเปลี่ยนมาใช้การ switch theme ตาม role หลัง login ระหว่าง AppTheme.tenantTheme() และ AppTheme.ownerTheme()
      theme: AppTheme.tenantTheme(),
      darkTheme: AppTheme.tenantTheme(),

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
