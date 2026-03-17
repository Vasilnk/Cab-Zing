import 'package:cab_zing/core/constants/app_assets.dart';
import 'package:cab_zing/core/theme/app_colors.dart';
import 'package:cab_zing/features/alerts/alert_screen.dart';
import 'package:cab_zing/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:cab_zing/features/profile/screens/profile_screen.dart';
import 'package:cab_zing/features/routes/routes_screen.dart';
import 'package:cab_zing/features/profile/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigationControl extends StatefulWidget {
  const BottomNavigationControl({super.key});

  @override
  State<BottomNavigationControl> createState() =>
      _BottomNavigationControlState();
}

class _BottomNavigationControlState extends State<BottomNavigationControl> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const RoutesScreen(),
    const AlertScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: SafeArea(
          child: SizedBox(
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildNavItem(0, 'Dashboard', AppAssets.navHome),
                buildNavItem(1, 'Routes', AppAssets.navRoutes),
                buildNavItem(2, 'Alerts', AppAssets.navAlerts),
                buildNavItem(3, 'Profile', AppAssets.navProfile),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(int index, String label, String assetPath) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetPath,
              width: 24,
              height: 24,
              color: isSelected ? Colors.white : AppColors.navInactive,
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
