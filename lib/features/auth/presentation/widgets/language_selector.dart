import 'package:cab_zing/core/constants/app_assets.dart';
import 'package:cab_zing/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 32, right: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppAssets.languageVector,
              height: 22,
              width: 22,
            ),
            const SizedBox(width: 8),
            const Text(
              'English',
              style: TextStyle(color: AppColors.textMain, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
