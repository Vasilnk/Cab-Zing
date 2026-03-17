import 'package:cab_zing/core/theme/app_colors.dart';
import 'package:cab_zing/features/invoices/models/invoice_model.dart';
import 'package:flutter/material.dart';

class InvoiceTile extends StatelessWidget {
  final InvoiceModel invoice;

  const InvoiceTile({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 57,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: 'Poppins',
                    ),
                    children: [
                      const TextSpan(
                        text: '#',
                        style: TextStyle(color: AppColors.textHint),
                      ),
                      TextSpan(
                        text: invoice.invoiceNo,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  invoice.customerName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                invoice.status.label,
                style: TextStyle(
                  color: invoice.status.color,
                  fontSize: 13,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 2),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                  children: [
                    const TextSpan(
                      text: 'SAR. ',
                      style: TextStyle(
                        color: AppColors.amountGrey,
                        fontSize: 12,
                      ),
                    ),
                    TextSpan(text: invoice.amount.toStringAsFixed(2)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
