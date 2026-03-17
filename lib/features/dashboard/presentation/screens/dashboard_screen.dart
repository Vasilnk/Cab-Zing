import 'package:cab_zing/features/dashboard/presentation/widgets/header.dart';
import 'package:cab_zing/features/dashboard/presentation/widgets/revenue_card.dart';
import 'package:cab_zing/features/dashboard/presentation/widgets/status_cards.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DashHeader(),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: RevenueCard(),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: StatusCards(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
