import 'package:flutter/material.dart';

class AccountProvider extends ChangeNotifier {
  double _currentBalance = 200000;
  double _monthlyIncome = 100000;
  double _monthlyExpense = 50000;

  double _emergencyFunds = 180000;
  double _investments = 50000;
  double _liquidSavings = 80000;

  double get currentBalance => _currentBalance;
  double get monthlyIncome => _monthlyIncome;
  double get monthlyExpense => _monthlyExpense;
  double get emergencyFunds => _emergencyFunds;
  double get investments => _investments;
  double get liquidSavings => _liquidSavings;

  void updateBalance(double amount) {
    _currentBalance = amount;
    notifyListeners();
  }

  double getMonthlySpentPercentage() {
    return ((_monthlyExpense / _monthlyIncome) * 100);
  }
}