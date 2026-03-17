import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'core/theme/app_theme.dart';
import 'core/services/secure_storage_service.dart';
import 'features/auth/services/auth_service.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/auth/presentation/screens/splash_screen.dart';
import 'features/landing/bottom_navigation_control.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            AuthService(SecureStorageService(FlutterSecureStorage())),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'cab_zing',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        initialRoute: '/splash',
        routes: {
          '/dashboard': (_) => const BottomNavigationControl(),
          '/splash': (_) => const SplashScreen(),
        },
      ),
    );
  }
}
