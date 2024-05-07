import 'package:flutter/material.dart';
import 'package:personal_finance_manager/utils/utils.dart';

class CashflowTile extends StatelessWidget {
  const CashflowTile({
    super.key, required this.title, required this.amount, required this.iconData, required this.titleFontSize, required this.amountFontSize, required this.iconSize, required this.iconRadius,

  });

  final String title;
  final double amount;
  final IconData iconData;
  final double titleFontSize;
  final double amountFontSize;
  final double iconSize;
  final double iconRadius;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.3),
            radius: iconRadius,
            child: Icon(
              iconData,
              size: iconSize,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formatAmount(amount),
              style: TextStyle(
                  fontSize: amountFontSize, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: titleFontSize, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
