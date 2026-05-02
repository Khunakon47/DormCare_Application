import 'package:flutter/material.dart';
import 'package:dormcare/theme/app_theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:dormcare/firebase_options.dart';
import 'package:dormcare/providers/user_provider.dart';

import 'package:dormcare/screen/owner/main_owner_screen.dart';
import 'package:dormcare/screen/owner/login_screen/login_owner_screen.dart';
import 'package:dormcare/screen/tenant/main_tenant_screen.dart';
import 'package:dormcare/screen/tenant/login_screen/login_tenant_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const DormCareApp());
}

class DormCareApp extends StatelessWidget {
  const DormCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
      ),
    );
  }
}
