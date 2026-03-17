import 'package:cab_zing/core/theme/app_colors.dart';
import 'package:cab_zing/features/invoices/models/invoice_model.dart';
import 'package:cab_zing/features/invoices/widgets/filter_date_button.dart';
import 'package:flutter/material.dart';

class InvoiceFilterScreen extends StatefulWidget {
  final InvoiceFilter initialFilter;
  final List<String> customerOptions;

  const InvoiceFilterScreen({
    super.key,
    required this.initialFilter,
    required this.customerOptions,
  });

  @override
  State<InvoiceFilterScreen> createState() => InvoiceFilterScreenState();
}

class InvoiceFilterScreenState extends State<InvoiceFilterScreen> {
  late InvoiceFilter filter;
  final List<String> periodOptions = [
    'This Month',
    'Last Month',
    'This Year',
    'Custom',
  ];

  @override
  void initState() {
    super.initState();
    filter = widget.initialFilter;
    if (filter.startDate == null) {
      _applyPeriodRange(filter.period);
    }
  }

  void _applyPeriodRange(String period) {
    final now = DateTime.now();
    DateTime? start, end;

    if (period == 'This Month') {
      start = DateTime(now.year, now.month, 1);
      end = DateTime(now.year, now.month + 1, 0);
    } else if (period == 'Last Month') {
      start = DateTime(now.year, now.month - 1, 1);
      end = DateTime(now.year, now.month, 0);
    } else if (period == 'This Year') {
      start = DateTime(now.year, 1, 1);
      end = DateTime(now.year, 12, 31);
    }

    if (start != null) {
      setState(() {
        filter = filter.copyWith(
          period: period,
          startDate: start,
          endDate: end,
        );
      });
    }
  }

  Future<void> _selectDate(bool isStartDate) async {
    final initial = isStartDate ? filter.startDate : filter.endDate;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) => Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: AppColors.filterSelection,
            surface: AppColors.cardContent,
          ),
        ),
        child: child!,
      ),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          filter = filter.copyWith(startDate: picked, period: 'Custom');
        } else {
          filter = filter.copyWith(endDate: picked, period: 'Custom');
        }
      });
    }
  }

  void _showSelectionModal({
    required String title,
    required List<String> options,
    required List<String> selected,
    required Function(String) onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0F1923),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: options.length,
          itemBuilder: (context, index) {
            final option = options[index];
            final isSelected = selected.contains(option);

            return ListTile(
              title: Text(
                option,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                ),
              ),
              trailing: isSelected
                  ? const Icon(Icons.check, color: AppColors.filterSelection)
                  : null,
              onTap: () {
                onSelect(option);
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
    );
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
          'Filters',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          const Icon(
            Icons.remove_red_eye_outlined,
            color: AppColors.highlightAction,
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => Navigator.pop(context, filter),
            child: const Center(
              child: Text(
                'Filter',
                style: TextStyle(
                  color: AppColors.highlightAction,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: AppColors.border),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 27),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildPeriodSelector(),
            const SizedBox(height: 16),
            _buildDateRangePicker(),
            const SizedBox(height: 20),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: 20),
            _buildStatusFilter(),
            const SizedBox(height: 20),
            _buildCustomerDropdown(),
            const SizedBox(height: 20),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: 20),
            _buildSelectedCustomersList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return GestureDetector(
      onTap: () => _showSelectionModal(
        title: 'Select Period',
        options: periodOptions,
        selected: [filter.period],
        onSelect: (p) => _applyPeriodRange(p),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.cardContent,
          borderRadius: BorderRadius.circular(41),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              filter.period,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'Poppins',
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRangePicker() {
    return Row(
      children: [
        FilterDateButton(
          label: _formatDate(filter.startDate),
          onTap: () => _selectDate(true),
        ),
        const SizedBox(width: 13),
        FilterDateButton(
          label: _formatDate(filter.endDate),
          onTap: () => _selectDate(false),
        ),
      ],
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '--/--/----';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Widget _buildStatusFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: InvoiceStatus.values
            .where((s) => s != InvoiceStatus.unknown)
            .map((status) => Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: _buildStatusButton(status),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildStatusButton(InvoiceStatus status) {
    final isActive = filter.statuses.contains(status);
    return GestureDetector(
      onTap: () {
        final current = List<InvoiceStatus>.from(filter.statuses);
        isActive ? current.remove(status) : current.add(status);
        setState(() => filter = filter.copyWith(statuses: current));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.filterSelection
              : AppColors.filterBackground,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          status.label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  Widget _buildCustomerDropdown() {
    return GestureDetector(
      onTap: () => _showSelectionModal(
        title: 'Select Customer',
        options: widget.customerOptions,
        selected: filter.customers,
        onSelect: (customer) {
          final current = List<String>.from(filter.customers);
          current.contains(customer)
              ? current.remove(customer)
              : current.add(customer);
          setState(() => filter = filter.copyWith(customers: current));
        },
      ),
      child: Container(
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 19),
        decoration: BoxDecoration(
          color: AppColors.cardContent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Customer',
              style: TextStyle(
                color: Color(0xFFAEAEAE),
                fontSize: 15,
                fontFamily: 'Poppins',
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedCustomersList() {
    if (filter.customers.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: filter.customers
          .map((name) => _buildCustomerTag(name))
          .toList(),
    );
  }

  Widget _buildCustomerTag(String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.filterBackground,
        borderRadius: BorderRadius.circular(41),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(width: 15),
          GestureDetector(
            onTap: () {
              final current = List<String>.from(filter.customers)..remove(name);
              setState(() => filter = filter.copyWith(customers: current));
            },
            child: const Icon(
              Icons.close,
              color: AppColors.highlightAction,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
