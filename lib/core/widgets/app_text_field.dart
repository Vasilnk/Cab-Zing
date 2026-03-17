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
    this.validator,
  });

  final String hint;
  final Widget icon;
  final bool obscureText;
  final TextEditingController? controller;
  final Widget? suffix;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 12),
          child: icon,
        ),
        Expanded(
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: const TextStyle(color: AppColors.textMain, fontSize: 15),
            decoration: InputDecoration(
              labelText: hint,
              labelStyle: const TextStyle(
                color: AppColors.textHint,
                fontSize: 14,
              ),
              border: InputBorder.none,
              suffixIcon: suffix,
            ),
          ),
        ),
      ],
    );
  }
}
