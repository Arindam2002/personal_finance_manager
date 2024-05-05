import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:personal_finance_manager/components/BalanceCard.dart';
import 'package:personal_finance_manager/components/GoalsCard.dart';
import 'package:personal_finance_manager/constants/constants.dart';
import 'package:personal_finance_manager/providers/GoalProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoalProvider()),
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
              child: Icon(Icons.add),
              label: 'Increment',
              onTap: () {},
            ),
            SpeedDialChild(
              child: Icon(Icons.remove),
              label: 'Decrement',
              onTap: () {},
            ),
            SpeedDialChild(
              child: Icon(Icons.refresh),
              label: 'Reset',
              onTap: () {},
            ),
          ],
        ),
        body: Container(
          decoration: kScaffoldDecoration,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              children: [
                BalanceCard(
                    currentBalance: 55000.20, income: 12000, expense: 10000),
                GoalsCard()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
