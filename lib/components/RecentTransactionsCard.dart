import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_finance_manager/components/TransactionTile.dart';
import 'package:personal_finance_manager/constants/constants.dart';
import 'package:personal_finance_manager/providers/EventProvider.dart';
import 'package:personal_finance_manager/utils/utils.dart';
import 'package:provider/provider.dart';

class RecentTransactionsCard extends StatelessWidget {
  const RecentTransactionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    var eventProvider = Provider.of<EventProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.black54.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Transactions',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryTextColor,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(80, 30)),
                      maximumSize:
                          MaterialStateProperty.all(const Size(100, 30)),
                    ),
                    child:
                        const Text('View All', style: TextStyle(fontSize: 12))),
              ],
            ),
            Container(
              height: 300,
              child: ListView.builder(
                itemCount: eventProvider.transactions.length,
                itemBuilder: (context, index) {
                  var transaction = eventProvider.transactions[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TransactionTile(transaction: transaction),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
