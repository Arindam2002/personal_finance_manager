import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_finance_manager/components/CashflowTile.dart';
import 'package:personal_finance_manager/constants/constants.dart';
import 'package:personal_finance_manager/providers/AccountProvider.dart';
import 'package:personal_finance_manager/utils/utils.dart';
import 'package:provider/provider.dart';

class BalanceCard extends StatelessWidget {

  const BalanceCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/images/wallet.png', fit: BoxFit.cover),
        Padding(
          padding: const EdgeInsets.only(top: 80.0, bottom: 50.0, left: 10.0, right: 10.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25),
                  ),
                  border: Border.all(color: Colors.white70, width: 1.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            formatAmount(Provider.of<AccountProvider>(context).currentBalance),
                            style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const Text(
                            'Current Balance',
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Divider(color: Colors.white.withOpacity(0.3)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CashflowTile(
                            title: 'Income',
                            amount: Provider.of<AccountProvider>(context).monthlyIncome,
                            iconData: Icons.arrow_downward_rounded,
                            titleFontSize: 12.0,
                            amountFontSize: 14.0,
                            iconSize: 20,
                            iconRadius: 16,
                          ),
                          CashflowTile(
                            title: 'Expense',
                            amount: Provider.of<AccountProvider>(context).monthlyExpense,
                            iconData: Icons.arrow_upward_rounded,
                            titleFontSize: 12.0,
                            amountFontSize: 14.0,
                            iconSize: 20,
                            iconRadius: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
