import 'package:cab_zing/core/theme/app_colors.dart';
import 'package:cab_zing/features/profile/widgets/menu_tile.dart';
import 'package:cab_zing/features/profile/widgets/profile_card.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const ProfileCard(),
              const SizedBox(height: 24),
              const MenuTile(icon: Icons.help_outline_rounded, label: 'Help'),
              const MenuTile(icon: Icons.manage_search_rounded, label: 'FAQ'),
              const MenuTile(
                icon: Icons.person_add_outlined,
                label: 'Invite Friends',
              ),
              const MenuTile(
                icon: Icons.policy_outlined,
                label: 'Terms of service',
              ),
              const MenuTile(
                icon: Icons.security_outlined,
                label: 'Privacy Policy',
                showDivider: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
