import 'package:flutter/foundation.dart';
import 'package:personal_finance_manager/models/Goal.dart';

class GoalProvider with ChangeNotifier {
  List<Goal> _goals = [];

  List<Goal> get goals => _goals;

  void addGoal(Goal goal) {
    _goals.add(goal);
    print('Goal added: ${goal}');
    notifyListeners();
  }
}