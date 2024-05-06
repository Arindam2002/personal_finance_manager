import 'package:flutter/foundation.dart';
import 'package:personal_finance_manager/models/Goal.dart';
import 'package:uuid/uuid.dart';

class GoalProvider with ChangeNotifier {
  List<Goal> _goals = [];
  var uuid = Uuid();

  List<Goal> get goals => _goals;

  void addGoal(Goal goal) {
    // set the id of the goal using uuid package
    goal.id = uuid.v4();
    _goals.add(goal);
    notifyListeners();
  }

  void updateGoal(Goal goal) {
    int index = _goals.indexWhere((element) => element.id == goal.id);
    _goals[index] = goal;
    notifyListeners();
  }

  void deleteGoal(String id) {
    _goals.removeWhere((goal) => goal.id == id);
    notifyListeners();
  }


}