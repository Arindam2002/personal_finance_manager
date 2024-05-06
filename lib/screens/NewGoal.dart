import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:personal_finance_manager/components/CustomTextFormField.dart';
import 'package:personal_finance_manager/components/IncrementButtonTile.dart';
import 'package:personal_finance_manager/constants/constants.dart';
import 'package:personal_finance_manager/models/Goal.dart';
import 'package:personal_finance_manager/providers/GoalProvider.dart';
import 'package:provider/provider.dart';

class NewGoalScreen extends StatefulWidget {
  NewGoalScreen({
    super.key,
    required this.isEditable, this.goal,
  });

  final bool isEditable;
  final Goal? goal;

  @override
  State<NewGoalScreen> createState() => _NewGoalState();
}

class _NewGoalState extends State<NewGoalScreen> {
  bool get isEditMode => widget.isEditable;

  final _formKey = GlobalKey<FormState>();

  // Define the form field controllers
  final _titleController = TextEditingController();
  final _targetAmountController = TextEditingController();
  final _monthlySavingsController = TextEditingController();
  final _targetCurrentAmountController = TextEditingController();

  bool _isLongTerm = false;
  late DateTime _targetDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.isEditable && widget.goal != null) {
      _titleController.text = widget.goal!.title;
      _targetAmountController.text = widget.goal!.targetAmount.toString();
      _targetCurrentAmountController.text = widget.goal!.currentAmount.toString();
      _targetDate = widget.goal!.targetTime;
      _isLongTerm = widget.goal!.isLongTerm;
      _monthlySavingsController.text = widget.goal!.monthlySavings.toString();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _targetAmountController.dispose();
    _monthlySavingsController.dispose();
    _targetCurrentAmountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: kScaffoldDecoration,
        ),
        actions: <Widget>[
          if (isEditMode) ...[
            PopupMenuButton<int>(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 1,
                  child: Text("Mark as Complete"),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text("Delete Goal", style: TextStyle(color: Colors.red),),
                ),
              ],
              onSelected: (value) {
                if (value == 1) {
                  showConfirmationDialog(
                      context: context,
                      dialogTitle: 'Mark as Complete',
                      onConfirm: () {
                        widget.goal?.isCompleted = true;
                        widget.goal?.currentAmount = widget.goal?.targetAmount;
                        Provider.of<GoalProvider>(context, listen: false).updateGoal(widget.goal!);
                        Navigator.pop(context);
                      }
                  );
                } else if (value == 2) {
                  // Open AlertDialog to confirm the deletion
                  showConfirmationDialog(
                      context: context,
                      dialogTitle: 'Delete Goal',
                      onConfirm: () {
                        Provider.of<GoalProvider>(context, listen: false).deleteGoal(widget.goal!.id);
                        Navigator.pop(context);
                      }
                  );
                }
              },
            ),
          ],
        ],
        iconTheme: IconThemeData(color: kPrimaryTextColor),
        title: Text(isEditMode ? 'Edit Goal' : 'Create a goal', style: TextStyle(color: kPrimaryTextColor),),
      ),
      body: Container(
        decoration: kScaffoldDecoration,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        formController: _titleController,
                          labelText: 'Title',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                      ),
                      const SizedBox(height: 30),

                      CustomTextFormField(
                        formController: _targetAmountController,
                        labelText: 'Target Amount (in ₹)',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a target amount';
                            }
                            if (value == '0') {
                              return 'Target amount cannot be zero';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                      ),
                      const SizedBox(height: 30),

                      CustomTextFormField(
                        formController: _targetCurrentAmountController,
                        labelText: 'Current Amount (in ₹)',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a current amount';
                          }
                          if (value == '0') {
                            return 'Current amount cannot be zero';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          IncrementButtonTile(targetCurrentAmountController: _targetCurrentAmountController, incrementAmount: 100,),
                          const SizedBox(width: 10,),
                          IncrementButtonTile(targetCurrentAmountController: _targetCurrentAmountController, incrementAmount: 500,),
                          const SizedBox(width: 10,),
                          IncrementButtonTile(targetCurrentAmountController: _targetCurrentAmountController, incrementAmount: 1000,),
                        ],
                      ),
                      const SizedBox(height: 20),

                      CustomTextFormField(
                        formController: _monthlySavingsController,
                        labelText: 'Monthly Savings (in ₹)',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a monthly savings amount';
                          }
                          if (value == '0') {
                            return 'Monthly savings amount cannot be zero';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          if (double.parse(value) > double.parse(_targetAmountController.text)) {
                            return 'Monthly savings cannot be more than the target amount';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Target Date',
                            style: TextStyle(color: Color(0xFF7f8180)),
                          ),
                          TextButton(
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: _targetDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2025),
                              ).then((pickedDate) {
                                if (pickedDate == null) {
                                  return;
                                }
                                setState(() {
                                  _targetDate = pickedDate;
                                });
                              });
                            },
                            child: Text(
                              DateFormat.yMMMd().format(_targetDate),
                              style: TextStyle(color: kPrimaryTextColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Long Term Goal',
                            style: TextStyle(color: Color(0xFF7f8180)),
                          ),
                          Switch(
                            value: _isLongTerm,
                            activeColor: kPrimaryColor,
                            activeTrackColor: kGoalsCardColor,
                            inactiveTrackColor: kPrimaryLightColor
                                .withOpacity(0.5),
                            onChanged: (value) {
                              setState(() {
                                _isLongTerm = value;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // ElevatedButton(
                      //   child: const Text('Cancel'),
                      //   onPressed: () {
                      //     if (!isEditMode) {
                      //       _titleController.clear();
                      //       _targetAmountController.clear();
                      //       _targetCurrentAmountController.clear();
                      //       _targetDate = DateTime.now();
                      //       _isLongTerm = false;
                      //       _monthlySavingsController.clear();
                      //     }
                      //
                      //     Navigator.pop(context);
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                child: Text(isEditMode ? 'Save Changes' : 'Add Goal'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final Goal goal = Goal(
                      id: isEditMode ? widget.goal!.id : "",
                      title: _titleController.text,
                      targetAmount: double.parse(_targetAmountController.text),
                      currentAmount: double.parse(_targetCurrentAmountController.text),
                      targetTime: _targetDate,
                      isLongTerm: _isLongTerm,
                      monthlySavings: double.parse(_monthlySavingsController.text),
                    );
                    !isEditMode
                        ? Provider.of<GoalProvider>(context, listen: false).addGoal(goal)
                        : Provider.of<GoalProvider>(context, listen: false).updateGoal(goal);
                    // Clear the form fields and close the screen
                    _titleController.clear();
                    _targetAmountController.clear();
                    _targetDate = DateTime.now();
                    _isLongTerm = false;
                    _monthlySavingsController.clear();

                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


void showConfirmationDialog(
    {required BuildContext context, required String dialogTitle, required Function onConfirm}) {
  showDialog(
    context: context,
    builder: (context) {
      return Theme(
        data: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blue,
          ),
        ),
        child: AlertDialog(
          title: Text(dialogTitle),
          content: Text('Are you sure you want to perform this action?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                onConfirm();
                Navigator.pop(context);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        ),
      );
    },
  );
}