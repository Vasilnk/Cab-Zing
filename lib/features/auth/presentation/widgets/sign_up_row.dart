import 'package:flutter/material.dart';
import 'package:cab_zing/core/theme/app_colors.dart';

class SignUpRow extends StatelessWidget {
  const SignUpRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Don't have an Account?",
          style: TextStyle(color: AppColors.textMain, fontSize: 15),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Sign up now!',
            style: TextStyle(
              color: AppColors.highlightAction,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
