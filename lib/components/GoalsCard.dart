import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:personal_finance_manager/components/GoalCardComponent.dart';
import 'package:personal_finance_manager/constants/constants.dart';
import 'package:personal_finance_manager/models/Goal.dart';
import 'package:personal_finance_manager/providers/GoalProvider.dart';
import 'package:personal_finance_manager/screens/NewGoal.dart';
import 'package:provider/provider.dart';

class GoalsCard extends StatefulWidget {
  @override
  _GoalsCardState createState() => _GoalsCardState();
}

class _GoalsCardState extends State<GoalsCard> {
  List<Goal> goals = [];

  void _addGoal() {
    // Open a dialog box to enter the details for a new goal
    Navigator.push(context, MaterialPageRoute(builder: (context) => NewGoalScreen()));
    // When the user saves the new goal, add it to the list of goals
    //   append a random goal object in goals
    // setState(() {
    //   goals.add(Goal(
    //     title: 'Buy iPhone 15 Pro Max',
    //     targetAmount: 150000,
    //     currentAmount: 85000,
    //     targetTime: DateTime.now().add(const Duration(days: 30)),
    //     isLongTerm: false,
    //   ));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Color(0xFF2b3332),
        color: Colors.black54.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Active Goals',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryTextColor)),
                ElevatedButton(
                    onPressed: _addGoal,
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(80, 30)),
                      maximumSize:
                          MaterialStateProperty.all(const Size(100, 30)),
                    ),
                    child: Text('Add Goal', style: TextStyle(fontSize: 12))),
              ],
            ),
            Container(
              height: 300,
              child: ListView.builder(
                itemCount: Provider.of<GoalProvider>(context).goals.length,
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemBuilder: (context, index) {
                  Goal goal = Provider.of<GoalProvider>(context).goals[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: GoalCardComponent(goal: goal),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
