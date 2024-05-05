import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_finance_manager/constants/constants.dart';
import 'package:personal_finance_manager/utils/utils.dart';

class BalanceCard extends StatelessWidget {
  final double currentBalance;
  final double income;
  final double expense;

  const BalanceCard({
    super.key,
    required this.currentBalance,
    required this.income,
    required this.expense,
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
                            '${formatAmount(currentBalance)}',
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
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white.withOpacity(0.3),
                                  radius: 16,
                                  child: const Icon(
                                    Icons.arrow_upward_rounded,
                                    size: 20,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${formatAmount(income)}',
                                    style: const TextStyle(
                                        fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    'Income',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white.withOpacity(0.3),
                                  radius: 16,
                                  child: const Icon(
                                    Icons.arrow_downward_rounded,
                                    size: 20,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${formatAmount(expense)}',
                                    style: const TextStyle(
                                        fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    'Expense',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
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
