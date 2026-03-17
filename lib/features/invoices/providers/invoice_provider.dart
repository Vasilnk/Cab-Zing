import 'package:cab_zing/features/invoices/data/services/invoice_service.dart';
import 'package:cab_zing/features/invoices/models/invoice_model.dart';
import 'package:flutter/material.dart';

class InvoiceProvider extends ChangeNotifier {
  final InvoiceService service;

  List<InvoiceModel> invoices = [];
  bool isLoading = false;
  String? error;

  InvoiceProvider(this.service);

  Future<void> loadInvoices() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      invoices = await service.fetchInvoices();
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
