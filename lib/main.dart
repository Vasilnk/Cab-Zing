import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'core/theme/app_theme.dart';
import 'core/services/secure_storage_service.dart';
import 'features/auth/services/auth_service.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/invoices/data/services/invoice_service.dart';
import 'features/invoices/providers/invoice_provider.dart';
import 'features/auth/presentation/screens/splash_screen.dart';
import 'features/landing/bottom_navigation_control.dart';
import 'features/profile/data/services/profile_service.dart';
import 'features/profile/providers/profile_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => SecureStorageService(const FlutterSecureStorage()),
        ),
        Provider(
          create: (context) => AuthService(context.read<SecureStorageService>()),
        ),
        Provider(
          create: (context) => InvoiceService(context.read<SecureStorageService>()),
        ),
        Provider(
          create: (context) => ProfileService(context.read<SecureStorageService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(context.read<AuthService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => InvoiceProvider(context.read<InvoiceService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(context.read<ProfileService>()),
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
