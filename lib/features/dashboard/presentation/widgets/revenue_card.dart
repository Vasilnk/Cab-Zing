import 'package:cab_zing/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'revenue_chart.dart';

class RevenueCard extends StatefulWidget {
  const RevenueCard({super.key});

  @override
  State<RevenueCard> createState() => _RevenueCardState();
}

class _RevenueCardState extends State<RevenueCard> {
  int _selectedDay = 3; // 0-indexed, default = day "04" (Match image peak)

  @override
  Widget build(BuildContext context) {
    final selectedValue = _revenueData[_selectedDay];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(29),
      ),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                      children: const [
                        TextSpan(
                          text: 'SAR ',
                          style: TextStyle(color: AppColors.textSub),
                        ),
                        TextSpan(
                          text: '2,78,000.00',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 12, fontFamily: 'Poppins'),
                      children: const [
                        TextSpan(
                          text: '+21% ',
                          style: TextStyle(color: AppColors.success),
                        ),
                        TextSpan(
                          text: 'than last month.',
                          style: TextStyle(color: AppColors.textHint),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                'Revenue',
                style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Chart
          SizedBox(
            height: 180,
            child: RevenueChart(
              data: _revenueData,
              maxY: _chartMax,
              selectedIndex: _selectedDay,
              selectedValue: selectedValue,
              onSelect: (i) => setState(() => _selectedDay = i),
            ),
          ),
          const SizedBox(height: 12),
          // Month label
          Center(
            child: Text(
              'September 2023',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textHint,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Day selector
          DaySelector(
            days: List.generate(8, (i) => i + 1),
            selected: _selectedDay,
            onSelect: (i) => setState(() => _selectedDay = i),
          ),
        ],
      ),
    );
  }
}

class DaySelector extends StatelessWidget {
  final List<int> days;
  final int selected;
  final ValueChanged<int> onSelect;

  const DaySelector({
    super.key,
    required this.days,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(days.length, (i) {
        final isSelected = i == selected;
        return GestureDetector(
          onTap: () => onSelect(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.blueAction
                  : AppColors.cardBgSecondary,
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: Text(
              days[i].toString().padLeft(2, '0'),
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ),
        );
      }),
    );
  }
}

const List<double> _revenueData = [
  0.0,
  2400.0,
  2100.0,
  3945.0,
  2600.0,
  3200.0,
  2000.0,
  2500.0,
];
const double _chartMax = 4000;
