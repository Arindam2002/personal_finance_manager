import 'package:flutter/foundation.dart';
import 'package:personal_finance_manager/models/Goal.dart';
import 'package:uuid/uuid.dart';

class GoalProvider with ChangeNotifier {
  List<Goal> _goals = [];
  var uuid = const Uuid();

  List<Goal> get goals => _goals;

  List<Goal> fetchGoals() {
    // TODO: When fetching goals from the database, on the server side check if a month has passed since the goal was created, if yes, update the currentAmount and other fields accordingly like total balance, etc.
    return _goals;
  }

  void addGoal(Goal goal) {
    // set the id of the goal using uuid package
    goal.id = uuid.v4();  // TODO: When Backend is implemented, this will be set on the server side, an empty string will be sent from the client side
    goal.createdTime = DateTime.now();
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