import 'package:flutter/material.dart';
import 'package:personal_finance_manager/models/Transaction.dart';
import 'package:uuid/uuid.dart';

class EventProvider with ChangeNotifier {
  List<Transaction> _transactions = [];
  var uuid = const Uuid();

  List<Transaction> get transactions => _transactions;

  void addTransaction(Transaction transaction) {
    transaction.id = uuid.v4();
    _transactions.add(transaction);
    notifyListeners();
  }
}