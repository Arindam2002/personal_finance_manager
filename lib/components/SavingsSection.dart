import 'package:flutter/material.dart';
import 'package:personal_finance_manager/constants/constants.dart';
import 'package:personal_finance_manager/utils/utils.dart';

class SavingsSection extends StatelessWidget {
  const SavingsSection({
    super.key, required this.title, required this.amount,
  });

  final String title;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: kGreyColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              formatAmount(amount),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: kPrimaryTextColor,
              ),
            ),
          ]
      ),
    );
  }
}