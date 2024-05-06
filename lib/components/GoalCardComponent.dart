import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:personal_finance_manager/constants/constants.dart';
import 'package:personal_finance_manager/models/Goal.dart';
import 'package:personal_finance_manager/utils/utils.dart';

class GoalCardComponent extends StatelessWidget {
  const GoalCardComponent({
    super.key,
    required this.goal,
  });

  final Goal goal;

  int calculateDaysLeft(double targetAmount, double? currentAmount, double? monthlySavings) {
    if (monthlySavings == null) {
      return 0;
    }
    double remainingAmount = targetAmount - (currentAmount ?? 0);
    return (remainingAmount / monthlySavings).ceil();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kGoalsCardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20.0, vertical: 20.0),
        child: Row(
          children: [
            // CircleAvatar(
            //   backgroundColor: Colors.white.withOpacity(0.3),
            //   radius: 16,
            //   child: Icon(
            //     goal.isLongTerm
            //         ? Icons.calendar_today
            //         : Icons.timer,
            //     color: Colors.white,
            //   ),
            // ),
            CircularPercentIndicator(
              radius: 30.0,
              lineWidth: 5.0,
              percent: goal.currentAmount! / goal.targetAmount,
              center: Text('${(goal.currentAmount! / goal.targetAmount * 100).toStringAsFixed(1)}%', style: TextStyle(color: kPrimaryTextColor, fontSize: 12.0, fontWeight: FontWeight.bold),),
              progressColor: kGoalProgressIndicatorColor,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(goal.title,
                        style: TextStyle(
                            color: kPrimaryTextColor,
                            fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text:
                              formatAmount(goal.currentAmount ?? 0.0),
                              style: TextStyle(
                                color: kPrimaryTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' / ',
                              style: TextStyle(
                                color: kPrimaryTextColor,
                              ),
                            ),
                            TextSpan(
                              text:
                              formatAmount(goal.targetAmount ?? 0.0),
                              style: TextStyle(
                                color: kPrimaryTextColor
                                    .withOpacity(0.7),
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // '${goal.targetTime.difference(DateTime.now()).inDays} days left',
                          // Calculate the number if days in which the goal will be achieved
                          '${calculateDaysLeft(goal.targetAmount, goal.currentAmount, goal.monthlySavings)} months left',
                          style: TextStyle(
                            color: kPrimaryTextColor.withOpacity(0.7),
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          goal.isLongTerm
                              ? 'Long Term'
                              : 'Short Term',
                          style: TextStyle(
                            color: kPrimaryTextColor.withOpacity(0.7),
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}