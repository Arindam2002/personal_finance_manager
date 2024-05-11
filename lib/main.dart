import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:personal_finance_manager/components/BalanceCard.dart';
import 'package:personal_finance_manager/components/GoalsCard.dart';
import 'package:personal_finance_manager/components/RecentTransactionsCard.dart';
import 'package:personal_finance_manager/constants/constants.dart';
import 'package:personal_finance_manager/providers/AccountProvider.dart';
import 'package:personal_finance_manager/providers/EventProvider.dart';
import 'package:personal_finance_manager/providers/GoalProvider.dart';
import 'package:personal_finance_manager/screens/AccountScreen.dart';
import 'package:personal_finance_manager/screens/NewTransaction.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoalProvider()),
        ChangeNotifierProvider(create: (context) => AccountProvider()),
        ChangeNotifierProvider(create: (context) => EventProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        final data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(
              textScaler: const TextScaler.linear(
                  1.0)), // This disables the text scaling factor
          child: child!,
        );
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: kPrimarySwatch,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: kPrimarySwatch,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: SpeedDial(
          overlayColor: kPrimaryColor,
          backgroundColor: kPrimaryLightColor,
          foregroundColor: kPrimaryTextColor,
          animatedIcon: AnimatedIcons.menu_close,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          spacing: 10,
          children: [
            SpeedDialChild(
              child: Icon(Icons.money_off),
              label: 'Add a transaction',
              onTap: () {
                // Add your code here to handle when the user taps on 'Expense'
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewTransaction(),
                  ),
                );
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.swap_horiz_rounded),
              label: 'Transfer money',
              onTap: () {
                // Add your code here to handle when the user taps on 'Savings'
              },
            ),
          ],
        ),
        body: Container(
          decoration: kScaffoldDecoration,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountScreen(),
                      ),
                    );
                  },
                  child: const BalanceCard(),
                ),

                const RecentTransactionsCard(),
                const SizedBox(height: 20),

                GoalsCard(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
