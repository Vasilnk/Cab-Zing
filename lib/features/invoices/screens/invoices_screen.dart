import 'package:cab_zing/core/theme/app_colors.dart';
import 'package:cab_zing/features/invoices/models/invoice_model.dart';
import 'package:cab_zing/features/invoices/providers/invoice_provider.dart';
import 'package:cab_zing/features/invoices/screens/invoice_filter_screen.dart';
import 'package:cab_zing/features/invoices/widgets/active_filter_chips.dart';
import 'package:cab_zing/features/invoices/widgets/invoice_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => InvoicesScreenState();
}

class InvoicesScreenState extends State<InvoicesScreen> {
  final TextEditingController searchController = TextEditingController();
  InvoiceFilter activeFilter = const InvoiceFilter();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InvoiceProvider>().loadInvoices();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Invoices',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: AppColors.border),
        ),
      ),
      body: Consumer<InvoiceProvider>(
        builder: (context, provider, child) {
          final filteredList = getFilteredInvoices(provider.invoices);
          final customerNames =
              provider.invoices.map((inv) => inv.customerName).toSet().toList()
                ..sort();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              searchAndFilterSection(customerNames),
              const Divider(height: 1, color: AppColors.border),

              if (!activeFilter.isEmpty)
                ActiveFilterChips(
                  filter: activeFilter,
                  onClear: () =>
                      setState(() => activeFilter = const InvoiceFilter()),
                ),

              Expanded(child: invoiceListView(provider, filteredList)),
            ],
          );
        },
      ),
    );
  }

  Widget searchAndFilterSection(List<String> customerOptions) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.cardContent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) => setState(() => searchQuery = value),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
                decoration: const InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: AppColors.statusCancelled,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.statusCancelled,
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push<InvoiceFilter>(
                context,
                MaterialPageRoute(
                  builder: (_) => InvoiceFilterScreen(
                    initialFilter: activeFilter,
                    customerOptions: customerOptions,
                  ),
                ),
              );
              if (result != null) setState(() => activeFilter = result);
            },
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: AppColors.cardContent,
                borderRadius: BorderRadius.circular(12),
                border: activeFilter.isEmpty
                    ? null
                    : Border.all(color: AppColors.filterSelection, width: 1.5),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.filter_list,
                    color: AppColors.filterSelection,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Add Filters',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget invoiceListView(
    InvoiceProvider provider,
    List<InvoiceModel> invoices,
  ) {
    if (provider.isLoading && provider.invoices.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.filterSelection),
      );
    }

    if (invoices.isEmpty) {
      return const Center(
        child: Text(
          'No invoices found',
          style: TextStyle(
            color: AppColors.statusCancelled,
            fontSize: 14,
            fontFamily: 'Poppins',
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => provider.loadInvoices(),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: invoices.length,
        separatorBuilder: (c, index) =>
            const Divider(height: 1, color: AppColors.border),
        itemBuilder: (context, index) => InvoiceTile(invoice: invoices[index]),
      ),
    );
  }

  List<InvoiceModel> getFilteredInvoices(List<InvoiceModel> allInvoices) {
    return allInvoices.where((invoice) {
      if (searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        final matchNo = invoice.invoiceNo.toLowerCase().contains(query);
        final matchName = invoice.customerName.toLowerCase().contains(query);
        if (!matchNo && !matchName) return false;
      }

      if (activeFilter.statuses.isNotEmpty) {
        if (!activeFilter.statuses.contains(invoice.status)) return false;
      }

      if (activeFilter.customers.isNotEmpty) {
        if (!activeFilter.customers.contains(invoice.customerName)) {
          return false;
        }
      }

      if (activeFilter.startDate != null) {
        if (invoice.date.isBefore(activeFilter.startDate!)) return false;
      }
      if (activeFilter.endDate != null) {
        final endLimit = activeFilter.endDate!.add(const Duration(days: 1));
        if (invoice.date.isAfter(endLimit)) return false;
      }

      return true;
    }).toList();
  }
}
