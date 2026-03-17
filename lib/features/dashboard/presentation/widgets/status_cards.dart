import 'package:cab_zing/core/constants/app_assets.dart';
import 'package:cab_zing/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StatusCards extends StatelessWidget {
  const StatusCards({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = [
      StatCardData(
        label: 'Bookings',
        value: '123',
        sub: 'Reserved',
        pillColor: AppColors.accentBeige,
        iconColor: AppColors.darkGreen,
        iconPath: AppAssets.bookings,
      ),
      StatCardData(
        label: 'Invoices',
        value: '10,232.00',
        sub: 'Rupees',
        pillColor: AppColors.accentTeal,
        iconColor: AppColors.darkGreen,
        iconPath: AppAssets.invoices,
      ),
    ];

    return Column(
      children: cards.map((c) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _StatCard(data: c),
        );
      }).toList(),
    );
  }
}

class StatCardData {
  final String label, value, sub, iconPath;
  final Color pillColor, iconColor;

  const StatCardData({
    required this.label,
    required this.value,
    required this.sub,
    required this.pillColor,
    required this.iconColor,
    required this.iconPath,
  });
}

class _StatCard extends StatelessWidget {
  final StatCardData data;
  const _StatCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(33),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Icon pill
          Container(
            width: 42,
            height: 72,
            decoration: BoxDecoration(
              color: data.pillColor,
              borderRadius: BorderRadius.circular(111),
            ),
            alignment: Alignment.center,
            child: Image.asset(
              data.iconPath,
              width: 20,
              height: 20,
              color: data.iconColor,
            ),
          ),
          const SizedBox(width: 14),
          // Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.accentBeige,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  data.value,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  data.sub,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
          // Arrow button
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.cardBgSecondary,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.arrow_forward,
              color: Color(0xFFD8D8D8),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
