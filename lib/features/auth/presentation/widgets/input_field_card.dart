import 'package:flutter/material.dart';
import 'package:cab_zing/core/theme/app_colors.dart';

class InputFieldCard extends StatelessWidget {
  const InputFieldCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardContent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(children: children),
    );
  }
}
