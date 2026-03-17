import 'package:cab_zing/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          "Profile",
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
