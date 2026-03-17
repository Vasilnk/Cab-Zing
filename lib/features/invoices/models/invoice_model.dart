import 'package:cab_zing/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum InvoiceStatus {
  pending,
  invoiced,
  cancelled,
  unknown;

  String get label => {
        pending: 'Pending',
        invoiced: 'Invoiced',
        cancelled: 'Cancelled',
        unknown: 'Unknown',
      }[this]!;

  Color get color => {
        pending: AppColors.statusPending,
        invoiced: AppColors.statusInvoiced,
        cancelled: AppColors.statusCancelled,
        unknown: AppColors.textSub,
      }[this]!;
}

class InvoiceModel {
  final String invoiceNo, customerName;
  final double amount;
  final InvoiceStatus status;
  final DateTime date;

  const InvoiceModel({required this.invoiceNo, required this.customerName, required this.amount, required this.status, required this.date});

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    InvoiceStatus ps(String? s) {
      if (s == null) return InvoiceStatus.unknown;
      final v = s.toLowerCase();
      if (v == 'pending') return InvoiceStatus.pending;
      if (v == 'invoiced' || v == 'paid') return InvoiceStatus.invoiced;
      return v == 'cancelled' ? InvoiceStatus.cancelled : InvoiceStatus.unknown;
    }

    return InvoiceModel(
      invoiceNo: json['VoucherNo'] ?? '',
      customerName: json['CustomerName'] ?? json['LedgerName'] ?? 'Unknown',
      amount: (json['GrandTotal'] ?? json['GrandTotal_Rounded'] ?? 0.0).toDouble(),
      status: ps(json['Status'] ?? json['billwise_status']),
      date: json['Date'] != null ? DateTime.parse(json['Date']) : DateTime.now(),
    );
  }
}

class InvoiceFilter {
  final String period;
  final DateTime? startDate, endDate;
  final List<InvoiceStatus> statuses;
  final List<String> customers;

  const InvoiceFilter({this.period = 'Last Month', this.startDate, this.endDate, this.statuses = const [], this.customers = const []});

  bool get isEmpty => statuses.isEmpty && customers.isEmpty && startDate == null;

  InvoiceFilter copyWith({String? period, DateTime? startDate, DateTime? endDate, List<InvoiceStatus>? statuses, List<String>? customers}) =>
      InvoiceFilter(
        period: period ?? this.period,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        statuses: statuses ?? this.statuses,
        customers: customers ?? this.customers,
      );
}
