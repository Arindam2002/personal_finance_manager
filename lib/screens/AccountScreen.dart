import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:personal_finance_manager/components/CashflowTile.dart';
import 'package:personal_finance_manager/components/SavingsSection.dart';
import 'package:personal_finance_manager/constants/constants.dart';
import 'package:personal_finance_manager/providers/AccountProvider.dart';
import 'package:personal_finance_manager/utils/utils.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: kScaffoldDecoration,
          ),
          iconTheme: IconThemeData(color: kPrimaryTextColor),
        ),
        body: Container(
          decoration: kScaffoldDecoration,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(children: [
              Column(
                children: [
                  Text(
                    formatAmount(
                        Provider.of<AccountProvider>(context).currentBalance),
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Text(
                    'Current Balance',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Card for income
                  Container(
                    height: 200,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.white70, width: 1.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                            child: Image.asset(
                              'assets/images/Profit.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                          child: Container(
                            color: Color(0xFF132422),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: CashflowTile(
                                title: 'Income',
                                amount: Provider.of<AccountProvider>(context)
                                    .monthlyIncome,
                                iconData: Icons.arrow_downward_rounded,
                                titleFontSize: 10.0,
                                amountFontSize: 12.0,
                                iconSize: 16,
                                iconRadius: 14,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Card for expense
                  Container(
                    height: 200,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.white70, width: 1.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                            child: Image.asset(
                              'assets/images/Loss.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                          child: Container(
                            color: Color(0xFF132422),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: CashflowTile(
                                title: 'Expense',
                                amount: Provider.of<AccountProvider>(context)
                                    .monthlyExpense,
                                iconData: Icons.arrow_upward_rounded,
                                titleFontSize: 10.0,
                                amountFontSize: 12.0,
                                iconSize: 16,
                                iconRadius: 14,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              // % of income spent
              Center(
                child: Text(
                  'You spent ${formatAmount(Provider.of<AccountProvider>(context).getMonthlySpentPercentage())}% of your income this month',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: kGreyColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // Card for savings
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.white70, width: 1.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: SavingsSection(
                              title: 'Emergency Funds',
                              amount: Provider.of<AccountProvider>(context)
                                  .emergencyFunds,
                            )
                          ),
                          Container(
                            height: 100,
                            width: 0.5,
                            color: Colors.white.withOpacity(0.2),
                          ),
                          Expanded(
                            child: SavingsSection(
                              title: 'Investments',
                              amount: Provider.of<AccountProvider>(context)
                                  .investments,
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 0.5,
                            color: Colors.white.withOpacity(0.2),
                          ),
                          Expanded(
                            child: SavingsSection(
                              title: 'Liquid Assets',
                              amount: Provider.of<AccountProvider>(context)
                                  .liquidSavings,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                      child: Container(
                        color: Color(0xFF132422),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CashflowTile(
                            title: 'Total Savings',
                            amount: 5000,
                            iconData: Icons.account_balance_wallet_outlined,
                            titleFontSize: 10.0,
                            amountFontSize: 12.0,
                            iconSize: 16,
                            iconRadius: 14,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
