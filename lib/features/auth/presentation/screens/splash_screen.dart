import 'package:cab_zing/core/theme/app_colors.dart';
import 'package:cab_zing/features/auth/presentation/providers/auth_provider.dart';
import 'package:cab_zing/features/landing/bottom_navigation_control.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkStatusAndNavigate();
  }

  Future<void> _checkStatusAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => authProvider.isLoggedIn
            ? const BottomNavigationControl()
            : const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          'Cab Zing',
          style: TextStyle(
            color: AppColors.textMain,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
