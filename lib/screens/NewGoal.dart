import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_finance_manager/constants/constants.dart';
import 'package:personal_finance_manager/models/Goal.dart';
import 'package:personal_finance_manager/providers/GoalProvider.dart';
import 'package:provider/provider.dart';

class NewGoalScreen extends StatefulWidget {
  const NewGoalScreen({super.key});

  @override
  State<NewGoalScreen> createState() => _NewGoalState();
}

class _NewGoalState extends State<NewGoalScreen> {
  // Define a boolean flag to determine if the form is in 'Add' mode or 'Edit' mode
  bool isEditMode = false;

  // Define the form fields
  final _titleController = TextEditingController();
  final _targetAmountController = TextEditingController();
  late DateTime _targetDate = DateTime.now();
  final _monthlySavingsController = TextEditingController();
  final _targetInitialAmountController = TextEditingController();
  bool _isLongTerm = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: kScaffoldDecoration,
        ),
        iconTheme: IconThemeData(color: kPrimaryTextColor),
        title: Text(isEditMode ? 'Edit Goal' : 'Create a goal', style: TextStyle(color: kPrimaryTextColor),),
      ),
      body: Container(
        decoration: kScaffoldDecoration,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextFormField(
                    controller: _titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                    style: TextStyle(color: kPrimaryTextColor),
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(color: Color(0xFF7f8180)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextFormField(
                    controller: _targetAmountController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a target amount';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                    style: TextStyle(color: kPrimaryTextColor),
                    decoration: const InputDecoration(
                      labelText: 'Target Amount',
                      labelStyle: TextStyle(color: Color(0xFF7f8180)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ListTile(
                    title: Text(
                      'Target Date',
                      style: TextStyle(
                          color: Color(0xFF7f8180), fontSize: 12),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(_targetDate),
                      style: TextStyle(color: kPrimaryTextColor),
                    ),
                    trailing: Icon(
                        Icons.calendar_today, color: kPrimaryTextColor),
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          _targetDate = selectedDate;
                        });
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
                // Initial amount in the goal
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextFormField(
                    controller: _targetInitialAmountController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an initial amount';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                    style: TextStyle(color: kPrimaryTextColor),
                    decoration: const InputDecoration(
                      labelText: 'Initial Amount',
                      labelStyle: TextStyle(color: Color(0xFF7f8180)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
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
                SizedBox(height: 20),
                // Field asking how much amount to save per month
                // if the goal is long term
                if (_isLongTerm) ...[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextFormField(
                      controller: _monthlySavingsController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a monthly savings amount';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      style: TextStyle(color: kPrimaryTextColor),
                      decoration: const InputDecoration(
                        labelText: 'Monthly Savings',
                        labelStyle: TextStyle(color: Color(0xFF7f8180)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(height: 20),

                ],

                SizedBox(height: 20),

                ElevatedButton(
                  child: Text(isEditMode ? 'Save Changes' : 'Add Goal'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final goal = Goal(
                        title: _titleController.text,
                        targetAmount: double.parse(_targetAmountController.text),
                        currentAmount: double.parse(_targetInitialAmountController.text),
                        targetTime: _targetDate,
                        isLongTerm: _isLongTerm,
                        monthlySavings: double.parse(_monthlySavingsController.text),
                      );
                      Provider.of<GoalProvider>(context, listen: false).addGoal(goal);

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
                if (isEditMode) ...[
                  ElevatedButton(
                    child: Text('Delete Goal'),
                    onPressed: () {
                      // Handle the 'Delete' button press here...
                    },
                  ),
                  ElevatedButton(
                    child: Text('Mark as Complete'),
                    onPressed: () {
                      // Handle the 'Mark as Complete' button press here...
                    },
                  ),
                ],
                ElevatedButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    // Clear the form fields and close the screen
                    _titleController.clear();
                    _targetAmountController.clear();
                    _targetInitialAmountController.clear();
                    _targetDate = DateTime.now();
                    _isLongTerm = false;
                    _monthlySavingsController.clear();

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
