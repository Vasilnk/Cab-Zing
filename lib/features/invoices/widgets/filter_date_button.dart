import 'package:cab_zing/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FilterDateButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const FilterDateButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.filterBackground,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.calendar_month,
                color: AppColors.filterSelection,
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
