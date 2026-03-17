import 'package:cab_zing/core/theme/app_colors.dart';
import 'package:cab_zing/features/invoices/models/invoice_model.dart';
import 'package:flutter/material.dart';

class ActiveFilterChips extends StatelessWidget {
  final InvoiceFilter filter;
  final VoidCallback onClear;

  const ActiveFilterChips({
    super.key,
    required this.filter,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  if (filter.startDate != null)
                    ItemChip(
                      label:
                          '${filter.startDate!.day}/${filter.startDate!.month} – '
                          '${filter.endDate!.day}/${filter.endDate!.month}',
                    ),
                  ...filter.statuses.map((s) => ItemChip(label: s.label)),
                  ...filter.customers.map((c) => ItemChip(label: c)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onClear,
            child: const Text(
              'Clear',
              style: TextStyle(
                color: AppColors.highlightAction,
                fontSize: 13,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemChip extends StatelessWidget {
  final String label;

  const ItemChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.filterBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
