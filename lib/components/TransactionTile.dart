import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_finance_manager/constants/constants.dart';
import 'package:personal_finance_manager/models/Transaction.dart';
import 'package:personal_finance_manager/utils/utils.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;

  const TransactionTile({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Card(
        color: kGoalsCardColor,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: kPrimaryLightColor,
                      child: Icon(
                        categories[transaction.category]!,
                        color: kPrimaryTextColor,
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              transaction.description,
                              style: TextStyle(
                                color: kPrimaryTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              DateFormat.yMMMd().format(transaction.date),
                              style: TextStyle(
                                color: kPrimaryTextColor.withOpacity(0.7),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: transaction.category == 'Income'
                              ? Color(0xFF354a43)
                              : Color(0xFF4b3539),
                          child: Icon(
                            transaction.category == 'Income'
                                ? Icons.arrow_upward_rounded
                                : Icons.arrow_downward_rounded,
                            color: transaction.category == 'Income'
                                ? Colors.greenAccent
                                : Colors.redAccent,
                            size: 12,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          transaction.category == 'Income'
                              ? '+${formatAmount(transaction.amount)}'
                              : '-${formatAmount(transaction.amount)}',
                          style: TextStyle(
                            color: transaction.category == 'Income'
                                ? Colors.greenAccent
                                : Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}