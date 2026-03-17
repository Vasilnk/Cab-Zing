import 'package:cab_zing/core/constants/app_assets.dart';
import 'package:cab_zing/core/theme/app_colors.dart';
import 'package:cab_zing/features/profile/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashHeader extends StatelessWidget {
  const DashHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(AppAssets.logo, fit: BoxFit.cover),
              const SizedBox(width: 10),
              const Text(
                'CabZing',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 2),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: AppColors.accentBlue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          // Avatar
          Consumer<ProfileProvider>(
            builder: (context, provider, child) {
              final imageUrl = provider.profile?.profileImage;

              return Stack(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: AppColors.avatarBg,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: imageUrl != null && imageUrl.isNotEmpty
                          ? Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Image.asset(
                                AppAssets.profile,
                                fit: BoxFit.contain,
                              ),
                            )
                          : Image.asset(AppAssets.profile, fit: BoxFit.contain),
                    ),
                  ),
                  Positioned(
                    right: 2,
                    top: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColors.accentOrange,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withValues(alpha: 0.7),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
