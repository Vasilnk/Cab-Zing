import 'package:cab_zing/core/constants/app_assets.dart';
import 'package:cab_zing/core/theme/app_colors.dart';
import 'package:cab_zing/features/profile/providers/profile_provider.dart';
import 'package:cab_zing/features/profile/widgets/logout_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading && provider.profile == null) {
          return Container(
            height: 200,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(28),
            ),
            child: const CircularProgressIndicator(color: AppColors.accentTeal),
          );
        }

        final profile = provider.profile;

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(28),
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Row(
                children: [
                  ProfileImage(imageUrl: profile?.profileImage),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile?.fullName ?? 'No Name',
                          style: const TextStyle(
                            color: AppColors.textMain,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          profile?.email ?? 'No Email',
                          style: const TextStyle(
                            color: AppColors.accentLightBlue,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.penToSquare,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const StatusRow(),
              const SizedBox(height: 16),
              const LogoutButton(),
            ],
          ),
        );
      },
    );
  }
}

class ProfileImage extends StatelessWidget {
  final String? imageUrl;
  const ProfileImage({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(24),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset(AppAssets.profile, fit: BoxFit.cover),
              )
            : Image.asset(AppAssets.profile, fit: BoxFit.cover),
      ),
    );
  }
}

class StatusRow extends StatelessWidget {
  const StatusRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatusItem(
          color: AppColors.accentLightBlue,
          icon: Icons.star_border_rounded,
          title: '4.3',
          subtitle: '2,211 rides',
          titleSuffix: const Icon(Icons.star, color: Colors.white, size: 12),
        ),
        const SizedBox(width: 12),
        StatusItem(
          color: AppColors.accentTeal,
          icon: Icons.verified_user_outlined,
          title: 'KYC',
          subtitle: 'Verified',
          titleSuffix: const Icon(
            Icons.check_circle_outline,
            color: Colors.white,
            size: 12,
          ),
        ),
      ],
    );
  }
}

class StatusItem extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? titleSuffix;

  const StatusItem({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.titleSuffix,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 64,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(icon, color: AppColors.darkGreen, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (titleSuffix != null) ...[
                        const SizedBox(width: 2),
                        titleSuffix!,
                      ],
                    ],
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(color: color, fontSize: 11, height: 1.2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
