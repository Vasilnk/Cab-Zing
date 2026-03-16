import 'package:cab_zing/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.controller,
    this.suffix,
    this.errorText,
  });

  final String hint;
  final IconData icon;
  final bool obscureText;
  final TextEditingController? controller;
  final Widget? suffix;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 12),
          child: Icon(icon, color: AppColors.highlightAction, size: 22),
        ),
        Expanded(
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(color: AppColors.textMain, fontSize: 15),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: AppColors.textHint,
                fontSize: 14,
              ),
              border: InputBorder.none,
              errorText: errorText,
              suffixIcon: suffix,
            ),
          ),
        ),
      ],
    );
  }
}
